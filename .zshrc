export NVM_LAZY_LOAD=true
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/opt/idea-IU-233.11799.241/bin
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=/home/personal/bin:$PATH
export PATH=$PATH:/opt/homebrew/bin
export M2_HOME='/opt/apache-maven-3.9.6'
export PATH="$M2_HOME/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/bin/python3.12:$PATH"
export VISUAL=nvim
export EDITOR=nvim
# export SSL_CERT_FILE=$(python3 -m certifi)
export HNSWLIB_NO_NATIVE=1
export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"

# alias vim="nvim"
alias nvim="nvim"
setopt IGNORE_EOF

plugins=(git)

ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

alias home="cd ~"
alias proj="cd ~/Projects"

alias nvimconfig="cd ~/.config/nvim; nvim ."
alias vimconfig="cd ~/; vim .vimrc"

alias v="nvim ."
alias c="code ."

alias tmuxconfig="~;nvim .tmux.conf"
alias ghostconfig="~;nvim .config/ghostty/config"
alias tmuxsource="tmux source-file ~/.tmux.conf"

alias zshconfig="~; nvim .zshrc"
alias zshsource="source ~/.zshrc"

alias pyenv="source .venv/bin/activate"

alias gs="git status"
alias gc="git checkout"
alias gl='git log --pretty=format:"%C(yellow)%h %C(blue)%ad%C(red)%d %C(reset)%s%C(green) [%cn]" --date=short'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Angular stuff
source <(ng completion script)

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(direnv hook zsh)"

# Amp CLI
export PATH="/Users/personal/.amp/bin:$PATH"
