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
    htop
    jq
    yq
    sops
    kubernetes-helm
    kubectl
    kubectx
    fd
    k9s
    pre-commit
  ];
}
