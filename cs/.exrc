imap <f9> <esc>:w<cr><esc>!mcs %<cr><esc>:!mono %<.exe<cr>i
imap <f8> <esc>:!rm %<.exe><esc>:w<cr><esc>!mcs %<cr><esc>:!mono %<.exe<cr>i
map <down> :cnext<cr>
imap <down> <esc>:cnext<cr>
map <s-down> :cprevious<cr>
imap <s-down> <esc>:cprevious<cr>
map <f4> :w<cr>:VimuxRunCommand("clear;csc ".bufname("%")) <c-r>r<cr>
imap <f4> <esc>:w<cr>:VimuxRunCommand("clear;csc ".bufname("%")) <c-r>r<cr>
imap <f5> <esc>:VimuxRunCommand("clear;echo "."new output\n"."mono ".fnamemodify(bufname("%"),":r").".exe") <c-r>a<cr>
map <f5> :VimuxRunCommand("clear;echo "."new output\n"."mono ".fnamemodify(bufname("%"),":r").".exe") <c-r>a<cr>
map <up> <c-w>k
map <s-up> <c-w>j
map <right> <c-w>l
map <s-right> <c-w>h
map <left> :bnext<cr>
imap <left> <esc>:bnext<cr>
map <s-left> :bprevious<cr>
imap <s-left> <esc>:bprevious<cr>
map <c-left> :buffers<cr>
map <c-s-left> :buffer
map <s-f4> <esc>:compiler cs<cr>:set makeprg=csc\ *.cs<cr>
map <f8> :w<cr>:!cls<cr>:make<cr>:vert copen 20<cr>
imap <f8> <esc>:w<cr>:!cls<cr>:make<cr>:vert copen 20<cr>
map <s-f8> :!del *.exe<cr>
colorscheme koehler


