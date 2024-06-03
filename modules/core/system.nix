{ self, pkgs, lib, inputs, ...}: 
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        # cache mirror located in China
	# status: http://mirror.sjtu.edu.cn/
	# "https://mirror.sjtu.edu.cn/nix-channels/store"
	# status: https://mirrors.ustc.edu.cn/status/
	"https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://nix-gaming.cachix.org"

	];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs = {
    overlays = [
      self.overlays.default
      inputs.nur.overlay
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    ranger
    nnn
    alacritty
    neovim
    nix-bash-completions
    unzip
    pkg-config
    jq
  ];

  environment.variables = {
    EDITOR = "nvim";
    http_proxy = "127.0.0.1:7890";
    https_proxy = "127.0.0.1:7890";
    all_proxy = "127.0.0.1:7890";
  };

  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-rime fcitx5-chinese-addons ];
    };


  };

  nixpkgs.config.allowUnfree = true;


  system.stateVersion = "23.05";
}
