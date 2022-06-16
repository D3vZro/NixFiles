{ config, pkgs, lib, ... }:

{
  programs = {
    dconf.enable = true;
    # geary.enable = true; # My recommended mailclient

    gnupg = {
      dirmngr.enable = true;

      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "gtk2";
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.lightdm.enableGnomeKeyring = true;
  };

  networking = {
    firewall.enable = true;

    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
  };

  services = {
    # fstrim.enable = true; # For SSDs
    acpid.enable = true;
    gnome.gnome-keyring.enable = true;
    autorandr.enable = true;
    geoclue2.enable = true;
    blueman.enable = true;

    # openssh = {
    #   enable = true;
    #   allowSFTP = true;
    # };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Printing services
    # printing = {
    #   enable = true;
    #   browsing = true;
    #   drivers = with pkgs; [ ];
    # };

    # avahi = {
    #   enable = true;
    #   nssmdns = true;
    # };
  };
}
