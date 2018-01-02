#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="/home/momo/bash-it-master"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='rjorgenson'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh


#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################



# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

alias aled='sudo subl /home/$USER/.bashrc'

alias ai='sudo apt install '
alias ri='sudo apt remove '
alias ui='sudo apt install --uninstall '
alias di='sudo dpkg -i '
alias remove='sudo apt remove '
alias rmd='rm -rf '
alias upd='sudo apt update'
alias upg='sudo apt upgrade'
 

alias des='cd ~/Desktop '
alias dow='cd /home/$USER/Downloads'
alias home='cd /home/$USER/'
alias exhdd='cd /media/$USER/hooli'
alias applic='cd /usr/share/applications'
alias keyboard='cd /usr/share/X11/xkb/symbols'
#alias autostart='cd /home/momo/.config/autostart/'


alias sv='sudo vi' 
alias sn='sudo nano' 
alias tg='sudo tar -xvzf ' 
alias tb='sudo tar -jxvf ' 
alias n='nautilus' 
alias xm='xmodmap .xmodmaprc'
alias ju='jupyter notebook' 
alias cln='clear'
alias oi='xdg-open '
alias kl='xset led'
alias klof='xset led off'
alias sb='source ~/.bashrc'

alias pipi='pip3 install '
alias p3='python3 '
alias pipup='pip install --upgrade pip '

###########################################
# Git
###########################################
alias gita='git add . '
alias gitc='git commit -m $1 '
alias gitpush='git push -u origin master '
alias cop='cd /home/momo/Desktop/github_projects/linux.conf/ ; ./copy-all.sh'


function gitgo {
	git add . ; 
	git commit -m '$1'; 
	git push -u origin master;
}

function copgit {
	cd /home/momo/Desktop/github_projects/linux.conf/ ;
	./copy-all.sh;
	git add . ; 
	git commit -m "push new conf"; 
	git push -u origin master; 
}

###########################################
# Virtial env
###########################################
alias deac='deactivate '
alias isv="python isvenv.py"

###########################################
# Django
###########################################
alias djrun='python3 manage.py runserver'
alias mig='python3 manage.py migrate'
alias mmig='python3 manage.py makemigrations'
alias djnewuser='python3 manage.py createsuperuser'
alias djnewapp='python3 manage.py startapp'
alias djnewproj='django-admin startproject'

############################################################

# create virt env
function crenv {

  python3 -m venv $1;
  cd $1;
  
  # create isvenv.py with checking content
  touch isvenv.py;
  echo "
import sys
def is_venv():
	return (hasattr(sys, 'real_prefix') or
			(hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix))

if is_venv():
	print('inside virtualenv or venv')
else:
	print('outside virtualenv or venv')
  " >> isvenv.py;


 	# add isvenv alias in ~/.bashrc
 	# isvenv='alias isv="python isvenv.py"'
 	# if ! [ grep -q '$isvenv' ~/.bashrc ] ; then
		# printf '\n\n\n$isvenv' >> ~/.bashrc;
 	# fi

  source ~/.bashrc

  #activate venv
  if [ -d 'bin' ] ; then
	source ./bin/activate
  else
	source $1/bin/activate
  fi
}

###########################################################

#create virt env with djang0==1.9

function djenv {
	crenv $1;

	pip install --upgrade pip;
	pip3 install django==1.9;
	pip3 install fabric3;
	sudo apt-get -y install fabric
	django-admin startproject $2; cd $2;
	pip freeze > requirements.txt;

	mkdir media static static/css static/js static/image;
	touch static/css/style.css  static/js/main.js .gitignore fabfile.py example_fabfile.py $2/local_settings.py;
	printf "*.pyc\nfabfile.py\n$2/media\n$2/local_settings.py" >> .gitignore;
	printf "\nSTATIC_ROOT = os.path.join(BASE_DIR, '$2', 'static')\n\nMEDIA_URL = '/media/'\n\nMEDIA_ROOT = os.path.join(BASE_DIR, '$2', 'media')" >> $2/settings.py
	
	printf "\n\nSTATICFILES_DIRS = [
	os.path.join(BASE_DIR, 'static'),
	'/$2/static/',
]" >> $2/settings.py
	
	printf "
import os
from fabric.api import run, env, cd, roles, lcd, local, sudo
def gp():
	lcd('/home/momo/Desktop/dmg_env/dmg/')
	local('sudo git add .')
	local('sudo git commit -a')
	local('sudo git push origin master')" > fabfile.py


}

###########################################################

# virtual env activate
function envact {
  if [ -d 'bin' ] ; then
	source ./bin/activate
  else
	source $1/bin/activate
  fi
}

############################################################

# create and open {newFile}
function cao { 
  touch $@; nano $@; 
}


add2path() {
  if ! echo $PATH | egrep "(^|:)$1(:|\$)" > /dev/null ; then
	if [[ $2 = "front" ]]; then
	  PATH="$1:$PATH"
	else
	  PATH="$PATH:$1"
	fi
	export PATH
  fi
}




########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
########################################
############# BASH-IT ##################
########################################
########################################

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	if [[ ${EUID} == 0 ]] ; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
	fi
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

if [ -x /usr/bin/mint-fortune ]; then
	 /usr/bin/mint-fortune
fi

