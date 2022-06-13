# Nixfiles - A full desktop, powered by Nix

![Screenshot](./screenshots/neofetch.png)

## Install

0. Follow the [NixOS installation manual](https://nixos.org/manual/nixos/stable/) up until chapter 2.3

1. Use the repo as a [template](https://github.com/TonyTheAce/open-dots/generate) and clone it

```
$ nix-env -iA nixos.git
$ git clone REPO
```

2. Generate `hardware-configuration.nix` inside a folder of the `machines` directory

```
$ cd NIXFILES
$ mkdir ./machines/HOSTNAME
$ nixos-generate-config --root /mnt --dir ./machines/HOSTNAME
$ rm ./machines/HOSTNAME/configuration.nix
```

4. Edit `./modules/` and `machines/common.nix` for localization/username/etc.

5. Edit `flake.nix` (See examples: `nix-laptop` and `nix-notebook`)

6. Commit your changes

7. Install with `# nixos-install --flake .#HOSTNAME` and reboot

## Components

- `nix` + `home-manager` + `flakes`

- Window manager: `bspwm` 

- Keyboard shortcuts: `sxhkd`

- Launcher: `rofi`

- Terminal: `zsh` with `alacritty`

- Editors: `neovim` (`nano` is also installed)

## Quirks

- If `polybar` has its workspaces missing, restart the service by `ctrl + alt + r`

- Aliases are found in `zsh.nix`

- Username is defined in `flake.nix` and `modules/default.nix`. Default is `zero`

- The default password is `nixfiles`. Change it with `passwd` after the first login when installed

- `picom` may cause problems

## Resources

- [Package/option search for NixOS](https://search.nixos.org)

- [Home-manager manual](https://rycee.gitlab.io/home-manager/)

- [awesome-nix](https://github.com/nix-community/awesome-nix)
