set exrc
set secure
"load ftplugins and indent files
filetype plugin indent on

"turn on syntax highlighting
syntax on
call plug#begin('~/.vim/plugged')

"let Vundle manage Vundle, required
Plug 'ternjs/tern_for_vim'
Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/L9'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'vim-scripts/YankRing.vim'
Plug 'majutsushi/tagbar'
Plug 'Valloric/MatchTagAlways'
Plug 'EinfachToll/DidYouMean'
Plug 'christoomey/vim-tmux-navigator' "switch between tmux panes and vim buffers
Plug 'christoomey/vim-tmux-runner'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
"Valloric
Plug 'Valloric/YouCompleteMe'
"Switch between source files .h .c :FSHERE FSLEFT :FSSwitchLeft
Plug 'vim-scripts/FSwitch'
Plug 'greyblake/vim-preview' "required ruby open html file in firefox 
Plug 'mattn/emmet-vim',{'for':['html','css']}
Plug 'othree/html5.vim',{'for':['html','css']}
Plug 'tpope/vim-git'
Plug 'benmills/vimux' "send command to tux from vim
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-jp/vim-cpp' "c++ 11 syntax support
Plug 'tpope/vim-obsession'
"auto pairing of \" ( { [
Plug 'Raimondi/delimitMate'
Plug 'Valloric/ListToggle'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-notes'
Plug 'fatih/vim-go'
Plug 'nsf/gocode',{'tag':'v.20150303','rtp':'vim'}
Plug  'xolox/vim-misc'
Plug 'leafgarland/typescript-vim'
call plug#end()

runtime macros/matchit.vim

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000
set cursorline 
set showcmd     "show incomplete cmds down the bottom
set number      "show line numbers
set relativenumber
"display tabs and trailing spaces
"set list
"set listchars=tab:▸\⋅,eol:¬,trail:⋅,nbsp:⋅
"set listchars=tab:⭰\⭲,eol:┘,trail:⋅,nbsp:⋅

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile
    set textwidth=80
    set colorcolumn=+1 "mark the ideal max text width
endif

set directory=~/.vim/swapfiles//

"default indent settings
set shiftwidth=2
set softtabstop=2
set noexpandtab
set autoindent
set pastetoggle=<F7>
set clipboard+=unnamed
set formatoptions=tcroqnj
" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#

" Number of screen lines to use for the command-line
set cmdheight=2

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1



"tell the term has 256 colors
set t_Co=256


"hide buffers when not displayed
set hidden
set ignorecase
set smartcase

"statusline setup
set statusline =%#identifier#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction


"make wrapped lines more intuitive
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

"fix for yankring and neovim
let g:yankring_clipboard_monitor=0

"vim-gist settings
let g:gist_post_private = 1
let g:gist_browser_command = 'sensible-browser %URL%'

"add new words (via zg) here
setlocal spellfile+=~/.vim/spell/en.utf-8.add

"make table-mode tables github-markdown compat
let g:table_mode_corner="|"

"syntastic settings
let syntastic_stl_format = '[Syntax: %E{line:%fe }%W{#W:%w}%B{ }%E{#E:%e}]'

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close vim if only NT is open
 "no file specified open nt automaticlly
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"tagbar settings
let g:tagbar_sort = 0

"Custom mappings
" our <leader> will be the space key
let mapleader=","

" our <localleader> will be the '-' key
let maplocalleader="-"
" Fast saving
nnoremap <leader>w :w!<cr>
inoremap <leader>w <esc>:w!<cr>i
"explorer mappings
nnoremap <leader>bb :BufExplorer<cr>
nnoremap <leader>bs :BufExplorerHorizontalSplit<cr>
nnoremap <leader>bv :BufExplorerVerticalSplit<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader>nn :e .<cr>
nnoremap <leader>nd :e %:h<cr>
nnoremap <leader>] :TagbarToggle<cr>
nnoremap <c-f> :CtrlP<cr>
nnoremap <c-b> :CtrlPBuffer<cr>


"ultisnips settings

let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsListSnippets='<s-tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif


"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

"gutentags settings
let g:gutentags_ctags_exclude = ['vendor/*', 'tmp/*', 'log/*', 'coverage/*', 'doc/*']

"tmux-vim-navigator setup
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    else
        call cursor(1,1)
    endif
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

"when copying/pasting from the term into :e from a git diff or rspec or
"similar we edit things like
"
"./app/models/foo.rb:10:in
"
"Save the time of stripping trailing shit and just make this edit and go to
"line 10.
autocmd bufenter * call s:checkForLnum()
function! s:checkForLnum() abort
    let fname = expand("%:f")
    if fname =~ ':\d\+\(:.*\)\?$'
        let lnum = substitute(fname, '^.*:\(\d\+\)\(:.*\)\?$', '\1', '')
        let realFname = substitute(fname, '^\(.*\):\d\+\(:.*\)\?$', '\1', '')
        bwipeout
        exec "edit " . realFname
        doautocmd bufread
        doautocmd bufreadpre
        call cursor(lnum, 1)
    endif
