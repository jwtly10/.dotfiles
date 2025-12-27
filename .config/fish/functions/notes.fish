function notes
    if test (count $argv) -eq 0
        cd ~/notes
        nvim .
    else
        cd ~/notes
        nvim $argv[1].md
    end
end
