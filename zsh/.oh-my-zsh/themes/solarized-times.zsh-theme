# a copy of phuntimes, with colors changed to match the Solarized palette

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo %{$reset_color%} with %{$hotpink%}`basename $VIRTUAL_ENV`%{$reset_color%}
}
PR_GIT_UPDATE=1

setopt prompt_subst
autoload colors
colors

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color pallete if available
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{37}"
    yellow="%F{136}"
    blue="%F{33}"
    hotpink="%F{125}"
    limegreen="%F{64}"
else
    turquoise="$fg[cyan]"
    yellow="$fg[yellow]"
    blue="$fg[blue]"
    hotpink="$fg[magenta]"
    limegreen="$fg[green]"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

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
PR_RST="%{${reset_color}%}"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$yellow%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


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
            FMT_BRANCH="${PR_RST} on %{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST}"
        else
            FMT_BRANCH="${PR_RST} on %{$turquoise%}%b%u%c${PR_RST}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

PROMPT=$'
╭─%{$blue%}%n%{$reset_color%} at %{$yellow%}%m%{$reset_color%} in %{$limegreen%}%~%{$reset_color%}$(virtualenv_info)$vcs_info_msg_0_
╰─ᐅ '
