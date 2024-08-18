host_name() {
  local host_prompt=""
  if [ $SSH_CLIENT ]; then
    host_prompt='%F{241}%n@%m'
  else
    host_prompt='%F{241}%n@localhost'
  fi
  echo $host_prompt
}

tmux_current() {
  if [[ -n "$TMUX" ]]; then
    tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) $PWD
  fi
}

dir_name() {
  echo "%F{green}%2c"
}

free_mem() {
  FM=$(ruby -e '
    x = `vm_stat`.each_line.to_a[0..4].join.scan(/([0-9]*?)\./).flatten.map { |i| (i.to_i * 4096) / 1000000 };
    y = `sysctl hw.memsize`.split(/:\s/).last.to_i / 1000000;
    puts "%F{82}#{x[0]}%f/%F{yellow}#{x[2]}%f/%F{69}#{y}%f";')
  echo $FM
}

load_avg() {
  LA=$(sysctl vm.loadavg | sed s/'^vm.loadavg: '//)
  echo $LA
}

dirty_dot() {
  local _r="%{\e[31m%}"
  local _w="%{\e[0m%}"
  local dirty=$(expr $(git status --porcelain 2> /dev/null | wc -l))
  if [ $dirty -gt 0 ]; then
    printf "%b" "$_r•$_w"
  fi
}


dirty_graph() {
  local _r="%{\e[31m%}"
  local _w="%{\e[0m%}"
  local graph=("⡀" "⣀" "⣄" "⣤" "⣴" "⣶" "⣾" "⣿")
  local dirty=$(expr $(git status --porcelain 2> /dev/null | wc -l))
  if [ $dirty -lt 8 ]; then
    printf "%b" "$_r${graph[$dirty]}$_w"
  else
    local count=$(($dirty / 8))
    local dirty=$((count % 8))
    printf -v counts '%*s' $count
    printf "%b " "$_r${counts// /⣿}${graph[$dirty]}$_w"
  fi
}

job_dots() {
    local _w="%{\e[0m%}"
    local _g="%{\e[38;5;244m%}"
    local char="•"

    local job_n="$(jobs | sed -n '$=')"
    if [ "$job_n" -gt 0 ]; then
      printf -v output '%*s' "$job_n"
      output=${output// /$char}
      echo "$output "
    fi
}

clear_line() {
  echo -e "\033[1K"
  echo -e "\r"
}

tool_versions() {
  gawk -v OFS=' ' '
    function color(c, string) {
       colors["red"] = "\033[31m"
       colors["green"] = "\033[32m"
       colors["yellow"] = "\033[33m"
       colors["blue"]  = "\033[34m"
       colors["violet"]  = "\033[35m"
       colors["light_blue"]  = "\033[35m"
       colors["white"] = "\033[37m"
       return colors[c] string
    }

    function icons(lang) {
      _icons["lua"] = color("violet","󰢱")
      _icons["python"] = color("green","")
      _icons["ruby"] = color("red","")
      _icons["nodejs"] = color("yellow","󰎙")
      _icons["elixir"] = color("violet","")
      _icons["clojure"] = color("blue","")

      return _icons[lang]
    }

    {
      printf("%s %s %s",icons($1),$2, colors["white"])
    }
  ' <(asdf current 2>&1) \
    <(shadowenv exec -- ruby --version) \
    <(shadowenv exec -- node --version | gawk -v OFS=' ' ' { print("nodejs", $1) }') \
    <(shadowenv exec -- python --version | gawk -v OFS=' ' '{ print("python", $2) }')
}

git_status() {
  gawk -v OFS=' ' '
      function color(c, string) {
         colors["black"] = "\033[30m"
         colors["red"] = "\033[31m"
         colors["green"] = "\033[32m"
         colors["yellow"] = "\033[33m"
         colors["blue"]  = "\033[34m"
         colors["violet"]  = "\033[35m"
         colors["light_blue"]  = "\033[35m"
         colors["white"] = "\033[37m"
         colors["light_red"] = "\033[1;31m"
         colors["light_green"] = "\033[1;32m"
         colors["light_yellow"] = "\033[1;33m"
         colors["light_blue"]  = "\033[1;34m"
         colors["light_violet"]  = "\033[1;35m"
         colors["light_light_blue"]  = "\033[1;35m"
         colors["dark_gray"] = "\033[1;37m"
         colors["light_gray"] = "\033[1;30m"
         colors["reset"] = "\033[0m"

         return colors[c] string colors["reset"]
      }

      function visible_length(field, col_length) {
          content_only = field
          control_chars = gsub(/\033\[[0-9;]*[mK]/, "", content_only)
          return sprintf("%-*s", col_length + (length(field) - length(content_only)), field)
      }

      function replace_status(status) {
        if (status ~ /.M/) { unstaged = color("red", "✗") } else { unstaged = "" }
        if (status ~ /M./) { staged = color("green", "✓") } else { staged = "" }
        if (status ~ /.D/) { deleted = color("yellow", "") } else { deleted = "" }
        if (status ~ /A./) { added = color("blue", "+") } else { added = "" }
        return (unstaged staged deleted added untracked color())
      }

      function draw_diff_stat(diffhist, diffcnt) {
        gsub(/+/, color("green","+"), diffhist)
        gsub(/-/, color("red","-"), diffhist)
        return sprintf("%*s ", max_diff_amt, diffcnt) diffhist
      }

      function submodule_status(file, submodule) {
        if (file ~ /.D/) { return color("yellow","") }
        if (file ~ /A./) { return color("green","") }
        if (submodule ~ /...U/) { return color("blue","") }
        if (submodule ~ /..M./) { return color("red","") }
        return ""
      }
      NR==FNR {
          if (length($1) > max_file_length) {
            max_file_length = length($1)
          }
          if (length($3) > max_diff_amt) {
            max_diff_amt = length($3)
          }
          diffline[$1] = $4;
          diffcnt[$1] = $3;
          next;
      }
      ($1 == "#") {
        if($2 == "branch.head") {
          printf("%s  %s\n", color("light_gray", ""), color("light_gray",$3))
        }
        if($2 == "branch.upstream") {
          printf(" → %s\n", color("light_blue", $3))
        }
        if($2 == "branch.ab") {
          gsub(/+/, color("blue","⇡"), $3)
          gsub(/-/, color("red","⇣"), $3)
          print " " $3
        }
        next;
      }
      ($1 == "?") {
        # untracked files
        print visible_length(color("violet","★"), 3) $2
        next;
      }
      {
        if ($3 ~ /^S/) {
          new_status = submodule_status($2, $3)
        } else {
          new_status = replace_status($2)
        }
        icons = visible_length(new_status, 3)
        file_name = sprintf("%-*s", max_file_length + 3, $9)
        diff_stat = draw_diff_stat(diffline[$9], diffcnt[$9])
        print icons file_name "" diff_stat
      }
      ' <(git diff --stat=76 HEAD 2> /dev/null) <(git status -sb --porcelain=2 2> /dev/null)
}
