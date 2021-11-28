#!/bin/sh

for file in .zprofile .vimrc .zshrc
do
        rm ~/$file
	ln -s `pwd`/$file ~/$file
done
