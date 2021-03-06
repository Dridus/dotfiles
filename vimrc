
" Basic stuff
"
set nocompatible
filetype off

set autoindent           " Copy indent from current line
set autoread             " Automatically reload changed files
set backspace=eol,start,indent " Make backspace helpful
set backup               " Turn on regular backups
set backupdir=~/.vim/backup
set colorcolumn=160
set cursorline           " Highlight the current line
set directory=~/.vim/tmp//
set encoding=utf8        " Be reasonable
set expandtab            " Use spaces not tabs
set exrc                 " Read ./.vimrc
set fileformats=unix,dos,mac     " Choose line ending sanely
set grepprg=ag\ --nogroup\ --nocolor
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
"set noshowmode           " Don't show the mode because powerline will
set nowrap               " Wrap lines by default
set nowritebackup        " No need to be too safe
set number               " Instead of showing 0 at the cursor line, show the actual line
set pythonthreedll=/nix/store/bs03sg8b0gq2zr4v252hh9psp780qj5q-python3-3.8.5/lib/libpython3.so
set relativenumber       " Show line number distance from cursor for easy [N]j/[N]k
set ruler                " Show column position, but airline does no matter what
set scrolloff=7          " Keep 7 lines visible when moving through file
set secure               " Only allow safe things in ./.vimrc
set shiftwidth=2         " 2 space indent stops
set showmatch            " Highlight matching brackets
set showtabline=2        " Always show the tabline
set smartcase            " But don't case fold uppercase
set smarttab             " No dumb tabs
set splitbelow           " Put new splits down
set splitright           " Put new vsplits right
set tabstop=2            " 2 space indent stops
set textwidth=0          " Don't wrap until I tell you
set timeoutlen=2000      " Set multikey timeout to 2 seconds
set undodir=~/.vim/backup
set undofile
set vb t_vb=
set wildmenu             " Show the completion menu when tab completing
set wildmode=list:longest,full " Configure wildmenu

if has("gui_macvim")
  set macligatures
  set guifont=Fira\ Code:h10
endif

if has("gui_gtk")
  set guifont=Fira\ Code\ 7
  " relative to defaults:
  "   not [a]utoselect
  "   yes [c]onsole prompts
  "   not [m]enubar
  "   not [t]ear off menus
  "   not [T]oolbar
  set guioptions=cegirL
endif


" Vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/denite.nvim'
Plugin 'moll/vim-bbye'                   " Sane :bdelete
" Plugin 'nathanaelkane/vim-indent-guides' " Visible indent guides
" Plugin 'tpope/vim-fugitive'              " Main git action
" Plugin 'int3/vim-extradite'              " Fancy git log
Plugin 'vim-scripts/gitignore'           " .gitignore -> wildignore
" Plugin 'scrooloose/nerdtree'             " File tree
Plugin 'bling/vim-airline'               " Fancy status bar
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'majutsushi/tagbar'               " Outline panel
Plugin 'vim-scripts/Align'               " Alignment!
Plugin 'vim-scripts/Gundo'               " Fancy undo tree
Plugin 'tpope/vim-commentary'            " Comment things!
Plugin 'michaeljsmith/vim-indent-object' " Text object that follows indentation
" Plugin 'raichoo/haskell-vim'
Plugin 'vim-scripts/haskell.vim'
Plugin 'tpope/vim-surround'              " Put delimiters around things
Plugin 'derekwyatt/vim-scala'            " Scala support
Plugin 'bronson/vim-visual-star-search'  " Use * on visually selected text to search for it
Plugin 'elzr/vim-json'                   " Better JSON syntax coloring
Plugin 'tpope/vim-eunuch'                " Vim sugar for common UNIX shell commands
Plugin 'easymotion/vim-easymotion'       " Wacky super motion!
Plugin 'kshenoy/vim-signature'           " Show marks and bookmarks in the gutter
Plugin 'tpope/vim-repeat'                " Support . with plugins
" Plugin 'lambdatoast/elm.vim'             " Elm language highlighting
" Plugin 'raichoo/purescript-vim'
" Plugin 'Dridus/sbt-vim'
" Plugin 'uarun/vim-protobuf'
Plugin 'spwhitt/vim-nix'
Plugin 'bumaociyuan/vim-swift'
" Plugin 'Shougo/neomru.vim'
" Plugin 'rust-lang/rust.vim'

