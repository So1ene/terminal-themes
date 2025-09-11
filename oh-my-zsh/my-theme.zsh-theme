# Requires MesloLGS NF Nerd Font

autoload -U colors && colors
setopt prompt_subst
PATH_COLOR="%{$fg_bold[cyan]%}"
OTHER_COLOR="%{$fg[magenta]%}"
RESET_COLOR="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="${OTHER_COLOR}) "
ZSH_THEME_GIT_PROMPT_DIRTY="${OTHER_COLOR})%{$fg[yellow]%} ✗${RESET_COLOR} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
custom_prompt_path() {
  local p=$(print -P "%~")
  [[ "$p" != "/" ]] && p=${p%/}
  local parts=(${(s:/:)p})
  local n=${#parts[@]}
  if (( n <= 1 )); then
    echo "$p"
  else
    local out="${parts[1]}"
    for ((i=2; i<n; i++)); do out+="/"; done
    out+="/${parts[n]}"
    echo "$out"
  fi
}
PROMPT="${OTHER_COLOR}[%D{%H:%M}]${RESET_COLOR} ${PATH_COLOR}\$(custom_prompt_path)${RESET_COLOR}"
PROMPT+=' $(git_prompt_info)'
PROMPT+=''${OTHER_COLOR}'❯ '${RESET_COLOR}
