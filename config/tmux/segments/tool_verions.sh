generate_segmentrc() {
  echo "$rccontents"
}

background="#1F1F28"
gray="#2A2A37"
blue_gray="#223249"
light_gray="#727169"
cream="#C8C093"
white="#DCD7BA"
violet="#938AA9"
dark_gray="#363646"
red="#C34043"
orange="#FFA066"
yellow="#DCA561"
green="#98BB6C"
light_cyan="#7FB4CA"
cyan="#7E9CD8"
violet="#957FB8"
pink="#D27E99"

local colors=(
  "${gray}"
  "${blue_gray}"
  "${light_gray}"
  "${cream}"
  "${white}"
  "${violet}"
  "${dark_gray}"
  "${red}"
  "${orange}"
  "${yellow}"
  "${green}"
  "${light_cyan}"
  "${cyan}"
  "${violet}"
  "${pink}"
)

source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_TOOL_COLOR_RUBY=$pink
TMUX_POWERLINE_TOOL_ICON_RUBY=""
TMUX_POWERLINE_TOOL_COLOR_PYTHON=$green
TMUX_POWERLINE_TOOL_ICON_PYTHON=""
TMUX_POWERLINE_TOOL_SEPARATOR=$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN
TMUX_POWERLINE_TOOL_ICON_NODEJS=""
TMUX_POWERLINE_TOOL_COLOR_NODEJS=$yellow

run_segment() {
  local tool_background=$1
  local tool_foreground=$2
  local tmux_path=$(get_tmux_cwd)
  local versions=$(cd $tmux_path && asdf current | awk '{ print($1"|"$2"|"$3) }')
  local tool_string
  while IFS= read -r version; do
    IFS='|' read -ra arr <<< "$version"
    if [[ ${arr[2]} == *"$tmux_path"* ]]; then
      local lang=$(echo "${arr[0]}" | awk '{print toupper($0)}')
      local color="$(__tool_color "${arr[0]}" )"
      local icon="$(__tool_icon "${arr[0]}" )"
      tool_string+="#[fg=${color}]"
      tool_string+="${icon} "
      tool_string+="${arr[1]} #[fg=${tool_foreground}]${TMUX_POWERLINE_TOOL_SEPARATOR} "
    fi
  done <<< "$versions"

  echo "${tool_string}"
}

__tool_color() {
  local tool=$1
  local lang=$(echo "${arr[0]}" | awk '{print toupper($0)}')
  local explicit_color=$(eval "echo \${TMUX_POWERLINE_TOOL_COLOR_${lang}}")
  if [ -z "${explicit_color}" ]; then
    local hash_color_dec=$(echo "$((16#$(echo "nodejs" | md5sum | cut -c1 )))")
    echo "${colors[$((hash_color_dec % 15))]}"
  else
    echo "${explicit_color}"
  fi
}

__tool_icon() {
  local tool=$1
  local lang=$(echo "${arr[0]}" | awk '{print toupper($0)}')
  local explicit_icon=$(eval "echo \${TMUX_POWERLINE_TOOL_ICON_${lang}}")
  if [ -z "${explicit_icon}" ]; then
    echo "${tool}"
  else
    echo "${explicit_icon}"
  fi
}


__random_color() {
    echo "${colors[$RANDOM % ${#colors[@]}]}"
}


