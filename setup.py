#!/usr/bin/env python
"""
Symlinks every file/directory lacking an extension from this repo to $HOME/
"""
import os
from os.path import basename, expanduser, dirname, realpath, join
import sys

ignore = ['README.md', 'install.py', 'uninstall.py']
home = expanduser('~')

def _install(local, link):
    try:
        os.symlink(local, link)
    except:
        print('Failed to link %s to %s' % (local, link))
    else:
        print('ln -s %s %s' % (local, link))

def _uninstall(local, link):
    try:
        os.unlink(link)
    except:
        print('Failed to rm %s' % link)
    else:
        print('rm %s' % link)

def _run(dotfiles, fn):
    for df in os.listdir(dotfiles):
        if df not in ignore and not df.startswith('.'):
            local = join(dotfiles, df)
            link = join(home, '.%s' % df)
            fn(local, link)

def install(dotfiles):
    _run(dotfiles, _install)

def uninstall(dotfiles):
    _run(dotfiles, _uninstall)

def main():
    prog = basename(sys.argv[0])
    usage = "{} [-i|-u|-h]".format(prog)
    hlp = "{}\n\t-i\tinstall\n\t-u\tuninstall".format(usage)

    dotfiles = dirname(realpath(expanduser(sys.argv[0])))

    if len(sys.argv) < 2:
        print(usage)
        sys.exit(1)

    opt = sys.argv[1]

    if opt == '-h':
        print(hlp)
    elif opt == '-i':
        os.system('git submodule init')
        os.system('git submodule update')
        install(dotfiles)
    elif opt == '-u':
        uninstall(dotfiles)
    else:
        print(usage)
        sys.exit(1)


if __name__ == "__main__":
    main()
