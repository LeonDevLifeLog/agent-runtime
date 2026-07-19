# ~/.bashrc for agent

# 交互式 shell 才继续
case $- in
    *i*) ;;
      *) return;;
esac

# 历史设置
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# bash 补全
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi

# 提示符
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '

# PATH：用户本地 bin + Go 工作区
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Homebrew (Linuxbrew) 环境（交互式 shell 补全 MANPATH/INFOPATH 等）
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Ubuntu 下 bat/fd 的可执行名是 batcat/fdfind，补回常用名
alias bat='batcat'
alias fd='fdfind'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
