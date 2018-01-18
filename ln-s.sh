ln -s github-conf/.bash_aliases
ln -s github-conf/.bundle.vim
ln -s github-conf/.gitconfig
ln -s github-conf/.vimrc
ln -s github-conf/.gdbinit

head -3 .bash_aliases |cut -c 2- >> ~/.bashrc
