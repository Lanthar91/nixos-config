{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/boot.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix

    ../../modules/hardware/nvidia.nix

    ../../modules/desktop/common.nix
    ../../modules/desktop/environments/gnome
    ../../modules/desktop/stylix.nix

    ../../modules/users/el

    ../../modules/dev.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  system.stateVersion = "26.05";
}
