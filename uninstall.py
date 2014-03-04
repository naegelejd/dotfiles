#!/usr/bin/env python
import os
from os.path import expanduser, dirname, realpath, splitext, join
import sys

home = expanduser('~')
dotfiles = dirname(realpath(expanduser(sys.argv[0])))
for df in os.listdir(dotfiles):
    if not splitext(df)[1] and not df.startswith('.'):
        link = join(home, '.%s' % df)
        os.unlink(link)
        print('rm %s' % (link,))
