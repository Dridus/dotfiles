" Basic stuff
"
set nocompatible
filetype off

set autoindent           " Copy indent from current line
set autoread             " Automatically reload changed files
set backspace=eol,start,indent " Make backspace helpful
set backup               " Turn on regular backups
set backupdir=~/.vim/backup
set cursorline           " Highlight the current line
set directory=~/.vim/tmp
set encoding=utf8        " Be reasonable
set expandtab            " Use spaces not tabs
set exrc                 " Read ./.vimrc
set fileformats=unix,dos,mac     " Choose line ending sanely
set hidden               " Allow buffers to be hidden when not visible
set history=1000         " Remember ONE THOUSAND commands
set hlsearch             " Show search matches until :noh
set ignorecase           " Case fold when searching
set incsearch            " Highlight as the search is entered
set laststatus=2         " Always show the status line, NO EXCEPTIONS
set lazyredraw           " Don't draw while executing macros and similar
set matchtime=2          " Highlight matching bracket for 2/10ths of a second
set mouse=a              " Enable mouse mode
set noerrorbells         " Quiet
set nowrap               " Wrap lines by default
set nowritebackup        " No need to be too safe
set number               " Instead of showing 0 at the cursor line, show the actual line
set relativenumber       " Show line number distance from cursor for easy [N]j/[N]k
set ruler                " Show column position, but airline does no matter what
set scrolloff=7          " Keep 7 lines visible when moving through file
set secure               " Only allow safe things in ./.vimrc
set shiftwidth=4         " 4 space indent stops
set showmatch            " Highlight matching brackets
set smartcase            " But don't case fold uppercase
set smarttab             " No dumb tabs
set splitbelow           " Put new splits down
set splitright           " Put new vsplits right
set tabstop=4            " 4 space indent stops
set textwidth=0          " Don't wrap until I tell you
set timeoutlen=2000      " Set multikey timeout to 2 seconds
set undodir=~/.vim/backup
set undofile
set vb t_vb=
set wildmenu             " Show the completion menu when tab completing
set wildmode=list:longest,full " Configure wildmenu

" Vundle
"
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

" Plugin 'jgdavey/tslime.vim' " Communication with tmux
Plugin 'Shougo/vimproc.vim'              " Asynchronous execution. Required by ghcmod
Plugin 'Shougo/neocomplete.vim'          " Autocompletion
" Plugin 'scrooloose/syntastic' " Syntax check after save
Plugin 'moll/vim-bbye'                   " Sane :bdelete
Plugin 'nathanaelkane/vim-indent-guides' " Visible indent guides
Plugin 'tpope/vim-fugitive'              " Main git action
Plugin 'int3/vim-extradite'              " Fancy git log
Plugin 'vim-scripts/gitignore'           " .gitignore -> wildignore
Plugin 'scrooloose/nerdtree'             " File tree
Plugin 'bling/vim-airline'               " Fancy status bar
Plugin 'kien/ctrlp.vim'                  " Go to anywhere
Plugin 'majutsushi/tagbar'               " Outline panel
Plugin 'vim-scripts/Align'               " Alignment!
" Plugin 'godlygeek/tabular'               " More alignment!
Plugin 'vim-scripts/Gundo'               " Fancy undo tree
Plugin 'tpope/vim-commentary'            " Comment things!
Plugin 'michaeljsmith/vim-indent-object' " Text object that follows indentation
" Plugin 'christoomey/vim-tmux-navigator' " Window navigate out of vim into tmux
Plugin 'raichoo/haskell-vim'
" Plugin 'enomsg/vim-haskellConcealPlus' " Haskell unicode sugar
Plugin 'eagletmt/ghcmod-vim'             " Integration with ghc-mod to do type information
Plugin 'eagletmt/neco-ghc'               " Neocomplete support using GHC
Plugin 'Twinside/vim-hoogle'             " Hoogle (type search for haskell)
Plugin 'rking/ag.vim'                    " Fast file search
Plugin 'chriskempson/base16-vim'         " Color schemes
Plugin 'tpope/vim-surround'              " Put delimiters around things
Plugin 'derekwyatt/vim-scala'            " Scala support
Plugin 'kien/rainbow_parentheses.vim'    " Colorize nested expressions
Plugin 'Keithbsmiley/swift.vim'          " Swift support
Plugin 'bronson/vim-visual-star-search'  " Use * on visually selected text to search for it
Plugin 'elzr/vim-json'                   " Better JSON syntax coloring
Plugin 'tpope/vim-eunuch'                " Vim sugar for common UNIX shell commands
Plugin 'bkad/CamelCaseMotion'            " CamelCase and words_in_identifiers movement
Plugin 'coderifous/textobj-word-column.vim' " Column text objects
Plugin 'Lokaltog/vim-easymotion'

call vundle#end()
filetype plugin indent on






" Color and such
"
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default

syntax enable

highlight clear Conceal
highlight Search ctermbg=81
highlight CursorLineNr ctermfg=12 cterm=bold

" Show whitespace
"
set list                 " Show whitespace (trailing -s and >s)
set listchars=tab:▸\ ,trail:·,nbsp:_,extends:…

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Folding
"
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Airline
"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_buffers = 0

