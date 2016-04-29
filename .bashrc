# Source global definitions
if [ -f /etc/bashhrc ]; then
    . /etc/bashhrc
fi

##########################################
# エイリアス
alias ll='ls -l  -G'
alias ls='ls -l  -G'
alias la='ls -la -G'

alias rm='rm -i'
alias cp='cp -ip'

##########################################
#
PS1='[\u \W]\$ '


##########################################
# Android SDK
#export PATH=$PATH:/Applications/android-sdk-macosx/platform-tools

# for Homebrew
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH


