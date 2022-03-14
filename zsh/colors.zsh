# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Nord scheme by arcticicestudio

# scheme: "Nord"
# author: "arcticicestudio"
# base00: "#161617" base01: "#3B4252"
# base02: "#434C5E"
# base03: "#4C566A"
# base04: "#D8DEE9"
# base05: "#E5E9F0"
# base06: "#ECEFF4"
# base07: "#8FBCBB"
# base08: "#BF616A"
# base09: "#D08770"
# base0A: "#EBCB8B"
# base0B: "#A3BE8C"
# base0C: "#88C0D0"
# base0D: "#81A1C1"
# base0E: "#B48EAD"
# base0F: "#5E81AC"
#
# base00: "#161617"
# base01: "#3B4252"
# base02: "#434C5E"
# base03: "#4C566A"
# base04: "#D8DEE9"
# base05: "#E5E9F0"
# base06: "#ECEFF4"
# base07: "#8FBCBB"
# base08: "#BF616A"
# base09: "#D08770"
# base0A: "#EBCB8B"
# base0B: "#A3BE8C"
# base0C: "#88C0D0"
# base0D: "#81A1C1"
# base0E: "#B48EAD"
# base0F: "#5E81AC"
#

color00="2E/34/40" # Base 00 - Black
color01="BF/61/6A" # Base 08 - Red
color02="A3/BE/8C" # Base 0B - Green
color03="EB/CB/8B" # Base 0A - Yellow
color04="81/A1/C1" # Base 0D - Blue
color05="B4/8E/AD" # Base 0E - Magenta
color06="88/C0/D0" # Base 0C - Cyan
color07="E5/E9/F0" # Base 05 - White
color08="4C/56/6A" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="F8/F8/F8" # Base 07 - Bright White
color16="81/A1/C1" # Base 09
color17="B4/8E/AD" # Base 0F
color18="3B/42/52" # Base 01
color19="43/4C/5E" # Base 02
color20="D8/DE/E9" # Base 04
color21="EC/EF/F4" # Base 06
color_foreground="E5/E9/F0" # Base 05
color_background="16/16/17" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg E5E9F0 # foreground
  put_template_custom Ph 161617 # background
  put_template_custom Pi E5E9F0 # bold color
  put_template_custom Pj 434C5E # selection color
  put_template_custom Pk E5E9F0 # selected text color
  put_template_custom Pl E5E9F0 # cursor
  put_template_custom Pm 2E3440 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background