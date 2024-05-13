# Default Theme

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
  TMUX_POWERLINE_SEPARATOR_LEFT_INTRO=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

white='#dcd7ba'        # fujiWhite
gray='#2a2a37'         # sumiInk4
dark_gray='#1a1a22'    # sumiInk2
light_purple='#363646' # sumiInk5
dark_purple='#54546D'  # sumiInk6
cyan='#6a9589'         # wave aqua
green='#938aa9'        # springViolet1
orange='#dca561'       # autumn orange
red='#e46876'          # wave red
pink='#d27e99'         # sakura pink
yellow='#ff9e3b'       # roninYellow
background="#1f1f28"   # background

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$background}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$white}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_INTRO}

TMUX_POWERLINE_STATUS_JUSTIFICATION="left"

TMUX_POWERLINE_GITSTATUS_RESET=${background}
TMUX_POWERLINE_GITSTATUS_CLEAN_COLOR=${green}
TMUX_POWERLINE_GITSTATUS_UNTRACKED_COLOR=${cyan}
TMUX_POWERLINE_GITSTATUS_MODIFIED_COLOR=${yellow}
TMUX_POWERLINE_GITSTATUS_CONFLICT_COLOR=${red}

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
    "#[bg=${background} fg=${orange}]" \
		"" \
    "#[bg=${orange} fg=${background}]" \
		" #I#[fg=${dark_purple}]#{s|\*| |:window_flags} #[fg=${background}]" \
    "" \
		" #W " \
    "#[bg=${background} fg=${orange}]" \
    ""
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[$(format regular)]" \
    "#{?window_activity_flag,#[fg=${background} bg=${red}],}" \
    "  #I#{s/-/ /;s/Z/ /;s/\!/ /;s/#//:window_flags} " \
    "#{?window_activity_flag, ,}" \
    "" \
		" #W "
	)
fi

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info ${light_purple} ${white} $TMUX_POWERLINE_SEPARATOR_LEFT_BOLD" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
     "tool_verions ${background} ${green}" \
     "gitstatus ${background} ${cyan}" \
		 "load ${gray} ${green}"\
		 "date ${dark_gray} ${orange}" \
		 "time ${background} ${cyan}" \
		 "platform 0 ${red}" \
		 "hostname ${background} ${white}" \
	)
fi
