
if !isdirectory(getenv('HOME') . '/.local/share/nvim/backup')
    execute '!mkdir -p ' . getenv('HOME') . '/.local/share/nvim/backup'
endif

" Basic stuff
"
let &backup = 1               " Turn on regular backups
let &backupdir = getenv('HOME') . '/.local/share/nvim/backup'
let &colorcolumn = 160
let &cursorline = 1           " Highlight the current line
let &expandtab = 1            " Use spaces not tabs
let &exrc = 1                 " Read ./.vimrc
let &fileformats = 'unix,dos,mac'     " Choose line ending sanely
let &foldmethod = 'indent'
let &foldnestmax = 5
let &foldlevelstart = 99
let &foldcolumn = 0
let &grepprg = 'rg'
let &hidden = 1               " Allow buffers to be hidden when not visible
let &ignorecase = 1           " Case fold when searching
let &lazyredraw = 1           " Don't draw while executing macros and similar
let &list = 1                 " Show whitespace (trailing -s and >s)'
let &listchars = 'tab:▸\ ,trail:·,nbsp:_,extends:…'
let &matchtime = 2          " Highlight matching bracket for 2/10ths of a second
let &mouse = 'a'              " Enable mouse mode
let &number = 1               " Instead of showing 0 at the cursor line, show the actual line
let &relativenumber = 1       " Show line number distance from cursor for easy j/k
let &scrolloff = 7          " Keep 7 lines visible when moving through file
let &secure = 1               " Only allow safe things in ./.vimrc
let &shiftwidth = 2         " 2 space indent stops
let &showmatch = 1            " Highlight matching brackets
let &showtabline = 2        " Always show the tabline
let &smartcase = 1            " But don't case fold uppercase
let &splitbelow = 1           " Put new splits down
let &splitright = 1           " Put new vsplits right
let &tabstop = 2            " 2 space indent stops
let &termguicolors = 1        " Use true color support in terminals
let &textwidth = 0          " Don't wrap until I tell you
let &timeoutlen = 2000      " Set multikey timeout to 2 seconds
let &undofile = 1            " Persist undo information across sessions
let &wildmode = 'list:longest,full' " Configure wildmenu
let &wrap = 0               " Don't wrap lines by default
let &writebackup = 0        " No need to be too safe

let &runtimepath = &runtimepath . ',~/.cache/dein/repos/github.com/Shougo/dein.vim'
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Colorz
  call dein#add('lsdr/monokai')
  call dein#add('kergoth/vim-hilinks')

  " Syntaxes
  call dein#add('Dridus/nc.vim')
  call dein#add('elzr/vim-json')
  call dein#add('hashivim/vim-terraform')
  call dein#add('LnL7/vim-nix')
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('rust-lang/rust.vim')

  " SCM
  call dein#add('tpope/vim-fugitive') " A git wrapper so awesome, it should be illegal
  call dein#add('kristijanhusak/vim-dirvish-git') " Git symbols for dir edits
  call dein#add('int3/vim-extradite') " Git log browser

  " Tools and navigation
  call dein#add('junegunn/fzf') " Fuzzy find
  call dein#add('justinmk/vim-dirvish') " File browser that isn't NetRW
  call dein#add('moll/vim-bbye') " Layout-preserving :Bdelete and :Bwipeout
  call dein#add('neomake/neomake')
  call dein#add('vim-scripts/gitignore') " Read .gitignore files into wildignore

  " Text manipulation
  call dein#add('michaeljsmith/vim-indent-object') " Indented blocks as text objects
  call dein#add('tpope/vim-commentary') " Add/remove comments
  call dein#add('tpope/vim-repeat') " Support . with plugins
  call dein#add('tpope/vim-surround') " Best thing ever?
  call dein#add('vim-scripts/Align') " Second best thing ever?

  " UI
  call dein#add('vim-airline/vim-airline') " Good status bars
  call dein#add('vim-airline/vim-airline-themes') " Good status bars, with colors
  call dein#add('simnalamburt/vim-mundo') " Undo tree browser

  call dein#end()
  call dein#save_state()
endif

let &background = 'dark'
colorscheme monokai
let g:airline_theme = 'molokai'

