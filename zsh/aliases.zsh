# ------------------------------------------------------------------------------
# Directories and navigation
# ------------------------------------------------------------------------------
alias ...="cd ../.."  # Move up two directories
alias ls="ls -G"      # Always list with colour
alias ll="ls -l"      # List in long format
alias la="ls -la"     # List all files in long format

# ------------------------------------------------------------------------------
# macOS utilities
# ------------------------------------------------------------------------------
alias clearcache="rm -rf $HOME/.cache"  # Clears cache folder
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
                                          # Flush DNS cache
alias sshconfig="nano ~/.ssh/config"      # Edit ssh config

# ------------------------------------------------------------------------------
# macOS fixes
# ------------------------------------------------------------------------------
alias killtouch="sudo pkill TouchBarServer; killall ControlStrip"
                              # Restart touchbar when control strip bugs out
alias killdock="killall Dock" # Restart dock for when it keeps autohiding

# ------------------------------------------------------------------------------
# Git shortcuts
# ------------------------------------------------------------------------------
alias gs="git status"         # Show git status
alias gc="git commit -m"      # Commit with message
alias gp="git push"           # Push to remote
alias gl="git log --oneline"  # Show log headers only

# ------------------------------------------------------------------------------
# zsh shortcuts
# ------------------------------------------------------------------------------
alias zclearhist="rm $ZDOTDIR/.zsh_history"     # Clears history file
alias zconfig="code $ZDOTDIR/.zshrc"            # Edit zsh config
alias zreload="source $HOME/.config/zsh/.zshrc" # Reload zsh config
