{ ... }:

{
  time.timeZone = "Asia/Baku";

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
}
