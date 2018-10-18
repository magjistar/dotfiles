imap <f4> <esc>:w<cr>:call VimuxRunCommand("clang++ -std=c++17 -Wall -o ./output/".expand("%:t").".out ".expand("%:p")." ".@r)<cr>i
map <f5> :call VimuxRunCommand("output/".expand("%:t").".out")<cr><c-l>
imap <f5> <esc>:call VimuxRunCommand("output/".expand("%:t").".out")<cr>i
map <f4> :w<cr>:call VimuxRunCommand("clang++ -std=c++17 -Wall -o ./output/".expand("%:t").".out ".expand("%:p")." ".@r) <c-r>r<cr>

