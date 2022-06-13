{
  description = "A complete NixOS configuration for day-to-day use";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let 
      username = "zero";
      system = "x86_64-linux";
      share = [
        home-manager.nixosModules.home-manager
        ./machines/common.nix
        ./modules/default.nix
      ];
    in {
    nixosConfigurations = {
      nix-desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = share ++ [
          ./machines/desktop/hardware-configuration.nix

          ({ config, pkgs, lib, ... }: {
            networking.hostName = "nix-desktop";
            services.xserver.videoDrivers = [ "nvidia" ];

            virtualisation.libvirtd = {
              enable = true;

              qemu = {
                swtpm.enable = true;
                package = pkgs.qemu_kvm;
                ovmf.enable = true;
                runAsRoot = false;
              };
            };

            home-manager.users.${username} = { config, pkgs, ...}: {
              services.picom.extraOptions = ''
                xrender-sync-fence = true;
              '';
            };
          })
        ];
      };

      nix-notebook = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = share ++ [
          ./machines/notebook/hardware-configuration.nix

          ({ config, pkgs, lib, ... }: {
            networking.hostName = "nix-notebook";
            services.xserver.videoDrivers = [ "amdgpu" ];
            networking.networkmanager.wifi.powersave = true;
            programs.steam.enable = true;

            boot = {
              kernelModules = [ "acpi_call" ];
              loader.systemd-boot.consoleMode = pkgs.lib.mkForce "keep";

              extraModulePackages = with config.boot.kernelPackages; [
                acpi_call
              ];
            };

            powerManagement = {
              enable = true;
              cpuFreqGovernor = "powersave";
            };
  
            environment.systemPackages = with pkgs; [
              brightnessctl
            ];

            services = {
              tlp.enable = true;

              upower = {
                enable = true;
                usePercentageForPolicy = true;
                criticalPowerAction = "PowerOff";
              };
            };

            home-manager.users.${username} = { config, pkgs, ...}: {
              programs.alacritty.settings.font.size = pkgs.lib.mkForce 6;

              services.polybar.extraConfig = pkgs.lib.mkForce ''
                [bar/main]
                modules-left = bspwm sep title
                modules-center = 
                modules-right = volume sep backlight sep battery sep time sep
              '';
            };
          })
        ];
      };
      
      # Bare minimum
      HOSTNAME = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = share ++ [
          ./machines/HOSTNAME/hardware-configuration.nix

          ({ config, pkgs, lib, ... }: {
            # Include host-specific stuff here
          })
        ];
      };
    };
  };
}
