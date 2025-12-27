function fishconfig --wraps='cd ~/.config/fish; nvim config.fish' --description 'alias fishconfig=cd ~/.config/fish; nvim config.fish'
  cd ~/.config/fish; nvim config.fish $argv
        
end
