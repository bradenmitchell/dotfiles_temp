#!/usr/bin/env zsh

# Definitions
DOTFILES_DIR="${HOME}/.dotfiles"
DOTFILES_GIT_REMOTE="https://github.com/bradenmitchell/dotfiles.git"

# Check if Xcode Command Line Tools installed
echo "Checking if Xcode Command Line Tools are installed..."
if ! xcode-select -p &>/dev/null; then
  echo "Error: Xcode Command Line Tools not found"
  echo "Please install Xcode Command Line Tools manually and rerun this script"
  exit 1
else
  echo "Xcode Command Line Tools available"
fi

# Check if dotfiles repository exists
echo "Checking for dotfiles repository..."
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles repository from Github..."
  git clone $DOTFILES_GIT_REMOTE $DOTFILES_DIR
fi

# # Change to dotfiles directory
# cd $DOTFILES_DIR

# # Check if homebrew installed
# echo "Checking for homebrew"
# if ! command -v brew &>/dev/null; then
#   # Install homebrew using non-interactive install
#   echo "Installing homebrew"
#   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#   # Add homebrew to PATH for this session
#   echo "Configuring PATH for current session"
#   case "$(uname -m)" in
#     arm64)  # Apple Silicon Mac
#       echo "Homebrew PATH configured for Apple Silicon (arm64)."
#       export PATH="/opt/homebrew/bin:$PATH"
#       ;;
#     x86_64)  # Intel-based Mac
#       echo "Homebrew PATH configured for Intel (x86_64)."
#       export PATH="/usr/local/bin:$PATH"
#       ;;
#     *)  # Unknown architecture
#       echo "Error: Unknown system architecture: $(uname -m). PATH not configured."
#       exit 1
#       ;;
#   esac

# # Check that homebrew is now accessible in current session
# if ! command -v brew &>/dev/null; then
#   echo "Error: Unable to locate homebrew in PATH."
#   exit 1
# fi

# # Install packages, applications and fonts
# echo "Installing packges and applications via homebrew"
# brew bundle --no-lock --file="$DOTFILES_DIR/brew/Brewfile"

# # Set brew directory as variable
# BREW_DIR=$(brew --prefix)

# # Check if homebrew zsh is the default shell
# if [ "$SHELL" != "$BREW_DIR/bin/zsh" ]; then 
#   # Check if homebrew zsh is in the allowed shells
#   if ! grep -Fxq "$BREW_DIR/bin/zsh" /etc/shells; then
#     # Add Homebrew zsh to allowed shells
#     echo "Adding homebrew zsh to allowed shells"
#     echo "$BREW_DIR/bin/zsh" | sudo tee -a /etc/shells >/dev/null
#   fi

#   # Set homebrew zsh as default shell
#   echo "Setting homebrew zsh as defualt shell"
#   chsh -s "$BREW_DIR/bin/zsh"
# fi

# # Set ZDOTDIR in .zshenv
# if [[ ! -f $HOME/.zshenv ]]; then
#   echo "Creating .zshenv"
#   ZDOTDIR="$HOME/.config/zsh"
#   echo -e "export ZDOTDIR=$ZDOTDIR" >> $HOME/.zshenv
# fi

# # Symlink zsh config
# ln -fs "$DOTFILES_DIR/zsh/.zshrc" "$ZDOTDIR/.zshrc"

# # Symlink git global config
# ln -fs "$DOTFILES_DIR/git" "$HOME/.config/git"

# # Presence of this file in HOME disables "Last login" message
# touch ~/.hushlogin

# # Change some HOME directory attributes
# [[ -d $HOME/Public ]] && chflags hidden $HOME/Public
# [[ -d $HOME/Applications ]] && chflags hidden $HOME/Applications
