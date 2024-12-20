#!/usr/bin/env zsh

# Definitions
DOTFILES_DIR="${HOME}/.dotfiles"
DOTFILES_GIT_REMOTE="https://github.com/bradenmitchell/dotfiles_temp.git"

# Check if Xcode Command Line Tools installed
echo "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "Error: Xcode Command Line Tools not found. Use \`xcode-select --install\` to install manually and re-run setup." >&2
  exit 1
fi

# Check if dotfiles repository exists
echo "Checking for dotfiles repository..."
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles repository from Github..."
  git clone $DOTFILES_GIT_REMOTE $DOTFILES_DIR
fi

# Change to dotfiles directory
cd $DOTFILES_DIR

if [ $? -ne 0 ]; then
  echo "Error: Unable to change directory: $DOTFILES_DIR. Ensure dotfiles repository located at $DOTFILES_DIR and re-run setup" >&2
  exit 1
fi

# Check if Homebrew installed
echo "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  # Install Homebrew using non-interactive install
  echo "Installing Homebrew"

  # NOTE: Homebrew requires sudo privilages, but will install in non-interactive mode. Must ask for sudo access prior to running install script
  # Request sudo privilages
  echo "Administrator privilages required to install Homebrew."
  echo "Please enter administrator password..."
  sudo -v

  # Install Homebrew
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for this session
  echo "Configuring PATH for current session..."
  case "$(uname -m)" in
    arm64)  # Apple Silicon Mac
      echo "Homebrew PATH configured for Apple Silicon (arm64)."
      export PATH="/opt/homebrew/bin:$PATH"
      ;;
    x86_64)  # Intel-based Mac
      echo "Homebrew PATH configured for Intel (x86_64)."
      export PATH="/usr/local/bin:$PATH"
      ;;
    *)  # Unknown architecture
      echo "Error: Unknown system architecture: $(uname -m). PATH not configured. Check Homebrew config and re-run setup."
      exit 1
      ;;
  esac
fi

# Check that Homebrew is now accessible in current session
if ! command -v brew &>/dev/null; then
  echo "Error: Unable to locate Homebrew in PATH. Check Homebrew configuration and re-run setup." >&2
  exit 1
fi

# Install packages, applications and fonts
echo "Installing packges and applications via Homebrew bundle..."
brew bundle --no-lock --file="$DOTFILES_DIR/brew/Brewfile"

# Set brew directory as variable
BREW_DIR=$(brew --prefix)

# Check if Homebrew zsh is the default shell
echo "Checking Homebrew zsh set as default shell..."
if [ "$SHELL" != "$BREW_DIR/bin/zsh" ]; then 
  # Check if Homebrew zsh is in the allowed shells
  echo "Checking Homebrew zsh in allowed shells..."
  if ! grep -Fxq "$BREW_DIR/bin/zsh" /etc/shells; then
    # Add Homebrew zsh to allowed shells
    echo "Adding Homebrew zsh to allowed shells..."
    echo "$BREW_DIR/bin/zsh" | sudo tee -a /etc/shells >/dev/null
  fi

  # Set Homebrew zsh as default shell
  echo "Setting Homebrew zsh as defualt shell..."
  chsh -s "$BREW_DIR/bin/zsh"
fi

# Set ZDOTDIR in .zshenv
if [[ ! -f $HOME/.zshenv ]]; then
  echo "Configuring .zshenv file..."
  ZDOTDIR="$HOME/.config/zsh"
  echo -e "export ZDOTDIR=$ZDOTDIR" >> $HOME/.zshenv
fi

# Symlink zsh config
echo "Symlinking zsh config..."
ln -fs "$DOTFILES_DIR/zsh/.zshrc" "$ZDOTDIR/.zshrc"

# Symlink git global config
echo "Symlinking git config..."
ln -fs "$DOTFILES_DIR/git" "$HOME/.config/git"

# Presence of this file in HOME disables "Last login" message
touch ~/.hushlogin

# Change some HOME directory attributes
echo "Configuring Home directory attributes..."
[[ -d $HOME/Public ]] && chflags hidden $HOME/Public
[[ -d $HOME/Applications ]] && chflags hidden $HOME/Applications

# TODO: macOS system preferences

# TODO: Open applications, perform logins, software installs, etc... See Schafer dotfiles
