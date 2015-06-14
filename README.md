Installation
------------

To install, run

	git clone git://gitcafe.com/Havee/vimrc.git ~/.vim
	cd ~/.vim
	make install

To update the repository, run

	make update

or

	git init; git submodule update --init

Note
-----

If you are going to use this colorscheme of the configuration in Terminal mode (e.g. not in a GUI version like gvim or macvim), please consider setting your terminal emulator's colorscheme to used.

Test the terminals color bit depth:

	$ tput colors

If the result is 8, that means your Terminal was using 8 bit color (e.g. xterm on Gentoo), please:

	$ echo "export TERM=xterm-256color" >> ~/.bashrc

**Depends On curl for gist on this configration**

Other Notes
------------

vimrc.mine and gvimrc.mine contain system-specific settings or other settings
that should not be part of a general configuration. Thus, they are not tracked
in the repo. My vimrc.mine and gvim.mine are included as examples.
