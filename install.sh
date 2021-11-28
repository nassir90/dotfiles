#!/bin/sh

for file in .zprofile .vimrc .zshrc
do
	cp $file ~/$file
done
