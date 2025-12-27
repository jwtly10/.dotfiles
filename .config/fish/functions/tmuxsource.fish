function tmuxsource --wraps='tmux source-file ~/.tmux.conf' --description 'alias tmuxsource=tmux source-file ~/.tmux.conf'
  tmux source-file ~/.tmux.conf $argv
        
end
