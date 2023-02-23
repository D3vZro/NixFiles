{ config, pkgs, lib, ... }:

{
  programs = {
    thefuck.enable = true;

    bash.promptInit = ''
      eval "$(starship init bash)"
    '';

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 2500;

      promptInit = ''
        eval "$(starship init zsh)"
      '';

      setOptions = [
        "AUTO_CD"
      ];
    };
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];

    variables = {
      EDITOR = "nvim";
      TERM = "alacritty";
    };

    shellAliases = {
      g-cl = "git clone";
      g-p = "git pull";
      g-ca = "git commit -a";

      ch-g = "cd ~/Git/";
      ch-gm = "cd ~/Git/Markdown";
      ch-gl = "cd ~/Git/LaTeX";
      ch-gf = "cd ~/Git/FOP";

      wm-name = "xprop | grep WM_CLASS";

      fl-update= "git pull && nix flake update";

      os-monitor = "gotop";
      os-update = "sudo nixos-rebuild switch --flake .#$HOST";
      os-off = "systemctl poweroff";
      os-suspend = "systemctl suspend";
      os-config = "cd ~/.nix/";
      os-gc = "sudo nix-collect-garbage";
      os-lsgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      ":q" = "exit";
    };
  };
}
