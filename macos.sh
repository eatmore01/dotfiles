go install github.com/google/yamlfmt/cmd/yamlfmt@latest
brew install alesbrelih/gitlab-ci-ls/gitlab-ci-ls
#

git config --global core.excludesfile ~/.gitignore_global
#
#
# defaults write com.apple.finder QuitMenuItem -bool YES && killall Finder

# stop creatin .DS_Store file
# https://johnhalz.github.io/how_to/operating_systems_and_configs/stop_ds_store_file_creation/
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

#
brew install font-hack-nerd-font
