{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, op a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-ident 2)
      '';
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
}
