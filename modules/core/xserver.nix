{ pkgs, username, ... }: 
{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "colemak";
    xkb.options = "ctrl:nocaps";

  };
  services.displayManager.autoLogin = {
      enable = true;
      user = "${username}";
  };
  services.libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
