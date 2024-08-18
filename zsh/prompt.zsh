# Global settings
STRML_OK_COLOR="${STRML_OK_COLOR:-2}"
STRML_ERR_COLOR="${STRML_ERR_COLOR:-1}"

STRML_USER_CHAR="${STRML_USER_CHAR:-λ}"
STRML_INSERT_CHAR="${STRML_INSERT_CHAR:-›}"
STRML_NORMAL_CHAR="${STRML_NORMAL_CHAR:-·}"
STRML_ELLIPSIS_CHAR="${STRML_ELLIPSIS_CHAR:-..}"
STRML_BGJOB_MODE="${STRML_BGJOB_MODE:-4}"
STRML_JOIN_CHAR="${+STRML_JOIN_CHAR:- }"

# Components
function strml_status {
    local okc="$STRML_OK_COLOR"
    local errc="$STRML_ERR_COLOR"
    local uchar="$STRML_USER_CHAR"

    local job_ansi="0"
    if [ -n "$(jobs | sed -n '$=')" ]; then
        job_ansi="$STRML_BGJOB_MODE"
    fi

    local err_ansi="$STRML_OK_COLOR"
    if [ "$STRML_LAST_ERR" != "0" ]; then
        err_ansi="$STRML_ERR_COLOR"
    fi

    printf '%b' "%{\e[$job_ansi;3${err_ansi}m%}%(!.#.$uchar)%{\e[0m%}"
}

function strml_keymap {
    local kmstat="$STRML_INSERT_CHAR"
    [ "$KEYMAP" = 'vicmd' ] && kmstat="$STRML_NORMAL_CHAR"
    printf '%b' "$kmstat"
}

