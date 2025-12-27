fish_add_path $HOME/bin /usr/local/bin
fish_add_path /opt/idea-IU-233.11799.241/bin
fish_add_path $HOME/.config/emacs/bin
fish_add_path $HOME/.local/bin
fish_add_path /home/personal/bin
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/bin/python3.12
fish_add_path /Users/personal/.nvm/versions/node/v22.11.0/bin
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x M2_HOME '/opt/apache-maven-3.9.6'
set -x PATH $M2_HOME/bin $JAVA_HOME/bin $PATH
set -x PATH '/opt/homebrew/bin' $PATH
set -x SHELL (which fish)
set -x PATH $HOME/.emacs.d/bin $PATH
set -gx PATH $PATH /Library/Frameworks/Python.framework/Versions/3.12/bin
set BAT_THEME 'Nord'
set -x EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases
alias proj="cd ~/Projects"
alias vim="nvim"
#alias nvim="vim"
alias nvimconfig="cd ~/.config/nvim; nvim ."
alias vimconfig="cd ~/; vim .vimrc"
alias v="vim ."
alias c="code ."
alias tmuxconfig="~;nvim .tmux.conf"
alias tmuxsource="tmux source-file ~/.tmux.conf"
alias fishconfig="cd ~/.config/fish; nvim config.fish"
alias ghostconfig="cd ~/.config/ghostty; nvim config"
alias zshconfig="cd ~/; nvim .zshrc"
alias aeroconfig="cd ~/; nvim .aerospace.toml"
alias zshsource="source ~/.zshrc"
alias sourcepy="source .venv/bin/activate.fish"
alias kittyconfig="cd ~/.config/kitty; nvim kitty.conf"
alias wezconfig="cd ~/; nvim .wezterm.lua"
alias alacconfig="cd ~/.config/alacritty/; nvim alacritty.toml"
alias tmuxsessionizer="~/.tmux-sessionizer.sh"
alias goland="/Applications/GoLand.app/Contents/MacOS"
alias mt5="cd /Users/personal/Library/Application\ Support/net.metaquotes.wine.metatrader5/drive_c/Program\ Files/MetaTrader\ 5"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gl="git log"
alias gd="git diff"
alias gco="git checkout"

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
# Do not show any greeting
functions --erase fish_greeting


function fish_right_prompt 
    # hide time
end

function fish_user_key_bindings
    # CTRL-F For tmux sessionizer (open projects in new tmux window)
    bind \cf 'tmuxsessionizer'
end

function __fzf_find_file
    set -l commandline (commandline)
    
    set files (find . -type f \
        -not -path "*/\.git/*" \
        -not -path "*/node_modules/*" \
        -not -path "*/\.venv/*" \
        -not -path "*/venv/*" \
        -not -path "*/dist/*" \
        -not -path "*/\.idea/*" \
        -not -path "*/\.settings/*" \
        -not -path "*/\.project/*" \
        -not -path "*/\.classpath/*" \
        -not -path "*/__pycache__/*" \
        -not -name "*.pyc" \
        -not -name "*.pyo" \
        -not -path "*/\.gradle/*" \
        -not -path "*/\.maven/*" \
        -not -path "*/\.npm/*" \
        -not -path "*/\.next/*" \
        -not -path "*/\.nuxt/*" \
        -not -path "*/\.pytest_cache/*" \
        -not -path "*/\.mypy_cache/*" \
        -not -name "*.egg-info" \
        -not -name ".DS_Store" \
        2>/dev/null | fzf --height 40% --reverse --layout=reverse)

    if test -n "$files"
        commandline -i "$files"
    end
    commandline -f repaint
end


# Color scheme
set -U fish_color_normal normal
set -U fish_color_command F8F8F2
set -U fish_color_quote F1FA8C
set -U fish_color_redirection 8BE9FD
set -U fish_color_end 50FA7B
set -U fish_color_error FF5555
set -U fish_color_param 5FFFFF
set -U fish_color_comment 6272A4
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion BD93F9
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

set PATH $PATH /Users/personal/.local/bin
starship init fish | source
direnv hook fish | source
