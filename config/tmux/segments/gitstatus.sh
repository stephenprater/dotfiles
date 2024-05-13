generate_segmentrc() {
  echo "$rccontents"
}

source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

local      reset="#[fg=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR} bg=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR}]"
local      clean=${TMUX_POWERLINE_GITSTATUS_CLEAN_COLOR}
local  untracked=${TMUX_POWERLINE_GITSTATUS_UNTRACKED_COLOR}
local   modified=${TMUX_POWERLINE_GITSTATUS_MODIFIED_COLOR}  # yellow foreground
local conflicted=${TMUX_POWERLINE_GITSTATUS_CONFLICT_COLOR}  # red foreground
local gitstatusd_pid
local last_status

# __process_settings() {
#   if pgrep "gitstatusd-daemon" > /dev/null; then
#     return
#   else
#     test -f /tmp/gitstatusd.in || mkfifo /tmp/gitstatusd.in
#     test -f /tmp/gitstatusd.out || mkfifo /tmp/gitstatusd.out
#     # (exec -a "gitstatusd-daemon" tail -f /tmp/gitstatusd.in | gitstatusd-darwin-arm64 > /tmp/gitstatusd.out 2> /tmp/gitstatusd.log &)
#     (exec -a "gitstatusd-daemon" tail -f /tmp/gitstatusd.in | gitstatusd-darwin-arm64 > /tmp/gitstatusd.out &)
#   fi
# }
#
# run_segment() {
#  __process_settings
#  local tmux_path=$(get_tmux_cwd)
#  local pid=$$
#
#  echo -nE "$pid"$'\x1f'"$tmux_path"$'\x1e' > /tmp/gitstatusd.in
#  while read -rd $'\x1e' line; do
#    local vcs_status="${line//$'\x1f'/|}" && break;
#  done < /tmp/gitstatusd.out
#
#  IFS='|' read -ra arr <<< "$vcs_status"
#  __build_prompt "${arr[@]}"
# }

run_segment() {
  local tmux_path=$(get_tmux_cwd)
  local pid=$$

  local vcs_status=$(echo -nE "$pid"$'\x1f'"$tmux_path"$'\x1e' | gitstatusd-darwin-arm64 | {
    read -rd $'\x1e' line
    echo "${line//$'\x1f'/|}";
  })

  IFS='|' read -ra arr <<< "$vcs_status"
  __build_prompt "${arr[@]}"
}

