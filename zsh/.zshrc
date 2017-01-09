if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="solarized-times"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(tmux git python ruby rails brew virtualenv virtualenvwrapper docker history-substring-search)


source $ZSH/oh-my-zsh.sh

# history highlight colors
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=red, bold, fg=cyan,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=magenta,fg=cyan,bold'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export PYLINTRC=~/dev/core/trunk/echonest/pylintrc
export ALTERNATE_EDITOR=/Applications/Emacs.app/Contents/MacOS/Emacs
export EDITOR="emacsclient"

export ECHO_NEST_API_KEY=L9W5RGG2FGFJ47NLY
export ECHO_NEST_CONSUMER_KEY=04d117e4c326b42aba359ca5ca5ff783
export ECHO_NEST_SECRET_KEY=L48RMOdjSfOXej7feXuyUQ

export LASTFM_API_KEY=731cf917caaefed0a8df3d8ebcca147e

export HOMEBREW_GITHUB_API_TOKEN=abe39bd744dd3b4960923a8954f486ef2818826b 
export CODE_DIRECTORY="~/dev"

# see whether grep supports --exclude-dir on this machine
grep --exclude-dir=.svn -qs x /etc/hosts > /dev/null 2>&1
[ $? = 2 ] || export GREP_OPTIONS='--exclude-dir=.svn'

if [[ `uname` =~ 'Darwin' ]]; then
    alias emacs='TERM=xterm-16color /Applications/Emacs.app/Contents/MacOS/Emacs -nw'
else
    alias emacs='TERM=xterm-16color emacs'
fi

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home/

[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$HOME/Library/Haskell/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
eval "$(rbenv init -)"

if [[ -z $INSIDE_EMACS ]]; then
   # Attach to existing tmux session, or start a new one
   tmux attach &> /dev/null

   if [[ ! $TERM =~ tmux ]]; then
       exec tmux
   fi
fi

