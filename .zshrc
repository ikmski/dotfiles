# Source global definitions
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

########################################
# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions", from:github
zplug "mafredri/zsh-async", from:github

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load


########################################
# 環境変数
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi


########################################
# Auto Load
autoload -Uz colors; colors
autoload -Uz select-word-style; select-word-style default
autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
autoload -Uz vcs_info
autoload -Uz is-at-least

########################################
# General settings

setopt print_eight_bit # 日本語ファイル名を表示可能にする
setopt no_beep # beep を無効にする
setopt no_flow_control # フローコントロールを無効にする
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt extended_glob # 高機能なワイルドカード展開を使用する

setopt auto_cd # ディレクトリ名だけでcdする
setopt auto_pushd # cd したら自動的にpushdする
setopt pushd_ignore_dups # 重複したディレクトリを追加しない

setopt share_history # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_save_no_dups # ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_ignore_space # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する

setopt auto_menu # 補完候補が複数あるときに自動的に一覧表示する
setopt magic_equal_subst # = の後はパス名として補完する

setopt prompt_subst

########################################
# Key bindings
## vim 風キーバインドにする
bindkey -v


########################################
# Completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'
## sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin


########################################
# Prompt

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' max-exports 2
zstyle ':vcs_info:*' formats "%F{green}%u%c(%s)-[%b]%f"
zstyle ':vcs_info:*' actionformats "%F{green}%u%c(%s)-[%b|%a]%f"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{cyan}"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"

precmd () { vcs_info }

PROMPT="
"
PROMPT+='%F{blue}%d%f $vcs_info_msg_0_'
PROMPT+="
"
PROMPT+='[%n] %(?.$.%F{red}$%f) '

RPROMPT="[%D %*]"

########################################
# エイリアス
## OS 別の設定
case ${OSTYPE} in
    darwin*)
        export CLICOLOR=1
        alias ls='ls -F -G'
        alias tmux="TERM=screen-256color-bce tmux"
        ;;
    linux*)
        alias ls='ls -F --color=auto'
        ;;
esac

alias ll='ls -l'
alias la='ls -la'

alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias less='less --tabs=4'

alias vi='vim'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

#########################################

# local bin
export PATH=$PATH:~/bin
#
# for Homebrew
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# for golang
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/develop/go
    export PATH=$HOME/develop/go/bin:$GOROOT/bin:$PATH
fi

# for ruby
if [ -x "`which rbenv`" ]; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# for python
if [ -x "`which pyenv`" ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# peco
if [ -x "`which peco`" ]; then
    source $XDG_CONFIG_HOME/peco/peco_functions.sh
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--layout=reverse'

