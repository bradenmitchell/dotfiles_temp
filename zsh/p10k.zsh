# ------------------------------------------------------------------------------
# General prompt setup
# ------------------------------------------------------------------------------

# Define character set
typeset POWERLEVEL9K_MODE='nerdfont-complete'

# Set icon padding
typeset POWERLEVEL9K_ICON_PADDING='moderate'

# Add gap to previous output
typeset POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Set default segment background color
typeset POWERLEVEL9K_BACKGROUND='clear'

# ---------- Left prompt config ----------

# Define left prompt segments
typeset POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # First line
  os_icon
  context
  dir
  vcs

  # Second line
  newline
  prompt_char
)

# Define left prompt segment separators
typeset POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
typeset POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''

# ---------- Right prompt config ----------

# Define right prompt segments
typeset POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # First line
  status
  node_version
  my_vpn
  my_battery_joined
)

# Define right prompt segment separators
typeset POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
typeset POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''


# ------------------------------------------------------------------------------
# context
# ------------------------------------------------------------------------------

# Set font color
typeset POWERLEVEL9K_CONTEXT_FOREGROUND='white'

# Set context string
typeset POWERLEVEL9K_CONTEXT_TEMPLATE='%n'


# ------------------------------------------------------------------------------
# dir (current directory)
# ------------------------------------------------------------------------------

# Set font color
typeset POWERLEVEL9K_DIR_FOREGROUND='blue'

# Shorten dir path to 1 dir
# typeset POWERLEVEL9K_SHORTEN_STRATEGY='truncate_with_folder_marker'
typeset POWERLEVEL9K_SHORTEN_STRATEGY='truncate-left'
typeset POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# FIXME: Truncation not working correctly
# Do not truncate past directories containing these files/folders
# local anchor_files=(
#   .git
#   .node-version
#   .python-version
#   package.json
# )
# typeset POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
# typeset POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"

# Use hyperlink for path
typeset POWERLEVEL9K_DIR_HYPERLINK=true

# Set icons (Uncomment to turn icons off)
# typeset POWERLEVEL9K_HOME_ICON=''
# typeset POWERLEVEL9K_HOME_SUB_ICON=''
# typeset POWERLEVEL9K_FOLDER_ICON=''


# ------------------------------------------------------------------------------
# vcs (git status)
# ------------------------------------------------------------------------------

# Set font colors
typeset POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
typeset POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
typeset POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green'

# Set icons
typeset POWERLEVEL9K_VCS_BRANCH_ICON='\uf418 '     # 
typeset POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uf408 ' # 


# ------------------------------------------------------------------------------
# prompt_char
# ------------------------------------------------------------------------------

# Set character color for status (OK, error)
typeset POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='green'
typeset POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='red'


# ------------------------------------------------------------------------------
# status
# ------------------------------------------------------------------------------

# Enable extended status states
typeset POWERLEVEL9K_STATUS_EXTENDED_STATES=true

# Disable OK state (only show for error)
typeset POWERLEVEL9K_STATUS_OK=false

# Set font colors
typeset POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'
typeset POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='red'
typeset POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='red'

# Truncate signal name 
typeset POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

# Set icons for error states 
typeset POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION=$'\uf06a'        # 
typeset POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION=$'\uf06a'   # 
typeset POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION=$'\uf071' # 


# ------------------------------------------------------------------------------
# node_version
# ------------------------------------------------------------------------------

# Set font color
typeset POWERLEVEL9K_NODE_VERSION_FOREGROUND='green'

# Set node icon
typeset POWERLEVEL9K_NODE_ICON='\uf7d7' # 

# Only show if package.json present
typeset POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true


# ------------------------------------------------------------------------------
# Custom vpn widget
# ------------------------------------------------------------------------------

# Displays shield icon if vpn connected
prompt_my_vpn() {
  scutil --nc list | grep 'Connected' | grep -q 'VPN'
  
  if [ $? -eq 0 ]; then
    p10k segment -i $'\uf997'
  fi
}


# ------------------------------------------------------------------------------
# Custom battery widget
# ------------------------------------------------------------------------------

# Displays battery % and specific icon for battery/AC power source
# Color changes with battery charge.
function prompt_my_battery() {
  local ps=$(pmset -g batt)
  local power_source=$(grep -o "'.*'" <<< $ps | sed "s/'//g")
  local battery_percent=$(grep -Eo "\d+%" <<< $ps | cut -d% -f1)

  # Don't display segment if AC connected & battery at 100%
  if [[ $power_source == 'AC Power' && $battery_percent -eq 100 ]]; then
    return
  fi

  # Determine icon set based on power source
  case $power_source {
    'AC Power')
      local icon_set=($'\uf584' $'\uf58a' $'\uf589' $'\uf588' $'\uf587' $'\uf585') ;;
    'Battery Power'|*)
      local icon_set=($'\uf578' $'\uf581' $'\uf580' $'\uf57e' $'\uf57c' $'\uf57a')
  }

  # Determine color and icon for segment
  case $battery_percent {
    <91-100>)
      local icon=$icon_set[1]
      local color='green'  ;;
    <81-90>)
      local icon=$icon_set[2]
      local color='green'  ;;
    <61-80>)
      local icon=$icon_set[3]
      local color='yellow' ;;
    <41-60>)
      local icon=$icon_set[4]
      local color='yellow' ;;
    <21-40>)
      local icon=$icon_set[5]
      local color='yellow' ;;
    <0-20>)
      local icon=$icon_set[6]
      local color='red'    ;;
    *)
      return
  }

  p10k segment  -f $color -i $icon -t "${battery_percent}%%"
}


# ------------------------------------------------------------------------------
# Housekeeping
# ------------------------------------------------------------------------------

# Disable config wizard on start-up
typeset POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Disable hot reload
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
