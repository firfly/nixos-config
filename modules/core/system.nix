{ self, pkgs, lib, config, inputs, ...}: 
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      warn-dirty = false;
      trusted-users = ["@wheel"];
      auto-optimise-store = true;
      max-jobs = "auto";
      log-lines = 20;
      user-agent-suffix = "NixOS unstable";
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        # cache mirror located in China
	# status: http://mirror.sjtu.edu.cn/
	# "https://mirror.sjtu.edu.cn/nix-channels/store"
	# status: https://mirrors.ustc.edu.cn/status/
	"https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://nix-gaming.cachix.org"
	];

      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://nixpkgs-wayland.cachix.org"
        "https://ros.cachix.org"
      ];

      trusted-public-keys = [
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" 
      ];
    # nix community`s cache server
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    extraOptions = lib.mkIf (config.age.secrets ? nix-access-tokens-github) ''
      !include ${config.age.secrets.nix-access-tokens-github.path}
    '';
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


  system.stateVersion = "24.05";
}