" Plugin 'jonathanfilip/vim-lucius'
" Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'

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

set background=dark
colorscheme solarized
" colorscheme lucius
" colorscheme base16-atelier-estuary-light
" LuciusLight

syntax enable

highlight clear Conceal
highlight Search ctermbg=81
highlight CursorLineNr ctermfg=12 cterm=bold

" Show whitespace
"
set list                 " Show whitespace (trailing -s and >s)
set listchars=tab:▸\ ,trail:·,nbsp:_,extends:…

" Folding
"
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Airline
" "
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#enabled = 0

" Unite
"
" let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
" let g:unite_source_history_yank_enable = 1
" let g:unite_source_grep_command = 'ag'
" let g:unite_source_grep_default_opts = '--nogroup --nocolor'
" let g:unite_source_grep_recursive_opt = ''

" NERDtree
"
" let g:NERDTreeShowLineNumbers=1
" let g:NERDTreeQuitOnOpen = 1    " Close nerdtree after a file is selected
" function! IsNERDTreeOpen()
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
" function! ToggleFindNerd()
"   if IsNERDTreeOpen()
"     exec ':NERDTreeToggle'
"   else
"     exec ':NERDTreeFind'
"   endif
" endfunction

" Denite
"
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy', 'matcher/hide_hidden_files'])
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', ['--'])

" Alignment
"
let g:loaded_AlignMapsPlugin=1

" Haskell
"
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

augroup haskell
  autocmd!
  autocmd FileType haskell setlocal indentkeys=
  autocmd FileType haskell set errorformat=%C\t%.%#,%W\ \ \ \ %f:%l:%c:\ Warning:,%E\ \ \ \ %f:%l:%c:,%Z\ \ \ \ ,\ \ \ \ %f:%l:%c:\ %m
augroup END

" Scala
"
autocmd BufNewFile,BufRead *.scala set sw=2
autocmd BufNewFile,BufRead *.scala set nocst
highlight scalaDef cterm=bold
highlight scalaClass cterm=bold
highlight scalaObject cterm=bold
highlight scalaTrait cterm=bold

" Python
"
autocmd BufNewFile,BufRead *.py set sw=2

" Elm
"
" autocmd FileType elm setlocal indentkeys=

" JSON
"
let g:vim_json_syntax_conceal = 0

" reStructuredText
"
autocmd BufNewFile,BufRead *.rst set sw=3
autocmd BufNewFile,BufRead *.rst set makeprg=make\ html

" Markdown
"
autocmd BufNewFile,BufRead *.md set wrap

" Remove trailing whitespace on save
function! DeleteTrailingWS()
  mark z
  %s/\s\+$//ge
  normal g'z
  delmarks z
endfunc

" EasyMotion
"
" let g:EasyMotion_do_mapping = 0 " Control all the mappings
" let g:EasyMotion_smartcase = 0 " Match set smartcase

" Mappings
"
let mapleader = " "
let g:mapleader = " "

" Buffer management
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
noremap <leader>bd :Bd<cr>
noremap <leader>bD :1,$bd<cr>

" Q to execute the q macro
nnoremap Q @q

" Navigate quickfix with arrow keys
nnoremap <silent> <up> :copen 25<cr>
nnoremap <silent> <right> :cnext<cr>
nnoremap <silent> <down> :cclose<cr>
nnoremap <silent> <left> :cprevious<cr>

" Alignment mappings
" these first two suppress cecutil.vim from binding them to <leader>swp and
" <leader>rwp
map <c-x>swp <Plug>SaveWinPosn
map <c-x>rwp <Plug>RestoreWinPosn
map <Leader>xa= :Align =<CR>
map <Leader>xa: :Align ::<CR>
map <Leader>xa, :Align ,<CR>
map <Leader>xa<bar> :Align <bar><CR>
map <leader>xar :Align

" Git
nmap <leader>gs :Gstatus<CR>
nmap <leader>gg :copen<CR>:GGrep 
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" If nerd tree is closed, find current file, if open, close it
" nmap <silent> <leader>pf <ESC>:call ToggleFindNerd()<CR>
" nmap <silent> <C-s> <ESC>:call ToggleFindNerd()<CR>

