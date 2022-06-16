{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      add_newline = false;

      right_format = "$time";

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vicmd_symbol = "[](bold yellow)";
      };

      username = {
        show_always = true;
        format = ''\[[$user]($style)'';
      };

      hostname = {
        ssh_only = false;
        format = ''@[$ssh_symbol$hostname]($style)\]'';
      };

      directory = {
        truncation_length = 6;
        format = ''\[[$path]($style)[$read_only]($read_only_style)\]'';
        read_only = " ";
      };

      git_branch = {
        symbol = " ";
        format = ''\[[$symbol$branch]($style)\]'';
      };

      git_status = {
        format = ''([\[$all_status$ahead_behind\]]($style))'';
      };

      haskell = {
        symbol = " ";
        format = ''\[[$symbol($version)]($style)\]'';
      };

      nix_shell = {
        symbol = " ";
        format = ''\[[$symbol$state(\($name\))]($style)\]'';
      };

      nodejs = {
        symbol = " ";
        format = ''\[[$symbol($version)]($style)\]'';
      };

      package = {
        symbol = " ";
        format = ''\[[$symbol$version]($style)\]'';
      };

      cmd_duration = {
        format = ''\[[鬒$duration]($style)\]'';
      };

      time = {
        disabled = false;
        format = ''\[[$time]($style)\]'';
       };
    };
  };
}
