{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "mio-dokuhaki";

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.mio-dokuhaki = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = true;

  # swapDevices = [
  #   { device = "/dev/sda2"; }
  # ];

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
    fish
    fastfetch
    # greetd
    # tuigreet
  ];
  services.openssh.enable = true;
	#  services.greetd = {
	#    enable = true;
	#    useTextGreeter = true;
	#    restart = true;
	#    settings = {
	#      terminal = {
	#        vt = 1;
	#      };
	#      default_session = {
	#        command = "${pkgs.greetd}/bin/tuigreet --time --time-format '%Y/%m/%d (%a) %H:%M:%S' -r --remember-session --user-menu --theme 'title=yellow;border=magenta;text=cyan;prompt=green;time=red;action=green;button=yellow;container=black;input=red' --asterisks";
	# user = "greeter";
	#      };
	#    };
	#  };
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}

