function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set_color $fish_color_user
    echo -n $USER
    set_color normal

    if test "$CONTAINER_ID"
        echo -n 📦
        set_color $fish_color_host
        echo -n $CONTAINER_ID
    else
        echo -n @
        set_color $fish_color_host
        echo -n $hostname
    end
    set_color normal

    echo -n ':'

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    __terlar_git_prompt
    fish_hg_prompt

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '➤ '
    set_color normal
end
