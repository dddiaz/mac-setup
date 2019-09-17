# Mac Setup Script
# Daniel Diaz 2019
# Note: This script is idempotent.

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

echo "Making src directory to store source code."
mkdir -p ~/src

echo "Installing other brew stuff..."
# Nifty http lib
brew install httpie
brew install node
brew install kubernetes-cli
brew install terraform
brew install warrensbox/tap/tfswitch

echo "Installing Python 3"
# Install Python3
brew install python3

echo "Install python dependent packages"
# Install awscli with python3 not python 2
pip3 install awscli
# Install ansible
pip3 install ansible

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask"
brew tap caskroom/cask

echo "Installing Cask Apps"
brew cask install docker
brew cask install jetbrains-toolbox
brew cask install iterm2

echo "Copying dotfiles from Github"
cd ~
if [ -d ~/.dotfiles/ ]; then
  echo "Dotfiles Repo Exists"
  cd .dotfiles
  git pull
else
  echo "Dotfile Repo DNE"
  git clone https://github.com/dddiaz/dotfiles.git .dotfiles
  cd .dotfiles
fi
echo "Symlinking Dot Files...(Note this will override existing files)"
# remove the -f flag if you dont want to force override
ln -sfv ~/.dotfiles/.zshrc ~

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Oh My Zsh theme..."
# Set up powerline fonts so that i can render special chars
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
fi
if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

echo "Setting ZSH as shell..."
if [ "$SHELL" != "/bin/zsh" ]; then
  chsh -s /bin/zsh
fi

# Apps
apps=(
  aws
  ansible
  brew
  docker
  gitignore
  helm
  iterm2
  kubectl
  osx
)


echo "Setting some Mac settings..."

#"Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Showing all filename extensions in Finder by default 
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show all hidden files
defaults write com.apple.Finder AppleShowAllFiles true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

# TODO: move app bar to left

# TODO: show harddrive/homefolder in finder


# Run Once Stuff

# echo "Creating an SSH key for you..."
# ssh-keygen -t rsa
# echo "Please add this public key to Github \n"
# echo "https://github.com/account/ssh \n"
# read -p "Press [Enter] key after this..."

# Setting up iterm colors
# go to this site https://ethanschoonover.com/solarized/ to download color pallet
# import to iterm
#   iTerm → Preferences → Profiles → Colors → Color presets → Import
#   Then again, Color presets → you-color-scheme-name
# powerline fonts have already been installed, just need to switch to that font
#   iTerm2 → Preferences → Profiles → Text → Change Font
#   choose one of the meslo ones
# Fianlly customize powerlevel, which i actually ended up disabling.
# note i mostly folowed the guide here: https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961


killall Finder


echo "Done!"
