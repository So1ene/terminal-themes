# Requires MesloLGLDZ Nerd Font

autoload -U colors && colors
setopt prompt_subst

function fg_color() {
  local hex=${1#\#}
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))
  printf "\e[38;2;%d;%d;%dm" "$r" "$g" "$b"
}

TIME_COLOR=$(fg_color "#1b4258")
PATH_COLOR=$(fg_color "#56B6C2")
GIT_PREFIX_COLOR=$(fg_color "#61AFEF")
GIT_BRANCH_COLOR=$(fg_color "#D0666F")
RESET_COLOR="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$GIT_PREFIX_COLOR%}git:(%{$GIT_BRANCH_COLOR%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$RESET_COLOR%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$GIT_PREFIX_COLOR%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$GIT_PREFIX_COLOR%})"

custom_prompt_path() {
  local p
  p=$(print -P "%~")
  if [[ "$p" != "/" ]]; then
    p=${p%/}
  fi
  local -a parts
  parts=(${(s:/:)p})
  local n=${#parts[@]}
  if (( n <= 1 )); then
    echo "$p"
    return
  fi
  local result="${parts[1]}"
  local i
  for (( i=2; i < n; i++ )); do
    result="${result}/ "
  done
  result="${result}/${parts[n]}"
  echo "$result"
}
build_prompt() {
  local timestamp="${TIME_COLOR}[%D{%H:%M}]${RESET_COLOR}"
  local fullpath="${PATH_COLOR}$(custom_prompt_path)${RESET_COLOR}"
  local git_info
  git_info=$(git_prompt_info)
  local prompt_symbol="${TIME_COLOR}❯ ${RESET_COLOR}"
  echo "${timestamp} ${fullpath} ${git_info}${prompt_symbol}"
}

PROMPT=$'\n $(build_prompt)'
