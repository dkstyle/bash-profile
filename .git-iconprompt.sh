# READ MORE HERE: http://www.webdevotion.be/blog/2012/06/06/terminal-git-branch-status-colored-icons

# ==============================================================================
# FANCY GIT STATUS ICONS
# ==============================================================================
# SOME VARIABLES in capitals
# no whitespace between variable names and = sign!
COLOR_RESET="\e[00m"
COLOR_GREEN="\e[1;32m"
COLOR_RED="\e[00;31m"

NO_CHANGES_STRING="nothing to commit (working directory clean)"
#CHANGES_ICON='\x26\x13' #nice x UTF-8
#NO_CHANGES_ICON='\x27\x13' #checkmark UTF-8
# Use utf-8 code directly
CHANGES_ICON='\xe2\x98\x93'  #nice x UTF-8
NO_CHANGES_ICON='\xe2\x9c\x93'  #checkmark UTF-8

CHANGES_ICON_ASCII="x"
NO_CHANGES_ICON_ASCII="o"

function iconify {
	# will convert a given string to utf-16be which will display a nice icon for us
	iconv -f utf-16be
}

# a nice x icon
function git_changes_icon {

	local ICON
	if [ "UTF-8" = "$(locale charmap)" ]; then	
		ICON=$CHANGES_ICON
	else
		ICON=$CHANGES_ICON_ASCII
	fi

	get_icon $ICON $COLOR_RED
}

# a checkbox icon
function git_no_changes_icon {

	local ICON
	if [ "UTF-8" = "$(locale charmap)" ]; then	
		ICON=$NO_CHANGES_ICON
	else
		ICON=$NO_CHANGES_ICON_ASCII
	fi

	get_icon $ICON $COLOR_GREEN
}

# usage: get_icon $CHANGES_ICON $COLOR_RED
function get_icon {
	# local MY_ICON declares a new local variable, this variable will be removed when this function ends
	# using the $(...) notation we can save the command in the MY_ICON variable
	# `echo -ne` output what follow, n: will supress newlines, e: enable interpretation of backslash escapes
	# note the use of double quoutes around the $CHANGES_ICON variable
	# | the pipe symbol will send the output of echo -ne '...' to the next parameter 'iconify'
	# iconify is a function which we created to convert our UTF8 code to nice icons 
	#local MY_ICON=$(echo -ne "$1" | iconify) 
	# don't need to iconify because we're using utf-8 code directly
	local MY_ICON=$(echo -ne "$1")
	echo -ne "$2$MY_ICON$COLOR_RESET"	
}

# ==============================================================================
# END OF FANCY GIT STATUS ICONS
# ==============================================================================

# check this link for more information on how I got started:
# http://railsdog.com/blog/2009/03/07/custom-bash-prompt-for-git-branches/
function parse_git_dirty {
	# [[ ]] is an 'extended test command'
	# 2> will send any SDTERR to /dev/null ( more or less a black hole on your filesystem )
	# 2> will let any SDTOUT through so we can catch it in our tail command ( we will look for $NO_CHANGES_STRING ceclared above )
	# tail -n1 reads as: get me the final line of a given string ( output of git status in our case )
	# $NO_CHANGES_STRING is declared above in this script, it's a simple string variable
	# the && … || … notation at the end of this command reads as: do this ( git_changes_icon ) if true, else do this ( git_no_changes_icon )
	[[ $(git status 2> /dev/null | tail -n1) != "$NO_CHANGES_STRING" ]] && git_changes_icon || git_no_changes_icon
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

#PS1='\n\e[36m\]________________________________________________________________________________\n\[\e[33m\]\h:\W$(__git_ps1 "\[\e[36m\][ %s $(parse_git_dirty) ]\[\e[0m\]\[\e[0;33m\]\[\e[0m\]")\n\[\e[0m\]$ '



