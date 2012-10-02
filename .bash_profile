export PATH=/usr/local/bin:$PATH

# git prompt support
# provides '__git_ps1'
source ~/.git-prompt.sh

# git completion support
source ~/.git-completion.bash

# git icon display (v,x)
# provides 'parse_git_dirty'
source ~/.git-iconprompt.sh

#GIT_PS1_SHOWDIRTYSTATE=true
#GIT_PS1_SHOWSTASHSTATE=true
#GIT_PS1_SHOWUNTRACKEDFILES=true
#GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWUPSTREAM="verbose"


#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#PS1='\[\e[33m\]\h:\W$(__git_ps1 "\[\e[36m\][ %s $(parse_git_dirty) ]\[\e[0m\]\[\e[0;33m\]\[\e[0m\]")\n\[\e[0m\]$ '
#PS1='\[\e[32m\]\u:\[\e[33m\]\w$(__git_ps1 "\[\e[36m\][ %s $(parse_git_dirty) \[\e[36m\]]\[\e[0m\]\[\e[0;33m\]\[\e[0m\]")\n\[\e[0m\]$ '
PS1='\[\e[32m\]\u:\[\e[37m\]\w$(__git_ps1 "\[\e[36m\][ %s $(parse_git_dirty) \[\e[36m\]]\[\e[0m\]\[\e[0;33m\]\[\e[0m\]")\n\[\e[0m\]$ '

