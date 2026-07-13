-- Detects the Vue major version (2 or 3) of the project that owns a buffer,
-- and builds a `root_dir` "gate" so a given LSP server only attaches in
-- projects of its matching version.
--
-- Used by lua/plugins/lsp.lua to route:
--   Vue 2 projects -> volar (frozen 1.8.27, takeover mode)
--   Vue 3 projects -> vue_ls + vtsls (Mason-managed, hybrid mode)
local M = {}

-- root dir -> detected major (2 or 3). Cached for the session.
local cache = {}

-- Read the `vue` dependency's major version from a package.json, or nil.
local function read_vue_major(pkg_path)
  local ok, lines = pcall(vim.fn.readfile, pkg_path)
  if not ok then
    return nil
  end
  local decoded, data = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not decoded or type(data) ~= "table" then
    return nil
  end
  local dep
  for _, field in ipairs({ "dependencies", "devDependencies" }) do
    if type(data[field]) == "table" and data[field].vue then
      dep = data[field].vue
      break
    end
  end
  if type(dep) ~= "string" then
    return nil
  end
  -- Strip range specifiers (^, ~, >=, "3.x", etc.) down to the first integer.
  local major = dep:match("(%d+)")
  return major and tonumber(major) or nil
end

-- Returns (major, root_dir) for a buffer. Walks up from the buffer's directory;
-- the nearest package.json that declares `vue` decides the version. If none
-- declares it, defaults to 3 rooted at the nearest package.json (or the cwd).
function M.detect(bufnr)
  bufnr = bufnr or 0
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local start = (fname ~= "" and vim.fs.dirname(fname)) or vim.uv.cwd()

  local dir = start
  local nearest_pkg_dir
  while dir and dir ~= "" do
    if cache[dir] ~= nil then
      return cache[dir], dir
    end
    local pkg = dir .. "/package.json"
    if vim.uv.fs_stat(pkg) then
      nearest_pkg_dir = nearest_pkg_dir or dir
      local major = read_vue_major(pkg)
      if major then
        cache[dir] = major
        return major, dir
      end
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end

  local root = nearest_pkg_dir or start
  cache[root] = 3
  return 3, root
end

-- Build a native (nvim 0.11+) root_dir callback that resolves the project root
-- only when the detected Vue major equals `want`; otherwise the server does not
-- attach for that buffer.
function M.gate(want)
  return function(bufnr, on_dir)
    local major, root = M.detect(bufnr)
    if major == want then
      on_dir(root)
    end
  end
end

return M
