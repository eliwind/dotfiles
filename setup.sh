#!/usr/bin/env zsh

dotfiles_dir=${0:a:h}

ln -s ${dotfiles_dir}/.gitconfig ~
ln -s ${dotfiles_dir}/.gitignore ~
ln -s ${dotfiles_dir}/zsh/.oh-my-zsh_custom ~
ln -s ${dotfiles_dir}/zsh/.zshenv ~
ln -s ${dotfiles_dir}/zsh/.zshrc ~
ln -s ${dotfiles_dir}/.terminfo ~
ln -s ${dotfiles_dir}/.tmux.conf ~

cd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