endfunction

"toggle a markdown notes file in a fixed window on the right with f12
nnoremap <F12> :NotesToggle<cr>
command! -nargs=0 NotesToggle call <sid>toggleNotes()
function! s:toggleNotes() abort
    let winnr = bufwinnr("notes.md")
    if winnr > 0
        exec winnr . "wincmd c"
        return
    endif

    botright 100vs notes.md
    setl wfw
    setl nonu

    "hack to make nerdtree et al not split the window
    setl previewwindow

    "for some reason this doesnt get run automatically and the cursor
    "position doesn't get set
    doautocmd bufreadpost %

    normal zMzO
endfunction

"command to filter :scriptnames output by a regex
command! -nargs=1 Scriptnames call <sid>scriptnames(<f-args>)
function! s:scriptnames(re) abort
    redir => scriptnames
        silent scriptnames
    redir END

    let filtered = filter(split(scriptnames, "\n"), "v:val =~ '" . a:re . "'")
    echo join(filtered, "\n")
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 ctrlp                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

 let g:ctrlp_map = '<leader>t'
 nnoremap <leader>n :CtrlPMRU<cr>
 nnoremap <leader>' :CtrlPClearCache<cr>

" Use Vim's cwd
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'

" Faster indexing of files; requires having ag (AKA the_silver_searcher)
" installed.
"let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
 ""     \ --ignore .git
  ""    \ --ignore .svn
   ""   \ --ignore .hg
    ""  \ --ignore .DS_Store
    ""  \ --ignore "**/*.pyc"
    ""  \ --ignore BoostParts
     "" \ -g ""'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yankring                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:yankring_history_dir = '$HOME/.vim/yankring'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>yrs :YRShow<CR>

" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-preview                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This forces vim-preview to use the default browser on linux; it already uses
" 'open' on Mac.
if has("unix")
  let g:PreviewBrowsers = "xdg-open"
endif

let g:PreviewMarkdownFences = 1

" Use :Preview command to open in browser!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              fuzzyfinder                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This turns on the mrufile and mrucmd modes
let g:fuf_modesDisable    = []
let g:fuf_mrufile_maxItem = 1000
let g:fuf_mrucmd_maxItem  = 400
let g:fuf_file_exclude    = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

nnoremap <Leader>fm :FufMruFile<CR>
nnoremap <Leader>fc :FufMruCmd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                fswitch                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" A "companion" file is a .cpp file to an .h file and vice versa

" Opens the companion file in the current window
nnoremap <Leader>sh :FSHere<cr>

" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Leader>sl :call FSwitch('%', 'wincmd l')<cr>

" Same as above, only opens it in window to the right
nnoremap <Leader>sr :call FSwitch('%', 'wincmd r')<cr>

" Creates a new window on the left and opens the companion file in it
nnoremap <Leader>sv :FSSplitLeft<cr>

" This handles c++ files with the ".cc" extension.
"augroup googleccfiles
 " au!
  au BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  au BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  au BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_auto_loc_list = 1 "Jascript setting
let g:syntastic_check_on_open = 1 "Jascripte setting
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = 'w'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length=80 ' .
      \ '--max-complexity=10 --ignore=E111,E114,E121,E125,E126,E127,E128,E129,' .
      \ 'E131,E133,E201,E202,E203,E211,E221,E222,E241,E251,E261,E303,E402,W503'

let g:syntastic_mode_map = {
       \ "mode": "active",
       \ "active_filetypes": [],
       \ "passive_filetypes": ["dart", "html"] }
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_cpp_clang_check_args=['-std=c++17 -Wall']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              YouCompleteMe                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_rust_src_path = $HOME . '/repos/rust/src'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_extra_conf_globlist = ['~/repos/*']
"let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"		undo 								"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
nnoremap ut :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               ListToggle                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 25

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-notes                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:notes_directories = ['~/.vim/notes']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Airline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_symbols = {}
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extension#syntastic#enabled =1
let g:airline#extension#obsession#indicator_text=1
let g:airline#extension#extension#ycm#enabled=1
let g:airline#extension#ycm#error_symbol='E:'
" unicode symbols
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
  let g:airline#extensions=['syntastic','ctrlp','obsession','tagbar','undotree','quickfix','hunks']
  let g:airline#extension#wordcount#enabled=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" watch for external changes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})
" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end
  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end
  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"
  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')
  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec
      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end
  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end
  echo msg
  let @"=reg_saved
endfunction
let autoreadargs={'autoread':1}
execute WatchForChanges("*",autoreadargs)
"
autocmd FileType python map <buffer><s-e> :w<cr>:! python %<CR>
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

map <down> :cnext<cr>
imap <down> <esc>:cnext<cr>
map <s-down> :cprevious<cr>
imap <s-down> <esc>:cprevious<cr>
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
map <f8> :w<cr>:!cls<cr>:make<cr>:vert copen 20<cr>
colorscheme koehler

if !exists ("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers={}
endif
let g:ycm_semantic_triggers['typescript']=['.']
