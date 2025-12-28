{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Preserve VRAM on suspend
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # Enable NVIDIA suspend/resume services
  systemd.services.nvidia-suspend.enable = true;
  systemd.services.nvidia-hibernate.enable = true;
  systemd.services.nvidia-resume.enable = true;
}
