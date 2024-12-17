# Note: initialization code that may require console input (password prompts, [y/n]
#       confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES_DIR="$HOME/.dotfiles"
export EDITOR="nano"
export VISUAL="code"

source "$DOTFILES_DIR/zsh/aliases.zsh"

HISTSIZE=5000         # Number of commands in memory
SAVEHIST=5000         # Number of commands to save to HISTFILE
ZLE_RPROMPT_INDENT=0  # Remove right prompt padding

setopt AUTO_CD            # Automatically `cd` into directories by name
setopt CORRECT            # Autocorrect minor typos
setopt APPEND_HISTORY     # Append to HISTFILE
setopt INC_APPEND_HISTORY # Append command to HISTFILE immediately
setopt SHARE_HISTORY      # Share history between all running sessions
setopt HIST_IGNORE_DUPS   # Ignore consecutive duplicate entries
setopt HIST_IGNORE_SPACE  # Ignore commands that start with a space
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# NOTE: zsh-syntax-highlighting must be loaded before this
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# History substring search options
bindkey '^[[A' history-substring-search-up    # Binds UP arrow
bindkey '^[[B' history-substring-search-down  # Binds DOWN arrow

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f $DOTFILES_DIR/zsh/p10k.zsh ]] && source $DOTFILES_DIR/zsh/p10k.zsh
