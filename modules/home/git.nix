{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "firfly";
    userEmail = "9134769+firfly@users.noreply.github.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
