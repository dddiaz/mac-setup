# Mac Setup Script
# Daniel Diaz 2019
# Note: Homebrew should not be installed as root user.

echo "Installing xcode-select"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

# echo "Git config"
# git config --global user.name "Daniel Diaz"
# git config --global user.email <EMAIL>

echo "Installing other brew stuff..."
# Install Python3
brew install python3
# Nifty http lib
brew install httpie
brew install node

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask"
brew tap caskroom/cask

# echo "Copying dotfiles from Github"
# cd ~
# git clone git@github.com:bradp/dotfiles.git .dotfiles
# cd .dotfiles
# sh symdotfiles

# #Install Zsh & Oh My Zsh
# echo "Installing Oh My ZSH..."
# curl -L http://install.ohmyz.sh | sh

# echo "Setting up Oh My Zsh theme..."
# cd  /Users/bradparbs/.oh-my-zsh/themes
# curl https://gist.githubusercontent.com/bradp/a52fffd9cad1cd51edb7/raw/cb46de8e4c77beb7fad38c81dbddf531d9875c78/brad-muse.zsh-theme > brad-muse.zsh-theme

# echo "Setting up Zsh plugins..."
# cd ~/.oh-my-zsh/custom/plugins
# git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# echo "Setting ZSH as shell..."
# chsh -s /bin/zsh

# # Apps
# apps=(
#   alfred
#   bartender
#   bettertouchtool
#   cleanmymac
#   cloud
#   colloquy
#   cornerstone
#   diffmerge
#   dropbox
#   filezilla
#   firefox
#   google-chrome
#   harvest
#   hipchat
#   licecap
#   mou
#   phpstorm
#   private-internet-access
#   razer-synapse
#   sourcetree
#   steam
#   spotify
#   vagrant
#   iterm2
#   sublime-text2
#   textexpander
#   virtualbox
#   mailbox
#   vlc
#   skype
#   transmission
#   zoomus
#   onepassword
#   sequel-pro
#   chromecast
#   qlmarkdown
#   qlstephen
#   suspicious-package
# )


echo "Setting some Mac settings..."

#"Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Showing all filename extensions in Finder by default 
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv





killall Finder


echo "Done!"
