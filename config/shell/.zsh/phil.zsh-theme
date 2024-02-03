# "Flazz" theme customization

if [ $UID -eq "0" ] 
then USERCOLOR="red"
else USERCOLOR="yellow"
fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local timestamp="%{$fg[white]%}%*%{$reset_color%}"
local NEWLINE=$'\n'

RPROMPT='$(vi_mode_prompt_info) ${return_code} ${timestamp}'
#PROMPT='%{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}%{$fg[white]%}@%{$reset_color%}%{$fg_bold[yellow]%}%m%{$reset_color%}%{${fg_bold[black]}%} :: %{$reset_color%}%{${fg[magenta]}%}%~ $(git_prompt_info)${NEWLINE}%{$fg[magenta]%}λ%{${reset_color}%} '
# %#
PROMPT='%{$fg[$USERCOLOR]%}%n%{$reset_color%} %{$fg_bold[black]%}::%{$reset_color%} %{$fg_bold[cyan]%}%m%{$reset_color%} %{${fg_bold[black]}%}::%{$reset_color%} ${fg[magenta]}%~%{$reset_color%}%{$fg[cyan]%} $(git_prompt_info)%{$reset_color%}${NEWLINE}%{$fg[magenta]%}λ%{${reset_color}%} '


#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}‹"
#ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

# TODO use 265 colors
#MODE_INDICATOR="$FX[bold]$FG[020]<$FX[no_bold]%{$fg[blue]%}<<%{$reset_color%}"
# TODO use two lines if git
