
" Basic stuff
"
set backup               " Turn on regular backups
set backupdir=~/.local/share/nvim/backup
set colorcolumn=160
set cursorline           " Highlight the current line
set expandtab            " Use spaces not tabs
set exrc                 " Read ./.vimrc
set fileformats=unix,dos,mac     " Choose line ending sanely
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0
set grepprg=ag\ --nogroup\ --nocolor
set hidden               " Allow buffers to be hidden when not visible
set ignorecase           " Case fold when searching
set lazyredraw           " Don't draw while executing macros and similar
set list                 " Show whitespace (trailing -s and >s)
set listchars=tab:▸\ ,trail:·,nbsp:_,extends:…
set matchtime=2          " Highlight matching bracket for 2/10ths of a second
set mouse=a              " Enable mouse mode
set nowrap               " Wrap lines by default
set nowritebackup        " No need to be too safe
set number               " Instead of showing 0 at the cursor line, show the actual line
set relativenumber       " Show line number distance from cursor for easy [N]j/[N]k
set scrolloff=7          " Keep 7 lines visible when moving through file
set secure               " Only allow safe things in ./.vimrc
set shiftwidth=2         " 2 space indent stops
set showmatch            " Highlight matching brackets
set showtabline=2        " Always show the tabline
set smartcase            " But don't case fold uppercase
set splitbelow           " Put new splits down
set splitright           " Put new vsplits right
set tabstop=2            " 2 space indent stops
set termguicolors        " Use true color support in terminals
set textwidth=0          " Don't wrap until I tell you
set timeoutlen=2000      " Set multikey timeout to 2 seconds
set undofile             " Persist undo information across sessions
set wildmode=list:longest,full " Configure wildmenu

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " call dein#add('~/1st/denite-hoogle')
  call dein#add('Dridus/denite-hoogle.nvim')

  call dein#add('Shougo/denite.nvim') " Helm/Ivy/Unite
  call dein#add('Shougo/deoplete.nvim') " Auto-completion
  call dein#add('elzr/vim-json')
  call dein#add('fsharp/vim-fsharp')
  call dein#add('hashivim/vim-terraform')
  call dein#add('int3/vim-extradite') " Git log browser
  call dein#add('justinmk/vim-dirvish') " File browser that isn't NetRW
  call dein#add('kristijanhusak/vim-dirvish-git') " Git symbols for dir edits
  call dein#add('lsdr/monokai')
  call dein#add('michaeljsmith/vim-indent-object') " Indented blocks as text objects
  call dein#add('moll/vim-bbye') " Layout-preserving :Bdelete and :Bwipeout
  call dein#add('neomake/neomake')
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('nixprime/cpsm') " Fuzzy matching used in denite. nix-shell -p python3 -p cmake -p boost -p ncurses; cmake -DPY3:BOOL=true; make; make install
  call dein#add('parsonsmatt/intero-neovim')
  call dein#add('simnalamburt/vim-mundo') " Undo tree browser
  call dein#add('spwhitt/vim-nix')
  " call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' }) " Auto-completion via TabNine
  call dein#add('tpope/vim-commentary') " Add/remove comments
  call dein#add('tpope/vim-fugitive') " A git wrapper so awesome, it should be illegal
  call dein#add('tpope/vim-repeat') " Support . with plugins
  call dein#add('tpope/vim-surround') " Best thing ever?
  call dein#add('vim-airline/vim-airline') " Good status bars
  call dein#add('vim-airline/vim-airline-themes') " Good status bars, with colors
  call dein#add('vim-scripts/Align') " Second best thing ever?
  call dein#add('vim-scripts/gitignore') " Read .gitignore files into wildignore
  call dein#add('vim-scripts/nc.vim--Eno')

  call dein#end()
  call dein#save_state()
endif

set background=dark
colorscheme monokai
let g:airline_theme='molokai'

" Deoplete
"
call deoplete#enable()

" Denite
"
call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm', 'matcher/hide_hidden_files'])
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> * denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <tab> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" Airline
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#enabled = 0

" Alignment

"
let g:loaded_AlignMapsPlugin=1

" Haskell
"
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_disable = 1          " get your dirty automation off my indents

