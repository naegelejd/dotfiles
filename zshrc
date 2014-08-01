# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"

# ZSH aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode extract history history-substring-search colorize themes git go brew python django)

source $ZSH/oh-my-zsh.sh

# re-bind UP and DOWN arrow keys since this is broken in oh-my-zsh
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

# User configuration

export PATH="\
$HOME/bin:\
$HOME/src/snippets/scripts:\
$HOME/.cabal/bin:\
/usr/local/bin:\
/sbin:\
/usr/sbin:\
/bin:\
/usr/bin:\
/opt/X11/bin"

if [[ "$OSTYPE" == "darwin"* ]]; then
    random-color-terminal-app.sh
fi

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
unset SSH_ASKPASS   # prevent password GUI on Linux

# stop putting '._*' files into tarballs (extended attrs)
export COPYFILE_DISABLE=1

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN=ee972819452fa6e7469aa527d4b306781f77b6f5
# Some tools like GHC need Homebrew dyld path explicitly defined
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH

# Virtualenv
export VIRTUALENVWRAPPER_PYTHON=python2.7
export WORKON_HOME=$HOME/.venvs
. virtualenvwrapper.sh  # should be on $PATH

# Go
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export GOPATH=$HOME:$HOME/src/scratch/go
export GOBIN=$HOME/bin
export PATH=$GOROOT/bin:$GOBIN:$PATH

alias indent="indent -nfbs -di4 -i4 -npsl -ta -nut"
alias valgrindfull="valgrind --dsymutil=yes --leak-check=full"
alias clang++11="clang++ -std=c++11 -stdlib=libc++"

# Add Homebrew libxml2 python modules to PYTHONPATH
export PYTHONPATH=/usr/local/opt/libxml2/lib/python2.7/site-packages:$PYTHONPATH

# MacTex
export PATH=$PATH:/usr/texbin

# Afni
export PATH=$PATH:$HOME/abin
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:$HOME/abin

source $HOME/.ismrmrdrc
