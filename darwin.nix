{ pkgs, lib, ... }: {

  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "bitwarden"
    ];
    brews = [
      "awscli"
      "bat"
      "checkov"
      "colima"
      "docker"
      "duf"
      "eza"
      "fzf"
      "iproute2mac"
      "kube-ps1"
      "kubernetes-cli"
      "lazygit"
      "neovim"
      "powerlevel10k"
      "ripgrep"
      "stern"
      "terraform"
      "terragrunt"
      "tmux"
      "tpm"
      "tree-sitter"
      "watch"
      "yq"
      "zoxide"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];
  };

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

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # allow quitting via ⌘ + Q; doing so will also hide desktop icons 
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
        AppleShowAllExtensions = true; # show all file extensions
      };

      # customize trackpad
      trackpad = {
        Clicking = true; # enable tap to click
        TrackpadRightClick = true; # enable two finger right click
      };

      # customize macOS
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key

        "com.apple.springing.enabled" = true; # enable springing
        "com.apple.springing.delay" = 0.0;

        # Appearance
        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 2; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false; # disable auto capitalization
        NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution
        NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution
        NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction
      };
    };
  };
}

