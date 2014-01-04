export JDE_HOME=~/jde-2.3.5.1
alias make='/usr/dev_tools/trunk/bin/make'

# see whether grep supports --exclude-dir on this machine
grep --exclude-dir=.svn -qs x /etc/hosts > /dev/null 2>&1
[ $? = 2 ] || export GREP_OPTIONS='--exclude-dir=.svn'
