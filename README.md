![wallpaper](system/usr/share/sddm/themes/silent/backgrounds/d2.jpg)

# Conner's DOTFILES
This repo contains dotfiles for any of the customized tooling on my linux installations.

## Usage
Each subfoler in this project either contains an install script or is `stow`-able. These configs assume a XDG home folder setup (e.g. `~/Pictures` being a valid directory).

### Install Scripts
These folders will have an `install.sh` script for you to run.

```bash
cd system
./install.sh
```

### Stowable .configs
Any folder without an install script is able to be put in place simply by using the `stow` command.

> NOTE: Before stowing, please ensure any required packages have been installed. I have tried to make sure everything can be installed from a script, but some things may be missing.

```bash
stow noctalia
stow hyprland
```

## Best Solo Configs
* `nvim` - nvim with good LSP, treesitter, Telescope, and Harpoon setups (includes Vue 2 and Tailwind stuff too)

## Common Combos
This is a list of OS + tools with their corresponding subfolders for customization.

* CachyOS - Niri + Noctalia
  * assets, system, zsh, ghostty, niri, noctalia
* CachyOS - Hyprland + Noctalia
  * assets, system, zsh, ghostty, hyprland, noctalia

Wallpaper Credits: ![magnific.com](magnific.com)
