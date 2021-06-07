ln -sf github-conf/.bash_aliases
ln -sf github-conf/.bundle.vim
ln -sf github-conf/.gitconfig
ln -sf github-conf/.vimrc
ln -sf github-conf/.gdbinit
ln -sf github-conf/.tmux.conf
ln -sf github-conf/.tmux.reset.conf

head -5 .bash_aliases |cut -c 2- >> ~/.bashrc