let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
augroup haskell
  autocmd!
  autocmd FileType haskell set errorformat=
    \%C\t%.%#,
    \%W\ \ \ \ %f:%l:%c:\ Warning:,
    \%E\ \ \ \ %f:%l:%c:,
    \%Z\ \ \ \ ,\ \ \ \ %f:%l:%c:\ %m
augroup END

" Intero
"
augroup interoMaps
  au!
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  " au BufWritePost *.hs InteroReload
  au FileType haskell nnoremap <silent> <leader>ir :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>
  au FileType haskell nnoremap <silent> <leader>ie :InteroEval<CR>
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>
  au FileType haskell nnoremap <silent> <leader>id :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
augroup END
let g:intero_start_immediately = 0
let g:intero_window_size = 80
let g:intero_vertical_split = 1
set updatetime=1000
let g:intero_backend = {
  \ 'command': 'cabal new-repl',
  \ }

" Scala
"
autocmd BufNewFile,BufRead *.scala set sw=2
autocmd BufNewFile,BufRead *.scala set nocscopetag

" Git
"
let g:extradite_width = 60

" Python
"
autocmd BufNewFile,BufRead *.py set sw=2

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

" Neomake
"
let g:neomake_cabalnew_maker = {
  \ 'exe': 'cabal',
  \ 'args': ['new-build'],
  \ 'errorformat': 
  \ join([
  \   '%A%f:%l:%c:',
  \   '%A%f:%l:%c: %m',
  \   '%+C    %m',
  \   '%-Z%[%^ ]',
  \ ], ',')
  \ }
call neomake#config#set('maker_defaults.buffer_output', 0)


" ********************************************************************************
" Leader key mappings

let mapleader = " "
let g:mapleader = " "

" Buffer management
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
noremap <leader>bd :Bd<cr>
noremap <leader>bD :1,$bd<cr>

" Alignment mappings
" these first two suppress cecutil.vim from binding them to <leader>swp and
" <leader>rwp
" map <c-x>swp <Plug>SaveWinPosn
" map <c-x>rwp <Plug>RestoreWinPosn
map <Leader>xa= :Align =<CR>
map <Leader>xa: :Align ::<CR>
map <Leader>xa, :Align ,<CR>
map <Leader>xa<bar> :Align <bar><CR>
map <leader>xar :Align

" Git
nmap <leader>gs :Gstatus<CR>
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

" Denite
nnoremap <silent> <leader>bb :Denite -start-filter buffer<cr>
nnoremap <silent> <leader>bl :Denite buffer<cr>
nnoremap <silent> <leader>pf :Denite -start-filter file/rec buffer<cr>
nnoremap <silent> <leader>/ :Denite grep:.<cr>
nnoremap <silent> <leader>ss :Denite -start-filter line<cr>
nnoremap <silent> <leader>hh :Denite -start-filter help<cr>
nnoremap <silent> <leader>rl :Denite -resume<cr>
nnoremap <silent> <leader>y :Denite register<cr>

" Denite hoogle
nnoremap <silent> <leader>Hi :Denite hoogle -default-action=insert_import<cr>
nnoremap <silent> <leader>Hl :Denite hoogle -default-action=open_link<cr>

" Miscellaneous
"

" Clear the highlight
map <silent> <leader>sc :nohlsearch<cr>
" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
" Show Mundo
nmap <silent> <leader>au :MundoToggle<CR>
" Switch to the most recent buffer
nmap <silent> <leader><tab> :b#<cr>
" Sort words in a visual range
vnoremap <C-s> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<cr>
" Show the type with Intero
nmap <silent> <leader>t <Plug>InteroGenericType
" Write the current file and trigger :Neomake!
nmap <silent> <leader>wm :w<cr>:Neomake!<cr>

" ********************************************************************************
" Other mappings

" Q to execute the q macro, quickly
nnoremap Q @q

" Navigate quickfix with arrow keys
nnoremap <silent> <up> :copen 25<cr>
nnoremap <silent> <right> :cnext<cr>
nnoremap <silent> <down> :cclose<cr>
nnoremap <silent> <left> :cprevious<cr>
nnoremap <silent> <cr> :cc<cr>

" Insert line break
nnoremap <C-j> i<cr><esc>
" Accept the first completion immediately
inoremap <silent> <tab> <c-r>=pumvisible() ? "\<lt>c-n>\<lt>c-y>" : "\<lt>tab>"<cr>

" Show highlighting and syntax information at point
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
