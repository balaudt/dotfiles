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

function ExpandTags()
	let dir_tag=expand("%:p:h")."/tags"
	exe ":set tags+=".dir_tag
endfunction

syntax enable
set background=light
colorscheme solarized
map <D-e> :CtrlPMRU<CR>
map <C-Tab> :CtrlPSmartTabs<CR>
map <F12> :TagbarToggle<CR>
map <F8> :GundoToggle<CR>
let mapleader = " "
map <Leader>c :let @+ = expand("%:p")<CR>
map <Leader>t :tabnew 
map <Leader>T :tabclose<CR>
map <Leader>s :Rg 
map <Leader>S :call ExpandTags()<CR>
map <Leader>D :%d<CR>:w<CR>
map <Leader>q :qa<CR>
map <Leader>f :Autoformat<CR>
map <Leader>F :Autoformat 
map <Leader>r :CtrlPTag<CR>
map <Leader>o :ed 
map <Leader>O :tabo <CR>
map <Leader>h :Startify <CR>
map <Leader>d :vert diffsplit 
let g:tagbar_autofocus = 1
let g:vimwiki_list=[{'path':'~/vimwiki','automatic_nested_syntaxes':1,'auto_tags':1,'syntax':'markdown','ext':'.md'},
	\ {'path':'~/Dropbox/Personal/wiki','automatic_nested_syntaxes':1,'auto_tags':1,'syntax':'markdown','ext':'.md'}]
let g:netrw_liststyle=1
let g:netrw_sizestyle="h"
let g:startify_bookmarks = [{'y':'/Users/balamurugan/dev/yapee/'},
	\ {'t':'/Users/balamurugan/Temp'},
	\ {'c':'/Users/balamurugan/dev/cerberus'},
	\ {'s':'/Users/balamurugan/dev/cerberus/storm'}]
let g:startify_custom_header = ['Home page']
let g:startify_list_order = ['files','bookmarks']
let g:rg_highlight='true'

" Neo complete settings
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

filetype plugin on

set wildmenu
set wildignore=*.class

imap <C-a> <C-o>0
imap <C-e> <C-o>$
imap <C-f> <C-o>l
imap <C-b> <C-o>h
imap <C-n> <C-o>j
imap <C-p> <C-o>k
imap <C-v> <C-o><C-f>
imap <M-v> <C-o><C-b>
imap <M-f> <C-o>w
imap <M-b> <C-o>b
imap fd <Esc>
