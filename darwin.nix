{ pkgs, lib, ... }: {

  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  programs.zsh.enable = true;

  # homebrew = {
  #   enable = true;
  #   casks = [
  #   ];
  # };

  # Enable TouchID for Sudo with Tmux Fix
  # security.pam.enableSudoTouchIdAuth = true;  -- this doesnt work with TMUX

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

  # MacOS Settings
  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      # customize dock
      dock = {
        tilesize = 36; # Set the icon size of Dock items to 36 pixels
        mineffect = "scale"; # Change minimize/maximize window effect
        enable-spring-load-actions-on-all-items = true; # Enable spring loading for all Dock items
        expose-animation-duration = 0.1; # Speed up Mission Control animations
        expose-group-by-app = false; # Do not group windows by application in Mission Control
        autohide = true; # automatically hide and show the dock
        autohide-time-modifier = 0.0; # Remove the auto-hiding Dock delay
        autohide-delay = 0.0; # Remove the auto-hiding Dock delay
        show-process-indicators = true; # Show indicator lights for open applications in the Dock
        show-recents = false; # do not show recent apps in dock
        showhidden = false; # Make Dock icons of hidden applications translucent
        # do not automatically rearrange spaces based on most recent use.
        mru-spaces = false;
      };

    };
  };
}

