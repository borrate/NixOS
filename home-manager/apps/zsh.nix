{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      size = 100000;
      save = 100000;
      extended = true;
      ignoreAllDups = true;
    };
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
     profileExtra = ''
      setopt appendhistory
      setopt extendedglob
      setopt nomatch
      setopt notify
      setopt AUTO_PUSHD           # Push the current directory visited on the stack.
      setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
      setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
    '';
    completionInit = ''
      zmodload zsh/complist

      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      autoload -U compinit; compinit # Activate completion system
      _comp_options+=(globdots) # With hidden files

      setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
      setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
      setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

      # Ztyle pattern
      # :completion:<function>:<completer>:<command>:<argument>:<tag>

      # Define completers
      zstyle ':completion:*' completer _extensions _complete _approximate

      # Use cache for commands using cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      # Complete the alias when _expand_alias is used as a function
      zstyle ':completion:*' complete true

      zle -C alias-expension complete-word _generic
      bindkey '^Xa' alias-expension
      zstyle ':completion:alias-expension:*' completer _expand_alias

      # Use cache for commands which use it

      # Allow you to select in a menu
      zstyle ':completion:*' menu select

      # Autocomplete options for cd instead of directory stack
      zstyle ':completion:*' complete-options true

      zstyle ':completion:*' file-sort modification


      zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
      zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
      zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
      zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
      # zstyle ':completion:*:default' list-prompt '%S%M matches%s'

      # Only display some tags for the command cd
      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

      # Required for completion to be in good groups (named after the tags)
      zstyle ':completion:*' group-name '''

      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

      # See ZSHCOMPWID "completion matching control"
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      zstyle ':completion:*' keep-prefix true

      zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(''${=''${''${(f)"''$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

      autoload -U compinit
      compinit
    '';
    shellAliases = {
      rebuild="sudo nixos-rebuild switch";

      tat = "cd $(find ~/repos/ ~/repos/dentalsoft -maxdepth 1 -mindepth 1 -type d | fzf) && nvim";

      ls = "ls --color=auto";
      grep = "grep --color=auto";

      ll = "ls -lF --block-size=MB";
      la = "ls -A";
      l = "ls -CF";

      # git;
      gf = "git fetch";
      gfy = "git fetch &&";
      gst = "git status";
      gl = "git log";
      glol = "git log --oneline --graph --decorate";
      grb = "git rebase";
      gcm = "git commit";
      ga = "git add";
      gco = "git checkout";
      gplis = "git push --force-with-lease";

      cat = "bat";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.z-lua = {
    enable = true;
  };
}
