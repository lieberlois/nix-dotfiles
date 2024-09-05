{ pkgs, lib, ... }: {
  home.homeDirectory = lib.mkForce "/Users/luis.schweigard";
  home.username = lib.mkForce "luis.schweigard";
  home.stateVersion = "23.05"; # Required for some reason

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.htop
  ];
}
