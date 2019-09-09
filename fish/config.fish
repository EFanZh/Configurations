set fish_prompt_pwd_dir_length 0

for x in $HOME/.cargo/bin $HOME/bin
    if [ -d $x ]
        set PATH (string match -v $x $PATH)
        set PATH $x $PATH
    end
end
