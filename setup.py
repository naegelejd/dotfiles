#!/usr/bin/env python
"""
Symlinks every file/directory whose name is not in the ignore list and
does not start with a '.' to $HOME/
"""
import os
from os.path import basename, expanduser, dirname, realpath, join
import sys
import subprocess

ignore = ['README.md', 'setup.py']
home = expanduser('~')

def die(msg):
    sys.stderr.write(msg)
    sys.stderr.flush()
    sys.exit(1)

def _install(local, link):
    try:
        os.symlink(local, link)
    except:
        print('failed to link %s to %s' % (local, link))
    else:
        print('ln -s %s %s' % (local, link))

def _uninstall(local, link):
    try:
        os.unlink(link)
    except:
        print('failed to rm %s' % link)
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
    usage = "{0} [-i|-u|-h]".format(prog)
    hlp = "{0}\n\t-i\tinstall\n\t-u\tuninstall".format(usage)

    dotfiles = dirname(realpath(expanduser(sys.argv[0])))

    if len(sys.argv) < 2:
        die(usage)

    opt = sys.argv[1]

    if opt == '-h':
        print(hlp)
    elif opt == '-i':
        if subprocess.call(['git', 'submodule', 'init']) != 0:
            die('failed to init submodules')
        if subprocess.call(['git', 'submodule', 'update']) != 0:
            die('failed to update submodules')
        if not os.path.isdir('vim/bundle'):
            os.makedirs('vim/bundle')
        if not os.path.isdir('vim/bundle/Vundle.vim'):
            os.system('git clone https://github.com/gmarik/Vundle.vim vim/bundle/Vundle.vim')
        if subprocess.call(['vim', '+PluginInstall', '+qa']) != 0:
            die('failed to install vim plugins')
        install(dotfiles)
    elif opt == '-u':
        uninstall(dotfiles)
    else:
        die(usage)

if __name__ == "__main__":
    main()
