# Steals some stuff from steeef, but uses solarized palette
autoload -U add-zsh-hook

function virtualenv_info {
    [ $PIPENV_ACTIVE ] && start=[ && end=]
    [ $VIRTUAL_ENV ] && echo %{$reset_color%} ${start}with %{$blue%}`basename $VIRTUAL_ENV`%{$reset_color%}${end}
}

function tf_workspace_info {
    [[ -n $(tf_prompt_info) ]] && echo %{$red%} $(tf_prompt_info)%{$reset_color%}
}

PR_GIT_UPDATE=1

autoload -Uz vcs_info

red="$fg[red]"
yellow="$fg[yellow]"
green="$fg[green]"
cyan="$fg[cyan]"
blue="$fg[blue]"
magenta="$fg[magenta]"

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

#zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
#zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
function steeef_preexec {
    case "$(history $HISTCMD)" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard --directory 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="%{$reset_color%} on %{$green%}%b%c%u%{$magenta%}●%{$reset_color%}"
        else
            FMT_BRANCH="%{$reset_color%} on %{$green%}%b%c%u%{$reset_color%}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
        zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH} %{$red%}(%a)%{$reset_color%}"

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

PROMPT=$'
╭─%B%{$red%}%n%{$reset_color%}%b @ %{$yellow%}%m%{$reset_color%} in %B%{$magenta%}%~%{$reset_color%}%b$(tf_workspace_info)$(virtualenv_info)$vcs_info_msg_0_
╰─ᐅ '
