function alacconfig --wraps='cd ~/.config/alacritty/; nvim alacritty.toml' --description 'alias alacconfig=cd ~/.config/alacritty/; nvim alacritty.toml'
  cd ~/.config/alacritty/; nvim alacritty.toml $argv
        
end
