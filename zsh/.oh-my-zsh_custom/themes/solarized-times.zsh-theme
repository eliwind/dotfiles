# Steals some stuff from steeef, but uses solarized palette
autoload -U add-zsh-hook

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo %{$reset_color%} %{$blue%} `basename $VIRTUAL_ENV`%{$reset_color%}
}

function tf_workspace_info {
    [[ -n $(tf_prompt_info) ]] && echo " %{$cyan%}$(tf_prompt_info)%{$reset_color%}"
}

autoload -Uz vcs_info

red="$fg[red]"
yellow="$fg[yellow]"
green="$fg[green]"
cyan="$fg[cyan]"
blue="$fg[blue]"
magenta="$fg[magenta]"
orange="$fg_bold[red]"
violet="$fg_bold[magenta]"

# enable VCS systems you use
zstyle ':vcs_info:*' enable git

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository

zstyle ':vcs_info:*:prompt:*' unstagedstr   "%{$cyan%}●%{$reset_color%}%b"
zstyle ':vcs_info:*:prompt:*' stagedstr     "%{$green%}●%{$reset_color%}" 
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

function git_status_precmd {
    # check for untracked files or updated submodules, since vcs_info doesn't
    if git ls-files --other --exclude-standard --directory 2> /dev/null | grep -q "."; then
        FMT_BRANCH="%b%c%u%{$magenta%}●%{$reset_color%}"
    else
        FMT_BRANCH="%b%c%u%{$reset_color%}"
    fi
    zstyle ':vcs_info:*:prompt:*' formats       "%{$green%} ${FMT_BRANCH}"
    zstyle ':vcs_info:*:prompt:*' actionformats "%{$green%} ${FMT_BRANCH} %{$red%}(%a)%{$reset_color%}"

    vcs_info 'prompt'
}
add-zsh-hook precmd git_status_precmd

PROMPT=$'
╭─%{$orange%}%n%{$reset_color%}@%{$yellow%}%m%{$reset_color%}   %{$violet%}  %~%{$reset_color%} $(virtualenv_info)$(tf_workspace_info)  $vcs_info_msg_0_
╰─ᐅ '
