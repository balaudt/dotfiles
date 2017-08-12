set ignorecase
set smartcase
set diffopt+=iwhite,icase
set number
set nowrap
set autoindent
set clipboard=unnamedplus,unnamed
set hlsearch
set cursorline
set laststatus=2
set ruler
set autoread
set autochdir
set wildmenu
call pathogen#infect()
let g:ctrlp_extensions = ['smarttabs','tag']
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'/Users/balamurugan/.vim/bundle/tagbar/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }


syntax enable
set background=light
colorscheme solarized
map <D-e> :CtrlPMRU<CR>
map <C-Tab> :CtrlPSmartTabs<CR>
map <Leader>o :CtrlPTag<CR>
map <F12> :TagbarToggle<CR>
map <F8> :GundoToggle<CR>
let mapleader = " "
map <Leader>c :let @+ = expand("%:p")<CR>
map <Leader>t :tabnew 
map <Leader>T :tabclose<CR>
map <Leader>s :Scratch<CR>
map <Leader>d :%d<CR>:w<CR>
map <Leader>q :qa<CR>
map <Leader>f :Autoformat<CR>
map <Leader>F :Autoformat 
map co :ed 
map cO :tabo <CR>
let g:tagbar_autofocus = 1
let g:vimwiki_list=[{'path':'~/vimwiki','automatic_nested_syntaxes':1,'auto_tags':1,'syntax':'markdown','ext':'.md'},
	\ {'path':'~/Dropbox/Personal/wiki','automatic_nested_syntaxes':1,'auto_tags':1,'syntax':'markdown','ext':'.md'}]

filetype plugin on
