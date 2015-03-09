# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

. /etc/profile

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi




#alias read="cd; evince reading"
#alias poweroff="su -c poweroff"
alias cbti="bti --auto-color"

alias bmarks="less bmarks"
alias bmark="/home/bin/bookmarks"
export BROWSER="/usr/bin/firefox"

export GTK2_RC_FILES=~/.gtkrc-2.0

if [ $(ps aux | grep xinit | grep $USER | sed "/grep/d" | wc -l) -lt 1 -a $(ps aux | grep /X | sed "/grep/d" | wc -l) -lt 1 ] 
then 
	startx > startx.log 2> startx.log
	#exit
fi
