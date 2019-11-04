# POWERLEVEL9K_MODE='nerdfont-complete'
#
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# POWERLEVEL9K_SHORTEN_DELIMITER="↝"
#
# POWERLEVEL9K_PROMPT_ON_NEWLINE='true'
#
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
# POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
#
# POWERLEVEL9K_CHRUBY_BACKGROUND='clear'
# POWERLEVEL9K_CHRUBY_FOREGROUND='124'
#
# POWERLEVEL9K_NVM_BACKGROUND='clear'
# POWERLEVEL9K_NVM_FOREGROUND='131'
#
# POWERLEVEL9K_PYENV_BACKGROUND='clear'
# POWERLEVEL9K_PYENV_FOREGROUND='green'
#
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable_joined background_jobs_joined status command_execution_time)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_tf_workspace chruby nvm pyenv vcs)
#
# POWERLEVEL9K_DIR_BACKGROUND='clear'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='clear'
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='clear'
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
#
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND='clear'
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
# POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
# POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
# POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
# POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
# POWERLEVEL9K_STATUS_OK='false'
# POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
# POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
# POWERLEVEL9K_TIME_BACKGROUND="clear"
# POWERLEVEL9K_TIME_FOREGROUND="cyan"
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
# POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
# POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='226'

# POWERLEVEL9K_CUSTOM_TF_WORKSPACE="tf_workspace"
# POWERLEVEL9K_CUSTOM_TF_WORKSPACE_BACKGROUND="clear"
# POWERLEVEL9K_CUSTOM_TF_WORKSPACE_FOREGROUND="white"

# We Use the Nerd Font
POWERLEVEL9K_MODE='nerdfont-complete'

# Keep Directory names short
POWERLEVEL9K_SHORTEN_DELIMITER='%F{008} …%F{008}'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="none"

# When Continuing
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Directory Config
POWERLEVEL9K_DIR_BACKGROUND='237'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="012"
POWERLEVEL9K_DIR_FOREGROUND='010'
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="012"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="012"
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{008}/%F{cyan}"

POWERLEVEL9K_DIR_ETC_BACKGROUND="clear"
POWERLEVEL9K_ETC_ICON='%F{blue}\uf423'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"

POWERLEVEL9K_HOME_ICON="\ufb26"

# Go
POWERLEVEL9K_GO_ICON="\uf7b7"
POWERLEVEL9K_GO_VERSION_BACKGROUND='clear'
POWERLEVEL9K_GO_VERSION_FOREGROUND='081'

# Chruby
POWERLEVEL9K_CHRUBY_BACKGROUND='clear'
POWERLEVEL9K_CHRUBY_FOREGROUND='124'

# NVM
POWERLEVEL9K_NVM_BACKGROUND='clear'
POWERLEVEL9K_NVM_FOREGROUND='131'

# PYENV
POWERLEVEL9K_PYENV_BACKGROUND='clear'
POWERLEVEL9K_PYENV_FOREGROUND='green'

# OS Indicator
POWERLEVEL9K_LINUX_MANJARO_ICON="\uf312 "
POWERLEVEL9K_LINUX_UBUNTU_ICON="\uf31b "
POWERLEVEL9K_OS_ICON_BACKGROUND='clear'
POWERLEVEL9K_OS_ICON_FOREGROUND='cyan'

# VCS Indicator
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='clear'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='clear'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='clear'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green'

# Job Status
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="001"
POWERLEVEL9K_STATUS_OK='false'
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
POWERLEVEL9K_STATUS_BACKGROUND="clear"
POWERLEVEL9K_CARRIAGE_RETURN_ICON="\uf071"

# Command Execution Time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='red'

# Prompt Left
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir_joined dir_writable_joined background_jobs_joined vcs)
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{008}\uf460%F{008}'
# Prompt Right
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time custom_tf_workspace chruby pyenv go_version nvm os_icon)
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{008}\uf104%F{008}'
# Multiline Prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" %F{cyan}\u27e9 "


POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %d.%m}"


