{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    userName = "douglastofoli";
    userEmail = "tofoli.douglas@hotmail.com";
    signing = {
      gpgPath = "${pkgs.gnupg}/bin/gpg2";
      key = "3FDD6AE4ED4461CC";
      signByDefault = false;
    };
    aliases = {
      p = "push";
      s = "status";
      c = "commit";
      co = "checkout";
      st = "stash";
      b = "branch";
      lg = "log --graph --oneline --decorate --abbrev-commit";
    };
    extraConfig = {
      github = { user = "douglastofoli"; };
      grep = { linenumber = true; };
      merge = { log = true; };
      rebase = { autosquash = true; };
      fetch = { prune = true; };
      push = { default = "current"; };
      apply = { whitespace = "nowarn"; };
      help = { autocorrect = 0; };
      user = { username = "douglastofoli"; };
      init = { defaultBranch = "main"; };
      pull = { rebase = false; };
      log = {
        follow = true;
        abbrevCommit = true;
      };
      core = {
        editor = "emacs";
        autocrlf = "input";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      color = {
        grep = "auto";
        branch = "auto";
        diff = "auto";
        status = "auto";
        showBranch = "auto";
        interactive = "auto";
        ui = "auto";
      };
    };
  };
}
