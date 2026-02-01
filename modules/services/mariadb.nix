{ pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    dataDir = "/var/lib/mysql";
  };

  environment.systemPackages = with pkgs; [
    mariadb
  ];
}
