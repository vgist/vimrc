LOCATION = $(shell pwd)
OTHER = $(LOCATION)/plugged $(LOCATION)/autoload
SHELL = /bin/bash

all:
	@echo type make install.

install:
	@vim +PlugInstall +qall

update:
	@echo Update vim plugins...
	@git pull --ff-only
	@vim +PlugUpdate +qall

upgrade:
	@echo Upgrade vim-plug
	@vim +PlugUpgrade +qall

clean:
	rm -rf $(OTHER)

.PHONY: install update upgrade clean
