DOTFILES = $(HOME)/.vimrc $(HOME)/.gvimrc
OTHER = $(HOME)/.vim/bundle $(HOME)/.vim/autoload
TARGETS = $(DOTFILES)
SHELL = /bin/bash

all:
	@echo type make install.

$(HOME)/.%: %
	ln -sf $(PWD)/$< $@

install: $(TARGETS)
	@vim +PlugInstall +qall

update:
	@echo Update vim plugins...
	@git pull
	@vim +PlugUpdate +qall

upgrade:
	@echo Upgrade vim-plug
	@vim +PlugUpgrade +qall

clean:
	rm -f $(DOTFILES)
	rm -rf $(OTHER)

.PHONY: install update upgrade clean