" CtrlP
"
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git)$' }
let g:ctrlp_extensions = ['buffertag', 'tag']
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Neocomplete
"
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_smart_case = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" Indent Guides
"
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=15
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=21
let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size = 1

" Rainbow Parentheses
"
" au VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" NERDtree
"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen = 1    " Close nerdtree after a file is selected
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" Alignment
"
let g:loaded_AlignMapsPlugin=1

" Haskell
"
let $PATH = $PATH . ':' . expand("~/.haskell-vim-now/bin")
let g:necoghc_enable_detailed_browse = 1
let g:no_haskell_conceal = 1
let g:haskell_conceal = 0
let g:haskell_conceal_wide = 0
let g:haskell_conceal_enumerations = 0
let g:haskell_tabular = 1
set tags=tags;/,codex.tags;/
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" Git
"
let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list, '')
endfunction

" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
augroup haskell
  autocmd!
  autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

set cscopeprg=~/.haskell-vim-now/bin/hscope
" search codex tags first
set cscopetagorder=1
set cscopetag
set cscopeverbose
" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    " suppress 'duplicate connection' error
    set nocscopeverbose
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
autocmd BufEnter /*.hs call LoadHscope()


" Scala
"
autocmd BufNewFile,BufRead *.scala set sw=4
autocmd BufNewFile,BufRead *.scala set makeprg=mvn\ install
autocmd BufNewFile,BufRead *.scala set nocst
highlight scalaDef cterm=bold
highlight scalaClass cterm=bold
highlight scalaObject cterm=bold
highlight scalaTrait cterm=bold

" JSON
"
let g:vim_json_syntax_conceal = 0

" reStructuredText
"
autocmd BufNewFile,BufRead *.rst set sw=3
autocmd BufNewFile,BufRead *.rst set makeprg=make\ html

" Remove trailing whitespace on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup whitespace
  autocmd!
  autocmd BufWrite *.hs :call DeleteTrailingWS()
augroup END

" EasyMotion
"
let g:EasyMotion_do_mapping = 0 " Control all the mappings
let g:EasyMotion_smartcase = 1 " Match set smartcase

" Mappings
"

let mapleader = " "
let g:mapleader = " "

" Move around windows with <c-direction> rather than <c-w>direction
noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l

" Open window splits in various places
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

" Buffer management
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
noremap <leader>bd :Bd<cr>
noremap <leader>b<space> :CtrlPBuffer<cr>

" Q to execute the q macro
nnoremap Q @q

" Navigate quickfix with arrow keys
nnoremap <silent> <up> :copen<cr>
nnoremap <silent> <right> :cnext<cr>
nnoremap <silent> <down> :cclose<cr>
nnoremap <silent> <left> :cprevious<cr>

" Tags and such
map <leader>tg :!codex update<CR>:call system("git hscope")<CR><CR>:call LoadHscope()<CR>
map <leader>tt :TagbarToggle<CR>
map <leader>t<space> :CtrlPTag<cr>

" Autocompletion
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Haskell specific mappings
" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>
" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle
" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>
" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo
" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>

" Alignment mappings
map <Leader>a= :Align =<CR>
map <Leader>a, :Align ,<CR>
map <Leader>a<bar> :Align <bar><CR>
map <leader>ap :Align

" Git
nmap <leader>gs :Gstatus<CR>
nmap <leader>gg :copen<CR>:GGrep 
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <C-s> <ESC>:call ToggleFindNerd()<CR>

" EasyMotion
nmap <Tab>; <Plug>(easymotion-next)
nmap <Tab>, <Plug>(easymotion-prev)
nmap <Tab>f <Plug>(easymotion-f)
nmap <Tab>F <Plug>(easymotion-F)
nmap <Tab>t <Plug>(easymotion-t)
nmap <Tab>T <Plug>(easymotion-T)
nmap <Tab>w <Plug>(easymotion-w)
nmap <Tab>W <Plug>(easymotion-W)
nmap <Tab>b <Plug>(easymotion-b)
nmap <Tab>B <Plug>(easymotion-B)
nmap <Tab>e <Plug>(easymotion-e)
nmap <Tab>E <Plug>(easymotion-E)
nmap <Tab>ge <Plug>(easymotion-ge)
nmap <Tab>gE <Plug>(easymotion-gE)
nmap <Tab>j <Plug>(easymotion-j)
nmap <Tab>k <Plug>(easymotion-k)
nmap <Tab>n <Plug>(easymotion-n)
nmap <Tab>N <Plug>(easymotion-N)
nmap <Tab>s <Plug>(easymotion-s2)

" Miscellaneous
" Save and make
map <leader>wm :w<cr>:mak<cr>
" Clear the highlight
map <silent> <leader><cr> :noh<cr>
" Redraw the screen
map <silent> <leader>r :redraw!<CR>
" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
" Show Gundo
nmap <silent> <leader>u :GundoToggle<CR>
" Show CtrlP
nnoremap <silent> <Leader><space> :CtrlP<CR>
" Make it easier to get out of insert mode
inoremap jj <esc>
" Toggle Rainbow parens
map <Leader>0 :RainbowParenthesesToggle<cr>
