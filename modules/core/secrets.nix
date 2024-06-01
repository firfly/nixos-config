{ ... }:
{
  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
 #     gpg = {
 #       file = ../secrets/gpg.age;
 #       path = "/home/j4ger/.gpg/privateKey";
 #       owner = "j4ger";
 #       mode = "0600";
 #     };
 #     dae = {
 #       file = ../secrets/dae.age;
 #       mode = "0600";
 #       name = "dae.dae";
 #     };
      mihomo = {
        file = ../../secrets/mihomo.age;
        mode = "0600";
        name = "mihomo.yaml";
      };
    };
  };
}
