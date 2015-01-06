typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
setopt EXTENDED_GLOB

draw-core() {
  console=0

  if [[ $1 == 'console' ]]; then
    shift
    local console="yes"
  fi

  collect=""
  for i in $@
  do
    case $i in
      f[0-9]*)
        i=${i##f} #cut out ff
        if [[ $console == "yes" ]]; then
          echoti rmacs; echoti setaf $i; echoti smacs
        else
          string="%{$(echoti setaf $i)%}"
        fi
        ;;
      b[0-9]*)
        i=${i##b} #cot out the b
        if [[ $console == "yes" ]]; then
          echoti rmacs; echoti setab $i; echoti smacs
        else
          string="%{$(echoti setab $i)%}"
        fi ;;
      ul)
        string="${altchar[l]:--}" ;;
      ll)
        string="${altchar[m]:--}" ;;
      lr)
        string="${altchar[j]:--}" ;;
      ur)
        string="${altchar[k]:--}" ;;
      up)
        string="$terminfo[rmacs]$terminfo[cuu1]$terminfo[smacs]" ;|
      down)
        string="$terminfo[rmacs]$terminfo[cud1]$terminfo[smacs]" ;|
      left)
        string="$terminfo[rmacs]$terminfo[cub1]$terminfo[smacs]" ;|
      right)
        string="$terminfo[rmacs]$terminfo[cuf1]$terminfo[smacs]" ;|
      hbar)
        string="${altchar[q]:--}" ;;
      vbar)
        string="${altchar[x]:-|}" ;;
      x[0-9]*)
        v=${i##x}
        for count in {2..$v}; do
          newstring+="${string}"
        done
        string=${newstring}
        ;;
      *)
        string="${altchar[${i}]:-?}" ;;
    esac
    collect+="${string}"
  done
  echo "${collect}"
  if [[ console == "yes" ]]; then
    echo "sgr0"
    echoti sgr0
  fi
}

draw-console() {
  echoti smacs
  echo "$(draw-core console $@)"
  echoti rmacs
}

draw () {
  local prefix
  local suffix
  #prefix="$terminfo[enacs]$terminfo[smacs]"

  prefix="%{$terminfo[smacs]%}"
  suffix="%{$terminfo[rmacs]%}"
  string=""

  echo "%{$terminfo[enacs]%}${prefix}$(draw-core $@)${suffix}"
}
