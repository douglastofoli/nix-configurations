{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    history = {
      size = 5000;
      ignoreDups = true;
    };

    initExtra = ''
      SPACESHIP_USER_SHOW=always
      SPACESHIP_PROMPT_ORDER=(
        user          # Username section
        dir           # Current directory section
        host          # Hostname section
        git           # Git section (git_branch + git_status)
        node
        rust
        docker
        hg            # Mercurial section (hg_branch  + hg_status)
        exec_time     # Execution time
        line_sep      # Line break
        vi_mode       # Vi-mode indicator
        jobs          # Background jobs indicator
        exit_code     # Exit code section
        char          # Prompt character
      )
      SPACESHIP_USER_SHOW=always
      SPACESHIP_PROMPT_ADD_NEWLINE=false
      SPACESHIP_CHAR_SYMBOL="❯"
      SPACESHIP_CHAR_SUFFIX=" "
      SPACESHIP_RUST_SYMBOL="🦀  "
      SPACESHIP_RUST_COLOR=red
    '';

    plugins = [
      {
        name = "spaceship-prompt";
        src = pkgs.spaceship-prompt;
        file = "share/zsh/themes/spaceship.zsh-theme";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "asdf"
        "git"
      ];
    };
  };
}
