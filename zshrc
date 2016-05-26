# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Alternative customization directory (in dotfiles repo)
ZSH_CUSTOM=$HOME/.oh-my-zsh_custom

# Set this to "random" to load a random theme
ZSH_THEME="naegelejd"

# ZSH aliases
alias v=vim
alias vi=vim
# OSX: alias tar=gtar
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias when='stat -f "Accessed: %Sa%nModified: %Sm%nCreated:  %Sc%nBorn:     %SB"'
function sizes {
    if [ "$#" -lt 1 ]; then
        du -s ./* | sort -n
    else
        test -d "$1" && du -s "$1"/* | sort -n || du -sh "$1"
    fi
}

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
    # Some tools like GHC need Homebrew dyld path explicitly defined
    export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH

    # MacTex
    export PATH=$PATH:/usr/texbin

    # X11 (for AFNI?)
    export PATH=$PATH:/opt/X11/bin
    export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:/opt/X11/lib

    # If some fancy commands exist, print a fancy welcome!
    exists() { type $1 > /dev/null 2>&1 }
    welcome=""
    if $(exists fortune); then
        welcome="fortune"
        if $(exists cowsay); then
            welcome="${welcome} | cowsay -p -W 72 -f $HOME/.elephant.cow"
            if $(exists lolcat); then
                welcome="${welcome} | lolcat"
            fi
        fi
    fi
    eval ${welcome}
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

# Go
export GOPATH=$HOME/local
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin:$GOBIN:$PATH

# Rust
export RUST_HOME=/usr/local/rust
export DYLD_FALLBACK_LIBRARY_PATH=$RUST_HOME/lib
export PATH=$RUST_HOME/bin:$PATH

alias indent="indent -nfbs -di4 -i4 -npsl -ta -nut"
alias valgrindfull="valgrind --dsymutil=yes --leak-check=full"
alias clang++11="clang++ -std=c++11 -stdlib=libc++"

export PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#function targz {
#    _size=$(du -sb "$2" | cut -f 1)
#    tar cf - "$2" | pv -p -s $_size | gzip -c > $1
#}

# added by travis gem
[ -f /Users/naegelejd/.travis/travis.sh ] && source /Users/naegelejd/.travis/travis.sh
