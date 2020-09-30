let g:spacevim_buffer_index_type = 0
let g:spacevim_colorscheme = 'molokai'
let g:spacevim_colorscheme_bg = 'dark'
let g:spacevim_custom_plugins = [
  \ ['Dridus/nc.vim', { 'on_ft': ['sinumerik', 'linuxcnc'] }],
  \ ]
let g:spacevim_enable_guicolors = v:true
let g:spacevim_escape_key_binding = ''
let g:spacevim_info_symbol = 'i'
let g:spacevim_statusline_separator = 'arrow'
let g:spacevim_statusline_inactive_separator = 'arrow'
let g:spacevim_windows_leader = ''

call SpaceVim#layers#load('autocomplete', {
      \ 'auto_completion_return_key_behavior': 'complete',
      \ 'auto_completion_tab_key_behavior': 'smart',
      \ })

call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('denite')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#sh')
call SpaceVim#layers#load('shell', {
      \ 'default_position': 'top',
      \ 'default_height': 30,
      \ })

