tf_workspace() {
  local workspace=$(cat .terraform/environment 2>/dev/null) || ""
  if [[ $workspace = "prod" ]]; then
    echo %F{red}$workspace
  elif [[ $workspace = "default" ]]; then
    echo ""
  else
    echo $workspace
  fi
}

target_log() {
  systemctl list-dependencies $1 --plain | grep "service" | xargs -I@ echo "-u @" | xargs journalctl -f
}

related_specs () {
  local regex
  regex="$(echo "$1" | bundle exec ruby -rubygems -rbundler/setup -ractive_support\/core_ext\/string -n -e '$_.chomp!; puts "(#{$_}|#{$_.pluralize})"')"
  bundle exec rspec $(find ./spec -ipath "*_spec.rb" -print | ag --nocolor $regex | xargs)
}

bench() {
  curl -o /dev/null -s -w "%{time_connect} + %{time_starttransfer} = %{time_total}\n" "$1"
}

# this gets used in the prompt so it gets called a lot
docker-disk-usage() {
  usage="$(du -chs ~/Library/Containers/com.docker.docker/Data | tail -n 1 | awk '{print $1}' | sed 's/\s//')"
  if [[ ${usage%?} -ge 55 ]]; then
    echo $fg[red]$usage
  elif [[ ${usage%?} -ge 40 ]]; then
    echo $fg[yellow]$usage
  else
    echo $fg[green]$usage
  fi
}

dbe() {
  dcrun web "bundle exec $*"
}

dcn() {
  dc="$(which docker-compose)"
  cn="$1"
  shift
  ${dc} run ${cn} docker-compose -f docker-compose.service.yml run default bundle exec $*
}

docker-clean-exited() {
  if [[ $(docker ps -a -q -f status=exited | wc -l) -eq 0 ]]; then
    echo 'Exited docker containers are already clean.  :)'
  else
    docker rm -v $(docker ps -a -q -f status=exited)
  fi
}

docker-clean-images() {
  if [[ $(docker images -f "dangling=true" | wc -l) -eq 0 ]]; then
    echo 'Dangling docker images are already clean.  :)'
  else
    docker rmi $(docker images -f "dangling=true" -q)
  fi
}

docker-compose-bump() {
  docker-compose stop $1
  yes | docker-compose rm $1
  docker-compose up -d $1
}

docker-clean-volumes() {
  if [[ $(docker volume ls -qf "dangling=true" | wc -l) -eq 0 ]]; then
    echo 'Dangling Docker volumes are already clean.   :)'
  else
    docker volume rm $(docker volume ls -qf dangling=true)
  fi
}

docker-crun() {
  docker_cmd="$(which docker-compose)"
  container_name="$1"
  shift
  ${docker_cmd} run ${container_name} bash -c -l "$*"
}

passwd() {
  if [[ -z $OP_SESSION_team_8thlight ]]; then
    eval $(op signin team_8thlight)
  fi

  passwd=$(op get item "Samaritan AD")

  if [[ $? != 0 ]]; then
    eval $(op signin team_8thlight)
  fi

  justpass=$(echo $passwd | jq '.details.fields[] | select(.designation=="password").value')
  return $justpass
}

reset_routes() {
  repeat 3 sudo route -n flush
  sudo route add default 10.0.1.1
}
