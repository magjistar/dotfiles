map <silent><f3> :VtrSendLinesToRunner<cr>j
map <silent><leader><F4> :VtrOpenRunner{'orientation':'h', 'percentage':50,'cmd' :'node'}<cr>
au Bufenter  *.js  VtrOpenRunner{'orientation':'h', 'percentage':50,'cmd' :'node'}
let g:VtrUseVtrMaps=1
map <F5> V't:VtrSendLinesToRunner<cr>
imap <F5>     <esc>V't:VtrSendLinesToRunner<cr>i
