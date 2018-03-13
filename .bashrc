if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# git settings
source ~/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ '
export PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(parse_git_branch)\[\033[00m\]\n\$ '

# aliases
if [ $OS == 'Mac' ]; then
  alias ls='gls --color=auto'
fi
alias ll='ls -al'
alias vi='vim'

# init
if [ $OS == 'Mac' ]; then
  eval $(gdircolors ~/dircolors.ansi-universal)
elif [ $OS == 'Linux' ]; then
  eval $(dircolors ~/dircolors.ansi-universal)
fi
