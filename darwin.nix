{ pkgs, lib, ... }: {
  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;
  homebrew = {
    enable = true;
    casks = [
    ];
  };

  # Enable TouchID for Sudo with Tmux Fix
  environment = {
    etc."sudoers.d/000-sudo-touchid" = {
      text = ''
        Defaults pam_service=sudo-touchid
        Defaults pam_login_service=sudo-touchid
      '';
    };

    etc."pam.d/sudo-touchid" = {
      text = ''
        auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
        auth       sufficient     pam_tid.so
        auth       sufficient     pam_smartcard.so
        auth       required       pam_opendirectory.so
        account    required       pam_permit.so
        password   required       pam_deny.so
        session    required       pam_permit.so
      '';
    };
  };
}

