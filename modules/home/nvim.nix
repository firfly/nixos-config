{ pkgs, inputs, ... }:
{
 # home.packages = [
 #   inputs.Neve.packages.${pkgs.system}.default
 # ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ spacevim ];
 #   extraConfig = ''
# "   set mouse=a
#    " Colemak some things
# "   nnoremap n j
#  "  nnoremap j n
#  "  nnoremap N J
#  "  nnoremap J N
#  "  nnoremap e k
#  "  nnoremap k e
#  "  nnoremap i l
#  "  nnoremap l i
#    '';
  };
}
