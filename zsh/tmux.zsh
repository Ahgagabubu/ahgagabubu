if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ];then
    if [ ! -n "$TMUX" ];then
        tmux a -t 0 || tmux new -s 0
    fi
fi

