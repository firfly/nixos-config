{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "firfly";
    userEmail = "firfly.net@qq.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
