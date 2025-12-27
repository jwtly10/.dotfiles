function nvimconfig --wraps='cd ~/.config/nvim; nvim .' --description 'alias nvimconfig=cd ~/.config/nvim; nvim .'
  cd ~/.config/nvim; nvim . $argv
        
end
