#!/usr/bin/env python
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
        os.symlink(src, dst)
        print('ln -s %s %s' % (src, dst))