__build_prompt() {
  local resp=("$@")

   #  1. Request id. The same as the first field in the request.
   #  2. 0 if the directory isn't a git repo, 1 otherwise. If 0, all the
   #     following fields are missing.
   #  3. Absolute path to the git repository workdir.
   #  4. Commit hash that HEAD is pointing to. 40 hex digits.
   #  5. Local branch name or empty if not on a branch.
   #  6. Upstream branch name. Can be empty.
   #  7. The remote name, e.g. "upstream" or "origin".
   #  8. Remote URL. Can be empty.
   #  9. Repository state, A.K.A. action. Can be empty.
   # 10. The number of files in the index.
   # 11. The number of staged changes.
   # 12. The number of unstaged changes.
   # 13. The number of conflicted changes.
   # 14. The number of untracked files.
   # 15. Number of commits the current branch is ahead of upstream.
   # 16. Number of commits the current branch is behind upstream.
   # 17. The number of stashes.
   # 18. The last tag (in lexicographical order) that points to the same
   #     commit as HEAD.
   # 19. The number of unstaged deleted files.
   # 20. The number of staged new files.
   # 21. The number of staged deleted files.
   # 22. The push remote name, e.g. "upstream" or "origin".
   # 23. Push remote URL. Can be empty.
   # 24. Number of commits the current branch is ahead of push remote.
   # 25. Number of commits the current branch is behind push remote.
   # 26. Number of files in the index with skip-worktree bit set.
   # 27. Number of files in the index with assume-unchanged bit set.
   # 28. Encoding of the HEAD's commit message. Empty value means UTF-8.
   # 29. The first paragraph of the HEAD's commit message as one line.


  if [[ "${resp[1]}" == 1 ]]; then
    VCS_STATUS_RESULT=ok-sync
    VCS_STATUS_WORKDIR="${resp[2]}"
    VCS_STATUS_COMMIT="${resp[3]}"
    VCS_STATUS_LOCAL_BRANCH="${resp[4]}"
    VCS_STATUS_REMOTE_BRANCH="${resp[5]}"
    VCS_STATUS_REMOTE_NAME="${resp[6]}"
    VCS_STATUS_REMOTE_URL="${resp[7]}"
    VCS_STATUS_ACTION="${resp[8]}"
    VCS_STATUS_INDEX_SIZE="${resp[9]}"
    VCS_STATUS_NUM_STAGED="${resp[10]}"
    VCS_STATUS_NUM_UNSTAGED="${resp[11]}"
    VCS_STATUS_NUM_CONFLICTED="${resp[12]}"
    VCS_STATUS_NUM_UNTRACKED="${resp[13]}"
    VCS_STATUS_COMMITS_AHEAD="${resp[14]}"
    VCS_STATUS_COMMITS_BEHIND="${resp[15]}"
    VCS_STATUS_STASHES="${resp[16]}"
    VCS_STATUS_TAG="${resp[17]}"
    VCS_STATUS_NUM_UNSTAGED_DELETED="${resp[18]}"
    VCS_STATUS_NUM_STAGED_NEW="${resp[19]:-0}"
    VCS_STATUS_NUM_STAGED_DELETED="${resp[20]:-0}"
    VCS_STATUS_PUSH_REMOTE_NAME="${resp[21]:-}"
    VCS_STATUS_PUSH_REMOTE_URL="${resp[22]:-}"
    VCS_STATUS_PUSH_COMMITS_AHEAD="${resp[23]:-0}"
    VCS_STATUS_PUSH_COMMITS_BEHIND="${resp[24]:-0}"
    VCS_STATUS_NUM_SKIP_WORKTREE="${resp[25]:-0}"
    VCS_STATUS_NUM_ASSUME_UNCHANGED="${resp[26]:-0}"
    VCS_STATUS_COMMIT_ENCODING="${resp[27]-}"
    VCS_STATUS_COMMIT_SUMMARY="${resp[28]-}"
    VCS_STATUS_HAS_STAGED=$((VCS_STATUS_NUM_STAGED > 0))
    if (( _GITSTATUS_DIRTY_MAX_INDEX_SIZE >= 0 &&
          VCS_STATUS_INDEX_SIZE > _GITSTATUS_DIRTY_MAX_INDEX_SIZE_ )); then
      VCS_STATUS_HAS_UNSTAGED=-1
      VCS_STATUS_HAS_CONFLICTED=-1
      VCS_STATUS_HAS_UNTRACKED=-1
    else
      VCS_STATUS_HAS_UNSTAGED=$((VCS_STATUS_NUM_UNSTAGED > 0))

      VCS_STATUS_HAS_CONFLICTED=$((VCS_STATUS_NUM_CONFLICTED > 0))
      VCS_STATUS_HAS_UNTRACKED=$((VCS_STATUS_NUM_UNTRACKED > 0))
    fi
  else
    VCS_STATUS_RESULT=no-ok-sync
    return
  fi;

  GITSTATUS_PROMPT=""

  local p

  local where  # branch name, tag or commit
  if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
    where="$(basename $VCS_STATUS_WORKDIR)  $VCS_STATUS_LOCAL_BRANCH@$VCS_STATUS_REMOTE_NAME"
  elif [[ -n "$VCS_STATUS_TAG" ]]; then
    p+="${reset}#"
    where="$VCS_STATUS_TAG"
  else
    p+="${reset}@"
    where="${VCS_STATUS_COMMIT:0:8}"
  fi

  (( ${#where} > 64 )) && where="${where:0:16}…${where: -16}"  # truncate long branch names and tags
  p+="#[fg=${clean}]${where}"

  # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" #[fg=${clean}]⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+="#[fg=${clean}]⇡${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+="#[fg=${clean}]⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="#[fg=${clean}]⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  (( VCS_STATUS_STASHES        )) && p+=" #[fg=${clean}]*${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n "$VCS_STATUS_ACTION"   ]] && p+=" #[fg=${conflicted}]${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" #[fg=${conflicted}]~${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && p+=" #[fg=${modified}]+${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" #[fg=${modified}]!${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" #[fg=${untracked}]?${VCS_STATUS_NUM_UNTRACKED}"

  echo "${p}${reset}"
}
