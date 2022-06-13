{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ../../../configuration/nord-twoLines.rasi;
    font = "BitstreamVeraSansMono Nerd Font 12";

    cycle = false;
    terminal = "alacritty";

    package = pkgs.rofi.override {
      plugins = [ 
        pkgs.rofi-calc 
        pkgs.rofi-power-menu 
      ]; 
    };

    extraConfig = {
      modi = "drun,calc,window,filebrowser";
    };
  };
}