{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    # Add your personal git config
  };
}
