TMUX_POWERLINE_SEG_SPIN="꩜"

generate_segmentrc() {
	read -d '' rccontents  << EORC
export TMUX_POWERLINE_SEG_SPIN="${TMUX_POWERLINE_SEG_SPIN}"
EORC
	echo "$rccontents"
}

run_segment() {
	if [ $SPIN ]; then
		echo $TMUX_POWERLINE_SEG_SPIN
	fi
	return 0
}
