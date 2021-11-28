set number
set expandtab

let mapleader = " "

autocmd BufRead, BufNewFile *.latex source vimfiles/latex.vim
autocmd BufRead, BufNewFile *. source vimfiles/s.vim

nnoremap <leader>W :call system("wl-copy", @")