let s:win32yankpath = getenv('HOME') . '/.local/bin/win32yank.exe'
if executable(s:win32yankpath)
  let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {
        \   '*': s:win32yankpath . ' -i --crlf',
        \   '+': s:win32yankpath . ' -i --crlf',
        \ },
        \ 'paste': {
        \   '*': s:win32yankpath . ' -o --lf',
        \   '+': s:win32yankpath . ' -o --lf',
        \ },
        \ 'cache_enabled': 0,
        \ }
endif


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
let g:loaded_AlignMapsPlugin = 1

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
  autocmd FileType haskell let &errorformat = ''
    \%C\t%.%#,
    \%W\ \ \ \ %f:%l:%c:\ Warning:,
    \%E\ \ \ \ %f:%l:%c:,
    \%Z\ \ \ \ ,\ \ \ \ %f:%l:%c:\ %m
augroup END

" Scala
"
autocmd BufNewFile,BufRead *.scala let &shiftwidth = 2
autocmd BufNewFile,BufRead *.scala let &cscopetag = 0

" Git
"
let g:extradite_width = 60

" Python
"
autocmd BufNewFile,BufRead *.py let &shiftwidth = 2

" JSON
"
let g:vim_json_syntax_conceal = 0

" reStructuredText
"
autocmd BufNewFile,BufRead *.rst let &shiftwidth = 3
autocmd BufNewFile,BufRead *.rst let &makeprg = 'make html'

" Markdown
"
autocmd BufNewFile,BufRead *.md let &wrap = 1

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

" NC (G-code)
"
autocmd BufNewFile,BufRead *.mpf let &syntax = 'sinumerik'
autocmd BufNewFile,BufRead *.MPF let &syntax = 'sinumerik'
autocmd BufNewFile,BufRead *.spf let &syntax = 'sinumerik'
autocmd BufNewFile,BufRead *.SPF let &syntax = 'sinumerik'
" autocmd BufNewFile,BufRead *.tap let &syntax = 'nc'
" autocmd BufNewFile,BufRead *.TAP let &syntax = 'nc'
autocmd BufNewFile,BufRead *.ngc let &syntax = 'linuxcnc'
autocmd BufNewFile,BufRead *.NGC let &syntax = 'linuxcnc'

" Fuzzy finding variations
"

let s:rg_opts = '--line-number --column --no-messages --color=always'
let s:rg_fzf_opts = ['--ansi', '--delimiter', ':', '--nth', '4..']
let s:filepreview_fzf_opts = ['--preview=head -$FZF_PREVIEW_LINES {}']
let s:multi_fzf_opts = ['--multi', '--expect=ctrl-t,ctrl-v,ctrl-x', '--bind=ctrl-a:select-all,ctrl-d:deselect-all', '--color=hl:68,hl+:110']

function s:ParseFileLineColumn(line)
  let l:toks = split(a:line, ':')
  let l:d = {}
  let l:d.filename = l:toks[0]
  if len(l:toks) > 1 | let l:d.lnum = l:toks[1]             | endif
  if len(l:toks) > 2 | let l:d.col  = l:toks[2]             | endif
  if len(l:toks) > 3 | let l:d.text = join(l:toks[3:], ':') | endif
  return l:d
endfunction
  
function s:HandleFzfFiles(lines)
  if len(a:lines) < 2
    return
  endif

  let l:cmd = get({'ctrl-x': 'split', 'ctrl-v': 'vertical split', 'ctrl-t': 'tabedit'}, a:lines[0], 'edit')
  let l:hits = map(a:lines[1:], 's:ParseFileLineColumn(v:val)')

  for l:hit in l:hits
    execute l:cmd escape(l:hit.filename, ' %#\')
    if has_key(l:hit, 'lnum') | execute l:hit.lnum | endif
    if has_key(l:hit, 'col')  | execute 'normal!' l:hit.col . '|' | endif
  endfor
endfunction

function FzfFilesRec()
  call fzf#run({
    \ 'sink*': funcref('<sid>HandleFzfFiles'),
    \ 'source': 'fd --type f' ,
    \ 'options': s:filepreview_fzf_opts + s:multi_fzf_opts,
    \})
endfunction

