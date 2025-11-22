
export ZSH="$HOME/.oh-my-zsh"

export KUBECONFIGS=""

export EDITOR=vim
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias l="ls -la"

alias ktx="kubectx"
alias k="kubectl"
alias h="helm"
alias ks="kubeswitches"

alias d="docker"
alias dc="docker compose"

alias tf="terraform"
alias tg="terragrunt"

alias commit="git add . && git commit -am"
alias push="git push origin"
alias pullreb="git pull origin --rebase"

alias v="vault"
alias gen_tf_doc="terraform-docs markdown table --output-file README.md --output-mode inject"
alias hd="helm-docs"

alias sshconfig="cat ~/.ssh/config"