" Insert line break
nnoremap <C-j> i<cr><esc>
" Reindent line
nnoremap <tab> ==

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <C-s> <Plug>(easymotion-overwin-f2)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
" nmap <leader>\; <Plug>(easymotion-next)
" nmap <leader>\, <Plug>(easymotion-prev)
" nmap <leader>f <Plug>(easymotion-f)
" nmap <leader>F <Plug>(easymotion-F)
" nmap <leader>\t <Plug>(easymotion-t)
" nmap <leader>\T <Plug>(easymotion-T)
" nmap <leader>\w <Plug>(easymotion-w)
" nmap <leader>\W <Plug>(easymotion-W)
" nmap <leader>\b <Plug>(easymotion-b)
" nmap <leader>\B <Plug>(easymotion-B)
" nmap <leader>\e <Plug>(easymotion-e)
" nmap <leader>\E <Plug>(easymotion-E)
" nmap <leader>\ge <Plug>(easymotion-ge)
" nmap <leader>\gE <Plug>(easymotion-gE)
" nmap <leader>\j <Plug>(easymotion-j)
" nmap <leader>\k <Plug>(easymotion-k)
" nmap <leader>\n <Plug>(easymotion-n)
" nmap <leader>\N <Plug>(easymotion-N)
" nmap <leader>s <Plug>(easymotion-s)

" NERDTree
" nnoremap <silent> <leader>pt :NERDTree<cr>

" Switch buffers fast
nmap <D-1> <Plug>AirlineSelectTab1
nmap <D-2> <Plug>AirlineSelectTab2
nmap <D-3> <Plug>AirlineSelectTab3
nmap <D-4> <Plug>AirlineSelectTab4
nmap <D-5> <Plug>AirlineSelectTab5
nmap <D-6> <Plug>AirlineSelectTab6
nmap <D-7> <Plug>AirlineSelectTab7
nmap <D-8> <Plug>AirlineSelectTab8
nmap <D-9> <Plug>AirlineSelectTab9
nmap <D-left> <Plug>AirlineSelectPrevTab
nmap <D-right> <Plug>AirlineSelectNextTab

" Unite
" nnoremap <silent> <leader>bb :Unite -no-hide-icon -start-insert buffer<cr>
" nnoremap <silent> <leader>bl :Unite -no-hide-icon buffer<cr>
" nnoremap <silent> <leader>pT :Unite -no-hide-icon -start-insert tag<cr>
" nnoremap <silent> <Leader>pf :Unite -no-hide-icon -start-insert file_rec/async buffer<cr>
" nnoremap <silent> <leader>ff :Unite -no-hide-icon -start-insert file -path=<C-R>=expand("%:p:h") . '/'<CR><CR>
" nnoremap <silent> <Leader><space>w :Unite -no-hide-icon -start-insert window<cr>
" nnoremap <silent> <Leader>hh :Unite -no-hide-icon -start-insert help<cr>
" nnoremap <silent> <Leader>y :Unite -no-hide-icon -start-insert register history/yank<cr>
" " nnoremap <silent> <Leader><space>B :Unite -no-hide-icon -start-insert bookmark<cr>
" nnoremap <silent> <Leader>ss :Unite -no-hide-icon -start-insert line<cr>
" nnoremap <silent> <Leader>/ :Unite -no-hide-icon grep:.<cr>
" nnoremap <silent> <Leader>hl :UniteResume<cr>

" Denite
nnoremap <silent> <leader>bb :Denite buffer<cr>
nnoremap <silent> <leader>bl :Denite -mode=normal buffer<cr>
nnoremap <silent> <leader>pf :Denite file/rec buffer<cr>
nnoremap <silent> <leader>/ :Denite grep:.<cr>
nnoremap <silent> <leader>ss :Denite line<cr>
nnoremap <silent> <leader>hh :Denite help<cr>
nnoremap <silent> <leader>hl :Denite -resume<cr>
nnoremap <silent> <leader>y :Denite register<cr>

" Miscellaneous
" Clear the highlight
map <silent> <leader>sc :noh<cr>
" Redraw the screen
" map <silent> <leader>r :redraw!<CR>
" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
" Show Gundo
nmap <silent> <leader>au :GundoToggle<CR>
" Switch to the most recent buffer
nmap <silent> <leader><tab> :b#<cr>
" Sort words in a visual range
vnoremap <C-s> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<cr>

