#!/usr/bin/env python
"""
Symlinks every file/directory lacking an extension from this repo to $HOME/
"""
import os
from os.path import expanduser, dirname, realpath, splitext, join
import sys

home = expanduser('~')
dotfiles = dirname(realpath(expanduser(sys.argv[0])))

os.chdir(dotfiles)
os.system('git submodule init')
os.system('git submodule update')

for df in os.listdir(dotfiles):
    if not splitext(df)[1] and not df.startswith('.'):
        src = join(dotfiles, df)
        dst = join(home, '.%s' % df)
        try:
            os.symlink(src, dst)
        except:
            print('Failed to link %s to %s' % (src, dst))
        else:
            print('ln -s %s %s' % (src, dst))
