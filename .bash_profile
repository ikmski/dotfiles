$ cat ~/.bash_profile
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

#if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
#fi

