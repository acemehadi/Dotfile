source $HOME/.config/nvim/vim-plug/plugins.vim

set nocp ai bs=2 hls ic is lbr ls=2 mouse=a nu ru sc scs smd so=3 sw=4 ts=4
filetype plugin indent on
syn on
map gA m'ggVG"+y''
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}


autocmd filetype cpp nnoremap <F8> :w <bar> ter g++ -std=c++17 -O2 -Wall "%" ./a.out && time ./a.out <CR>
autocmd filetype python nnoremap <F8> :w <bar> ter python3 "%"<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $

:autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/temp.cpp
:autocmd BufNewFile *.py 0r ~/.config/nvim/templates/temp.py


