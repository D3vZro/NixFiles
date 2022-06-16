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
