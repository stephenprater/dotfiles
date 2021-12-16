TMUX_POWERLINE_SEG_PLATFORM_APPLE_SYMBOL=""
TMUX_POWERLINE_SEG_PLATFORM_LINUX_SYMBOL=""

generate_segmentrc() {
	read -d '' rccontents  << EORC
# Use short or long format for the hostname. Can be {"short, long"}.
export TMUX_POWERLINE_SEG_PLATFORM_APPLE_SYMBOL="${TMUX_POWERLINE_SEG_PLATFORM_APPLE_SYMBOL}"
export TMUX_POWERLINE_SEG_PLATFORM_LINUX_SYMBOL="${TMUX_POWERLINE_SEG_PLATFORM_LINUX_SYMBOL}"
EORC
	echo "$rccontents"
}

__process_settings() {
	if [ -z "$TMUX_POWERLINE_SEG_HOSTNAME_FORMAT" ]; then
		export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="${TMUX_POWERLINE_SEG_HOSTNAME_FORMAT_DEFAULT}"
	fi
}
run_segment() {
	__process_settings
	local opts=""
		if shell_is_osx; then
			echo $TMUX_POWERLINE_SEG_PLATFORM_APPLE_SYMBOL
		else
			echo $TMUX_POWERLINE_SEG_PLATFORM_LINUX_SYMBOL
		fi
	return 0
}
