set number
set expandtab

let mapleader = " "

autocmd BufRead, BufNewFile *.latex source ~/vimfiles/latex.vim
autocmd BufRead, BufNewFile *.s source ~/vimfiles/s.vim
autocmd BufRead, BufNewFile *.java source ~/vimfiles/java.vim

command Toaq source ~/vimfiles/toaq.vim

nnoremap <leader>/ :let @/ = ""
nnoremap <leader>W :call system("wl-copy", @")
nnoremap <leader>E :Ex

"new in vim 7.4.1042
" let g:word_count=wordcount().words
" function WordCount()
"     if has_key(wordcount(),'visual_words')
"         let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
"     else
"         let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
"     endif
"     return g:word_count
" endfunction
" 
" set statusline+=\ w:%{WordCount()},
" set laststatus=2 " show the statusline
