{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-doom-emacs-unstraightened.hmModule];
  #  programs.emacs = {
  programs.emacs = {
    enable = true;
    #    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, op a version provided by the community overlay if desired.
    #    extraConfig = ''
    #      (setq standard-ident 2)
    #      '';
    #   doomDir = inputs.doom-config;
    package = pkgs.emacs29-pgtk;
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = true;
    socketActivation.enable = true;
    package = pkgs.emacs29-pgtk;
  };
}
