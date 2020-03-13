call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'google/vim-searchindex'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-rsi'
Plug 'xtal8/traces.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'icymind/NeoSolarized'
Plug 'jesseleite/vim-agriculture'
Plug 'junegunn/vim-peekaboo'
Plug 'lifepillar/vim-mucomplete'
Plug 'mtth/scratch.vim'
Plug 'tyru/restart.vim'
Plug 'danro/rename.vim'
Plug 'adelarsq/vim-matchit'
call plug#end()

syntax enable
set background=light
colorscheme NeoSolarized

" auto-complete configuration
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
set showmode shortmess-=c
set completeopt+=menuone,noinsert,noselect
let g:mucomplete#enable_auto_at_startup = 1

" Some personal better defaults
set ignorecase
set smartcase
set diffopt+=iwhite,icase
set number
set nowrap
set clipboard=unnamedplus,unnamed
set hlsearch
set cursorline
set autoread
let mapleader = " "
let maplocalleader = "\\"
let g:tagbar_autofocus=1
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
inoremap jj <Esc>
filetype plugin on
set foldmethod=syntax
set foldlevelstart=9

" function key bindings
map <F12> :Tagbar<CR>

" root leader keys
map <leader>' :terminal<CR>

" b - buffers
map <leader>b0 :tabfirst<CR>
map <leader>b$ :tablast<CR>
map <leader>bb :Buffers<CR>
map <leader>bd :bd<CR>
map <leader>bn :bnext<CR>
map <leader>bp :bprevious<CR>
map <leader>bo :%bd\|e#\|bd#<CR>
map <leader>bh :Startify<CR>
map <leader>bs :Scratch<CR>
map <leader>bu :u1\|u<CR>
map <leader>br :rename 

" f - files
map <leader>fed :ed ~/.vimrc<CR>
map <leader>ff :tabnew
map <leader>fc ggVGy<CR>
map <leader>fr :History<CR>
map <leader>fy :let @+ = expand("%:p")<CR>
map <leader>fs :BTags<CR>
map <leader>fS :wa<CR>
map <leader>f0 :set foldlevel=0<CR>
map <leader>f1 :set foldlevel=1<CR>
map <leader>f2 :set foldlevel=2<CR>
map <leader>f3 :set foldlevel=3<CR>
map <leader>f4 :set foldlevel=4<CR>
map <leader>f5 :set foldlevel=5<CR>
map <leader>f6 :set foldlevel=6<CR>
map <leader>f7 :set foldlevel=7<CR>
map <leader>f8 :set foldlevel=8<CR>
map <leader>f9 :set foldlevel=9<CR>

" g - git
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gb :Gblame<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>
map <leader>gr :Gread<CR>
map <leader>gw :Gwrite<CR>
map <leader>ge :Gedit<CR>
map <leader>gh :BCommits<CR>

" j - jump
map <leader>j <Plug>(easymotion-prefix)

" m - localleader 
map <leader>mf :Autoformat<CR>
map <leader>mF :Autoformat

" p - projects
map <leader>pf :Files<CR>
map <leader>ps :Tags<CR>

" q - quit
map <leader>qq :q<CR>
map <leader>qr :Restart<CR>

" s -search
map <leader>sp :RgRaw

" t -toggles
map <leader>tl yow<CR>

" w - window
map <leader>ww <C-W>w
map <leader>wr <C-W>r
map <leader>wc <C-W>c
map <leader>wq <C-W>q
map <leader>wj <C-W>j
map <leader>wk <C-W>k
map <leader>wh <C-W>h
map <leader>wl <C-W>l
map <leader>wH <C-W>5<
map <leader>wL <C-W>5>
map <leader>wJ :resize +5<CR>
map <leader>wK :resize -5<CR>
map <leader>w= <C-W>=
map <leader>ws <C-W>s
map <leader>wv <C-W>v
