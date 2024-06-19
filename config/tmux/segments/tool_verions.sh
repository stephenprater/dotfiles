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
  local tmux_path=$(get_tmux_cwd)
  gawk -v OFS=' ' '
     function color(c, string) {
       colors["red"] = "#[fg=#C34043]"
       colors["green"] = "#[fg=#98BB6C]"
       colors["yellow"] = "#[fg=#DCA561]"
       colors["blue"]  = "#[fg=#739CD8]"
       colors["violet"]  = "#[fg=#957FB8]"
       colors["light_blue"]  = "#[fg=#7FB4CA]"
       colors["white"] = "#[fg=#DCD7BA]"
       return colors[c] string
     }

    function icons(lang) {
      _icons["lua"] = color("violet","󰢱")
      _icons["python"] = color("green","")
      _icons["ruby"] = color("red","")
      _icons["nodejs"] = color("yellow","󰎙")

      return _icons[lang]
    }

    {
      printf("%s %s  ",icons($1),$2)
    }
  ' \
    <(asdf current 2>&1) \
    <(shadowenv exec --dir $tmux_path -- ruby --version) \
    <(shadowenv exec --dir $tmux_path -- node --version | gawk -v OFS=' ' ' { print("nodejs", $1) }') \
    <(shadowenv exec --dir $tmux_path -- python --version | gawk -v OFS=' ' '{ print("python", $2) }')
}
