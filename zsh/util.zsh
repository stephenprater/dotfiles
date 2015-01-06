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

