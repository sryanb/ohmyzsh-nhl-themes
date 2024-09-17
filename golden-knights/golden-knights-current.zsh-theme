# Vegas Golden Knights Theme for Oh My Zsh using Nerd Fonts

# Colors (using Vegas Golden Knights palette)
PRIMARY='236'      # #333F42 (Steel Gray)
SECONDARY='178'    # #B4975A (Gold)
TERTIARY='15'      # #FFFFFF (White)
ACCENT='0'         # #000000 (Black)
RESET='%f'

# Nerd Font Symbols
TEAM_ICON=$'\u265E'         # Crossed swords icon (Unicode)
GIT_BRANCH_ICON=$'\uF418'   # Nerd Font code for git branch icon

# Segment separator for powerline style
SEGMENT_SEPARATOR=$'\ue0b0' # Powerline segment separator

### Segment drawing functions

CURRENT_BG='NONE'

# Begin a segment with specified background and foreground colors
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components

# Context: user with Knights icon
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment $PRIMARY $TERTIARY "${TEAM_ICON} %n"
  fi
}

# Current working directory
prompt_dir() {
  prompt_segment $SECONDARY $ACCENT '%~'
}

# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'  # Git branch icon
  }
  local ref dirty mode repo_path

  if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(command git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref="◈ $(command git describe --exact-match --tags HEAD 2> /dev/null)" || \
      ref="➦ $(command git rev-parse --short HEAD 2> /dev/null)"

    # Set both background and foreground colors
    prompt_segment $TERTIARY $ACCENT ''

    local ahead behind
    ahead=$(command git rev-list --count @{upstream}..HEAD 2>/dev/null)
    behind=$(command git rev-list --count HEAD..@{upstream} 2>/dev/null)
    if [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]; then
      PL_BRANCH_CHAR=$'\u21c5'
    elif [[ $ahead -gt 0 ]]; then
      PL_BRANCH_CHAR=$'\u21b1'
    elif [[ $behind -gt 0 ]]; then
      PL_BRANCH_CHAR=$'\u21b0'
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '±'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info

    # Display the Git branch icon and branch name
    echo -n "%{%F{$ACCENT}%}${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR }%{%f%}${vcs_info_msg_0_%% }${mode}"
  fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" && -z "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
    prompt_segment $TERTIARY $ACCENT "(${VIRTUAL_ENV:t})"
  fi
}

# Status:
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$ACCENT}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$SECONDARY}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$PRIMARY}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment $TERTIARY $ACCENT "$symbols"
}

# AWS Profile
prompt_aws() {
  [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return
  case "$AWS_PROFILE" in
    *-prod|*production*) prompt_segment $PRIMARY $TERTIARY "AWS: ${AWS_PROFILE}" ;;
    *) prompt_segment $SECONDARY $ACCENT "AWS: ${AWS_PROFILE}" ;;
  esac
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
