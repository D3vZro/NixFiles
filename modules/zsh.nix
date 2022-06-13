{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    histSize = 2000;
    autosuggestions.enable = true;

    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellInit = "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true";

    ohMyZsh = {
      enable = true;
    };

    shellAliases = {
      gcl = "git clone";
      gp = "git pull";
      gsu = "git submodule update";
      gca = "git commit -a";

      gg = "cd ~/Git/";
      ggm = "cd ~/Git/Markdown";
      ggl = "cd ~/Git/LaTeX";
      nih = "cd ~/.nix/";

      gt = "gotop";
      aus = "systemctl poweroff";
      stasis = "systemctl suspend";

      nixgc = "sudo nix-collect-garbage";
      nixfu = "nix flake update";
      nixls = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      ":q" = "exit";
    };
  };
}
