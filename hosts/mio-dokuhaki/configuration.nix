{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  ];
  services.openssh.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}

