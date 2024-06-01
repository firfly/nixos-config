{ pkgs, username, ... }: 
{
  networking = {
    hostName = "${username}-nixos";
    networkmanager.enable = true;
    nameservers = [ "221.179.155.161" ];
    hosts = {
      "185.199,108.133" = ["raw.githubusercontent.com"];
      "185.199,109.133" = ["raw.githubusercontent.com"];
      "185.199,110.133" = ["raw.githubusercontent.com"];
      "185.199,111.133" = ["raw.githubusercontent.com"];
    };
    firewall = {
      enable = false;
      allowedTCPPorts = [ 22 80 443 59010 59011 ];
      allowedUDPPorts = [ 59010 59011 ];
      # allowedUDPPortRanges = [
        # { from = 4000; to = 4007; }
        # { from = 8000; to = 8010; }
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
