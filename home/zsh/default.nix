{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true; #{
    #  enable = true;
    #};
    enableCompletion = true;
    dotDir = ".config/zsh";
    #plugins = [
    #  {
    #    name = "fzf-tab";
    #    src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
    #  }
    #];
    initExtra = ''
alias ls='eza -lahF --color=always --icons'
alias wet='curl wttr.in/gomel'
alias ip='ip --color=auto'
alias cp="cp --reflink"
alias vim='nvim'
alias c='clear'






# auto cd on exiting lf with 'Q'
lf () {
    local tempfile="$(mktemp)"
    command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"

    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]]; then
          cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

if [[ "$(tty)" == "/dev/tty1" ]] || [["$(command -v Hyprland)"]]
then 
  Hyprland
fi

    '';
  };
}
