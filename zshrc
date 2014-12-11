# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Alternative customization directory (in dotfiles repo)
ZSH_CUSTOM=$HOME/.oh-my-zsh_custom

# Set this to "random" to load a random theme
ZSH_THEME="naegelejd"

# ZSH aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias ppjson="python -mjson.tool"

# Disabled:
# CASE_SENSITIVE="true"
# ENABLE_CORRECTION="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"      # speeds up ZSH in large repos

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Download: git clone git://github.com/zsh-users/zsh-syntax-highlighting.git to ~/.oh-my-zsh/plugins/
plugins=(vi-mode extract history history-substring-search colorize themes git go brew zsh-syntax-highlighting)

# Enable primary syntax highlighting and bracket matching
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

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
/usr/local/sbin:\
/sbin:\
/usr/sbin:\
/bin:\
/usr/bin:"

if [[ "$OSTYPE" == "darwin"* ]]; then
    osascript $HOME/src/snippets/scripts/RandomColorTerminal.app.scpt

    # Homebrew
    export HOMEBREW_GITHUB_API_TOKEN=ee972819452fa6e7469aa527d4b306781f77b6f5
    # Some tools like GHC need Homebrew dyld path explicitly defined
    export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH

    # MacTex
    export PATH=$PATH:/usr/texbin

    # X11 (for AFNI?)
    export PATH=$PATH:/opt/X11/bin
    export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:/opt/X11/lib
fi

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
unset SSH_ASKPASS   # prevent password GUI on Linux

# stop putting '._*' files into tarballs (extended attrs)
export COPYFILE_DISABLE=1

# Virtualenv
export VIRTUALENVWRAPPER_PYTHON=python2.7
export WORKON_HOME=$HOME/.venvs
. virtualenvwrapper.sh  # should be on $PATH

# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME:$HOME/src/scratch/go
export GOBIN=$HOME/bin
export PATH=$GOROOT/bin:$GOBIN:$PATH

alias indent="indent -nfbs -di4 -i4 -npsl -ta -nut"
alias valgrindfull="valgrind --dsymutil=yes --leak-check=full"
alias clang++11="clang++ -std=c++11 -stdlib=libc++"

# Afni
export PATH=$PATH:$HOME/abin
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:$HOME/abin

source $HOME/.ismrmrdrc

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