function FzfFilesHere()
  call fzf#run({
    \ 'sink*': funcref('<sid>HandleFzfFiles'),
    \ 'source': 'ls',
    \ 'options': s:filepreview_fzf_opts + s:multi_fzf_opts,
    \ })
endfunction

function FzfRecentFilesAndBuffers()
  let l:candidates =
        \ extend(
        \   filter(copy(v:oldfiles), 'v:val !~ "fugitive:\\|NERD_tree\\|^/tmp/\\|.git/"'),
        \   map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)')
        \ )
  call fzf#run({
    \ 'sink*': funcref('<sid>HandleFzfFiles'),
    \ 'source': l:candidates,
    \ 'options': s:filepreview_fzf_opts + s:multi_fzf_opts,
    \ })
endfunction

function FzfLinesInFilesRec()
  call fzf#run({
    \ 'sink*': funcref('<sid>HandleFzfFiles'),
    \ 'source': 'rg ' . s:rg_opts . ' ' . shellescape(input('query: ')),
    \ 'options': s:rg_fzf_opts + s:filepreview_fzf_opts + s:multi_fzf_opts,
    \ })
endfunction

function s:HandleLinesInFilesRecQF(lines)
  if len(a:lines) < 2
    return
  endif

  let l:cmd = get({'ctrl-x': 'split', 'ctrl-v': 'vertical split', 'ctrl-t': 'tabedit'}, a:lines[0], 'edit')
  let l:hits = map(a:lines[1:], 's:ParseFileLineColumn(v:val)')
  let l:first_hit = l:hits[0]
  execute l:cmd escape(l:first_hit.filename, ' %#\')
  execute 'normal!' l:first_hit.lnum . 'G' . l:first_hit.col . '|'

  if len(a:lines) > 1
    call setqflist(l:hits)
    copen
    wincmd p
  endif
endfunction

function FzfLinesInFilesRecQF()
  call fzf#run({
    \ 'sink*': funcref('<sid>HandleLinesInFilesRecQF'),
    \ 'source': 'rg ' . s:rg_opts . ' ' . shellescape(input('query: ')),
    \ 'options': s:rg_fzf_opts + s:filepreview_fzf_opts + s:multi_fzf_opts,
    \ })
endfunction

function s:GoLine(line)
  execute 'normal!' split(a:line, ':')[0]
endfunction

function FzfLinesInBuffer()
  call fzf#run({
    \ 'sink': funcref('<sid>GoLine'),
    \ 'source': map(getline(0, line('$')), '(v:key+1) . ":" . v:val'),
    \ 'options': ['--no-multi', '--no-sort', '--delimiter', ':', '--nth', '2..'],
    \ })
endfunction

function s:GoBuffer(line)
  execute 'buffer' matchstr(a:line, '^[ 0-9]*')
endfunction

function FzfBuffers()
  redir => l:buffers
  silent buffers
  redir END

  call fzf#run({
    \ 'sink': funcref('<sid>GoBuffer'),
    \ 'source': split(l:buffers, '\n'),
    \ 'options': '--no-multi',
    \ })
endfunction

function FzfHelp()
  let l:candidates = []
  for tagsfile in globpath(&runtimepath, 'doc/tags', v:false, v:true)
    call extend(l:candidates, readfile(tagsfile))
  endfor
  call fzf#run({
    \ 'sink': 'help',
    \ 'source': l:candidates,
    \ })
endfunction

" ********************************************************************************
" Leader key mappings

let mapleader = ' '
let maplocalleader = ' '
let g:mapleader = ' '
let g:maplocalleader = ' '

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

" Navigation
nnoremap <silent> <leader>. :call FzfFilesRec()<cr>
nnoremap <silent> <leader>f. :call FzfFilesHere()<cr>
nnoremap <silent> <leader>fr :call FzfRecentFilesAndBuffers()<cr>
nnoremap <silent> <leader>ss :call FzfLinesInBuffer()<cr>
nnoremap <silent> <leader>/ :call FzfLinesInFilesRec()<cr>
nnoremap <silent> <leader>f/ :call FzfLinesInFilesRecQF()<cr>
nnoremap <silent> <leader>bb :call FzfBuffers()<cr>
nnoremap <silent> <leader>hs :call FzfHelp()<cr>
" nnoremap <silent> <leader>sr 


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
