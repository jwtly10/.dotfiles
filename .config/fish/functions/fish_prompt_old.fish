function fish_prompt
    set_color normal
    set last_status $status
    
    # Current folder (basename only, not full path)
    #set_color magenta
    echo -n (pwd)
    #echo -n (basename (pwd))
    echo -n " "
    
    # Git status
    if command -v git >/dev/null
        set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
        if test -n "$git_branch"
            #set_color blue
            echo -n "git:"
            set_color cyan
            echo -n "($git_branch) "
        end
    end
    
    # Status indicator
    if test $last_status -eq 0
        #set_color green
    else
        #set_color red
    end
    
    #set_color yellow
    set_color normal
    echo -n "# "
    set_color normal
end
