{ pkgs, ... }:

{
  home.username = "mio-dokuhaki";
  home.homeDirectory = "/home/mio-dokuhaki";
  home.stateVersion = "25.11";

  programs.git.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;

  home.packages = with pkgs; [
    htop
  ];
}
