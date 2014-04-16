#!/usr/bin/env python
import os
from os.path import expanduser, dirname, realpath, splitext, join
import sys

home = expanduser('~')
dotfiles = dirname(realpath(expanduser(sys.argv[0])))
for df in os.listdir(dotfiles):
    if not splitext(df)[1] and not df.startswith('.'):
        link = join(home, '.%s' % df)
        try:
            os.unlink(link)
        except:
            print('Failed to rm %s' % link)
        else:
            print('rm %s' % link)