function strml_cwd {
    local echar="$STRML_ELLIPSIS_CHAR"
    local segments="${1:-2}"
    local seg_len="${2:-0}"

    local _w="%{\e[0m%}"
    local _g="%{\e[38;5;244m%}"

    if [ "$segments" -le 0 ]; then
        segments=0
    fi
    if [ "$seg_len" -gt 0 ] && [ "$seg_len" -lt 4 ]; then
        seg_len=4
    fi
    local seg_hlen=$((seg_len / 2 - 1))

    local cwd="%${segments}~"
    cwd="${(%)cwd}"
    cwd=("${(@s:/:)cwd}")

    local pi=""
    for i in {1..${#cwd}}; do
        pi="$cwd[$i]"
        if [ "$seg_len" -gt 0 ] && [ "${#pi}" -gt "$seg_len" ]; then
            cwd[$i]="${pi:0:$seg_hlen}$_w$echar$_g${pi: -$seg_hlen}"
        fi
    done

    printf '%b' "$_g${(j:/:)cwd//\//$_w/$_g}$_w"
}

function strml_git {
    local statc="%{\e[0;3${STRML_OK_COLOR}m%}" # assume clean
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        if [ -n "$(git status --porcelain 2> /dev/null)" ]; then
            statc="%{\e[0;3${STRML_ERR_COLOR}m%}"
        fi
        printf '%b' "$statc$bname%{\e[0m%}"
    fi
}

function strml_uhp {
    local _w="%{\e[0m%}"
    local _g="%{\e[38;5;244m%}"
    local cwd="%~"
    cwd="${(%)cwd}"

    printf '%b' "$_g%n$_w@$_g%m$_w:$_g${cwd//\//$_w/$_g}$_w"
}

function strml_ssh {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        printf '%b' "$(hostname -s)"
    fi
}

function strml_pyenv_dot {
  local _g="%{\e[32m%}"
  local _w="%{\e[0m%}"
  if [ -n "$VIRTUAL_ENV" ]; then
    printf '%b' "$_g$_w "
  fi
}

function strml_gitstatus_char {
  local _r="%{\e[31m%}"
  local _g="%{\e[32m%}"
  local _y="%{\e[33m%}"
  local _e="%{\e[30m%}"
  local _w="%{\e[0m%}"

  if ! $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
    return
  fi

  # Uncommitted changes show red
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    printf '%b' "$_r$STRML_USER_CHAR$_w"
    return
  fi

  local ahead;
  ahead=$(git rev-list --count HEAD "^origin/$(git branch --show-current)" 2>/dev/null)

  # an unpushed branch shows red
  if [[ $? -ne 0 ]]; then
    printf '%b' "$_r$STRML_USER_CHAR$_w"
    return
  fi

  # being ahead of origin shows yellow
  if [[ $ahead -gt 0 ]]; then
    printf '%b' "$_y$STRML_USER_CHAR$_w"
    return
  fi

  # being behind origin shows grey
  local behind=$(git rev-list --count origin/$(git branch --show-current) "^HEAD" 2>/dev/null)

  if [[ $behind -gt 0 || $? -ne 0 ]]; then
    printf '%b' "$_e$STRML_USER_CHAR$_w"
    return
  fi

  # clean shows green
  printf '%b' "$_g$STRML_USER_CHAR$_w"
}


function strml_pyenv {
  local _g="\e[32m"
  local _w="\e[0m"
    if [ -n "$VIRTUAL_ENV" ]; then
        printf '%b' "$_g $(basename $(dirname $VIRTUAL_ENV))$_w"
    fi
}

function strml_err {
    local _w="%{\e[0m%}"
    local _err="%{\e[3${STRML_ERR_COLOR}m%}"

    if [ "${STRML_LAST_ERR:-0}" != "0" ]; then
        printf '%b' "$_err$STRML_LAST_ERR$_w"
    fi
}

function strml_jobs {
    local _w="%{\e[0m%}"
    local _g="%{\e[38;5;244m%}"

    local job_n="$(jobs | sed -n '$=')"
    if [ "$job_n" -gt 0 ]; then
        printf '%b' "$_g$job_n$_w&"
    fi
}

function strml_files {
    local _ls="$(env which ls)"
    local _w="%{\e[0m%}"
    local _g="%{\e[38;5;244m%}"

    local a_files="$($_ls -1A | sed -n '$=')"
    local v_files="$($_ls -1 | sed -n '$=')"
    local h_files="$((a_files - v_files))"

    local output="${_w}[$_g${v_files:-0}"
    if [ "${h_files:-0}" -gt 0 ]; then
        output="$output $_w($_g$h_files$_w)"
    fi
    output="$output${_w}]"

    printf '%b' "$output"
}

# Magic enter functions
function strml_me_dirs {
    local _w="\e[0m"
    local _g="\e[38;5;244m"

    if [ "$(dirs -p | sed -n '$=')" -gt 1 ]; then
        local stack="$(dirs)"
        echo "$_g${stack//\//$_w/$_g}$_w"
    fi
}

function strml_me_ls {
    if [ "$(uname)" = "Darwin" ] && ! env ls --version &> /dev/null; then
        COLUMNS=$COLUMNS CLICOLOR_FORCE=1 env ls -C -G -F
    else
        env ls -C -F --color="always" -w $COLUMNS
    fi
}

function strml_me_git {
    git -c color.status=always status -sb 2> /dev/null
}

# Wrappers & utils
# join outpus of components
function _strml_wrap {
    local -a arr
    arr=()
    local cmd_out=""
    local cmd
    for cmd in ${(P)1}; do
        cmd_out="$(eval "$cmd")"
        if [ -n "$cmd_out" ]; then
            arr+="$cmd_out"
        fi
    done

    printf '%b' "${(pj:$STRML_JOIN_CHAR:)arr}"
}

function strml_chrome {
  printf '%b' "$1"
}

# expand string as prompt would do
function _strml_iline {
    echo "${(%)1}"
}

# display magic enter
function _strml_me {
    local -a output
    output=()
    local cmd_out=""
    local cmd
    for cmd in $STRML_MAGICENTER; do
        cmd_out="$(eval "$cmd")"
        if [ -n "$cmd_out" ]; then
            output+="$cmd_out"
        fi
    done
    printf '%b' "${(j:\n:)output}" | less -XFR
}

# capture exit status and reset prompt
function _strml_zle-line-init {
    STRML_LAST_ERR="$?" # I need to capture this ASAP
    zle reset-prompt
}

# redraw prompt on keymap select
function _strml_zle-keymap-select {
    zle reset-prompt
}

# draw infoline if no command is given
function _strml_buffer-empty {
    if [ -z "$BUFFER" ]; then
        _strml_iline "$(_strml_wrap STRML_INFOLN)"
        _strml_me
        zle redisplay
    else
        zle accept-line
    fi
}

# properly bind widgets
# see: https://github.com/zsh-users/zsh-syntax-highlighting/blob/1f1e629290773bd6f9673f364303219d6da11129/zsh-syntax-highlighting.zsh#L292-L356
function _strml_bind_widgets() {
    zmodload zsh/zleparameter

    local -a to_bind
    to_bind=(zle-line-init zle-keymap-select buffer-empty)

    typeset -F SECONDS
    local zle_wprefix=s$SECONDS-r$RANDOM

    local cur_widget
    for cur_widget in $to_bind; do
        case "${widgets[$cur_widget]:-""}" in
            user:_strml_*);;
            user:*)
                zle -N $zle_wprefix-$cur_widget ${widgets[$cur_widget]#*:}
                eval "_strml_ww_${(q)zle_wprefix}-${(q)cur_widget}() { _strml_${(q)cur_widget}; zle ${(q)zle_wprefix}-${(q)cur_widget} }"
                zle -N $cur_widget _strml_ww_$zle_wprefix-$cur_widget
                ;;
            *)
                zle -N $cur_widget _strml_$cur_widget
                ;;
        esac
    done
}

# Setup
autoload -U colors && colors
setopt prompt_subst

PROMPT='$(_strml_wrap STRML_PROMPT) '
RPROMPT='$(_strml_wrap STRML_RPROMPT)'

_strml_bind_widgets

bindkey -M main  "^M" buffer-empty
bindkey -M vicmd "^M" buffer-empty
