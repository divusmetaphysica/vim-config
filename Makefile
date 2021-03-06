BUNDLE    := .vim/bundle
FTPLUGIN  := .vim/after/ftplugin
DOTVIM    := $(HOME)/.config/nvim
DOTVIMRC  := $(HOME)/.config/nvim/init.vim
PYSTYLE   := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,python rust go))
JSSTYLE := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,c c++ lua javascript typescript))

all: apt_libs $(BUNDLE) $(BUNDLE)/Vundle.vim $(DOTVIM) $(DOTVIMRC) langstyles plugin_install
.PHONY: all apt_libs clean plugin_install langstyles

$(BUNDLE):
	mkdir -p $(BUNDLE)

$(BUNDLE)/Vundle.vim:
	git clone https://github.com/VundleVim/Vundle.vim $(BUNDLE)/Vundle.vim

$(DOTVIM):
	ln -s $(abspath .vim) $@

$(DOTVIMRC):
	ln -s $(abspath .vimrc) $@

apt_libs:
	sudo apt update
	sudo apt install build-essential cmake python3-dev
	sudo apt install clang-7 clang-tidy-7 clang-tools-7 libclang1-7
	sudo apt install universal-ctags

plugin_install:
	vim +PluginInstall +PluginUpdate +PluginClean +qall

clean:
	unlink $(DOTVIM)
	rm -fr .vim/
	unlink $(DOTVIMRC)

ftplugins:
	mkdir -p $(FTPLUGIN)

langstyles: ftplugins $(JSSTYLE) $(PYSTYLE)

$(JSSTYLE):
	touch $@
	echo "setlocal expandtab" >> $@
	echo "setlocal shiftwidth=2" >> $@
	echo "setlocal softtabstop=2" >> $@

$(PYSTYLE):
	touch $@
	echo "setlocal expandtab" >> $@
	echo "setlocal shiftwidth=4" >> $@
	echo "setlocal softtabstop=4" >> $@
