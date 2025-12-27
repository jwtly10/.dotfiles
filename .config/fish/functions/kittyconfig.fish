function kittyconfig --wraps='cd ~/.config/kitty; nvim kitty.conf' --description 'alias kittyconfig=cd ~/.config/kitty; nvim kitty.conf'
  cd ~/.config/kitty; nvim kitty.conf $argv
        
end
