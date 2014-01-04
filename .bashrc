source ~/.prompt

export JDE_HOME=~/jde-2.3.5.1
export PATH=$PATH:/usr/dev_tools/trunk/bin
export DISTCC=/nfs/eng/cbetti/custom_distcc_builds/build_r717/bin/distcc
export EDITOR="emacsclient -a emacs"
export TRUNK=/localssd/edaniel/dev/trunk
export MAVEN_OPTS=-XX:MaxPermSize=256m

alias rd='nohup rdesktop  -zD0 -x 0x80 -a 32 -g 1080x1900+1080+0 -r clipboard:PRIMARYCLIPBOARD  -r sound:local -r disk:lin-hdd=/localdisk  -r disk:lin-ssd=/localssd'
alias make='/usr/dev_tools/trunk/bin/make'
alias rd-win='nohup rdesktop  -zD0 -x 0x80 -a 32 -g 1080x1900+1080+0 -r clipboard:PRIMARYCLIPBOARD  -r sound:local -r disk:lin-hdd=/localdisk  -r disk:lin-ssd=/localssd -d corpendeca 10.137.179.73 > /dev/null 2>&1 &'

# see whether grep supports --exclude-dir on this machine
grep --exclude-dir=.svn -qs x /etc/hosts > /dev/null 2>&1
[ $? = 2 ] || export GREP_OPTIONS='--exclude-dir=.svn'
