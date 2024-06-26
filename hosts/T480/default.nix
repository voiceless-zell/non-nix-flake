{ pkgs, nixpkgs, inputs, config, ... }:
{
  imports = [
  ./hardware-configuration.nix
  ./../../nixos
  ];
  boot.kernelModules = [ "kvm-intel" ];
nixpkgs.config.allowUnfree = true;
 networking = {
    hostName = "T480";
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    videoDrivers = [  "nvidia"  ];
    desktopManager.gnome = {
        enable = true;
        };
    libinput = {
        enable = true;
        mouse = {
            accelProfile = "flat";
          };
      };
    };
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
        ];
      };
    };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.gvfs.enable = true;
}
