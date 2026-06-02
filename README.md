![wallpaper](system/usr/share/sddm/themes/silent/backgrounds/marble.jpg)

# Conner's DOTFILES
This repo contains dotfiles for any of the customized tooling on my linux installations.

## Usage
Each subfoler in this project contains either a stowable `.config` folder or an install script. These configs assume a XDG home folder setup (e.g. `~/Pictures` being a valid directory).

### Stowable .configs
Any folder with a `.config` inside is able to be put in place simply by using the `stow` command.

> NOTE: Before stowing, please ensure any required packages have been installed. I have tried to make sure everything can be installed from a script, but some things may be missing.

```bash
stow noctalia
stow niri
```

### Install Scripts
Any folder without a `.config` inside will have an `install.sh` script for you to run.

```bash
cd system
./install.sh
```

Wallpaper Credits: ![magnific.com](magnific.com)
