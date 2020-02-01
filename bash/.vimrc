call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
" Neu 
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/itchyny/calendar.vim'

call plug#end()

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
source ~/.cache/calendar.vim/credentials.vim

syntax on
