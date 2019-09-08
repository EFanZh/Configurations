for x in $HOME/.cargo/bin $HOME/bin
    if [ -d $x ] && not contains $x $PATH
        set -gx PATH $x $PATH
    end
end
