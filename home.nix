{ pkgs, lib, ... }: {
  home.homeDirectory = lib.mkForce "/Users/luis.schweigard";
  home.username = lib.mkForce "luis.schweigard";
  home.stateVersion = "23.05"; # Required for some reason

  programs = {
    home-manager.enable = true;
  };

  # For zsh
  #     autosuggestion.enable = true;
  #     syntaxHighlighting.enable = true;

  home.packages = with pkgs; [
    fd
    htop
    jq
    k9s
    kubectl
    kubectx
    kubernetes-helm
    pre-commit
    sops
  ];
}
