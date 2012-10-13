#!/usr/bin/env bash

test -d ~/.vim
if [ $? -eq 0 ]; then
    echo "Your ~/.vim directory already exists"
    exit 1
else
    cd $(dirname $0)
    path=$(pwd)
    ln -s $path ~/.vim
fi
