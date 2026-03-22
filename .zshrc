export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH=$HOME/.local/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export KUBECONFIGS="$HOME/.kube/all-configs"

export TZ="Europe/Moscow"
export EDITOR=nvim
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZSH_THEME="af-magic"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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

alias gen_tf_doc="terraform-docs markdown table --output-file README.md --output-mode inject"
alias hd="helm-docs"

alias sshcat="cat ~/.ssh/config"
alias sshedit="nvim ~/.ssh/config"
alias zshedit="nvim ~/.zshrc"
alias hosts="sudo nvim /etc/hosts"

# work
alias startvpn="echo '' && openvpn3 session-start --config ~/work.ovpn"
alias diskvpn="openvpn3 session-manage --disconnect --path"
