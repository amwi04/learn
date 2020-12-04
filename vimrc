syntax enable
set tabstop=4
set expandtab
set relativenumber
filetype indent on
set autoindent
set nocompatible
colorscheme onedark
highlight LineNr ctermfg=DarkGrey
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Add plugins here
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'racer-rust/vim-racer'
Plugin 'tpope/vim-fugitive'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()
filetype plugin indent on
let g:airline_powerline_fonts = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set rtp+=/usr/local/opt/fzf
vmap <TAB> >gv
vmap <S-TAB> <gv
