set nocompatible
set t_Co=256
set number

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * PlugUpgrade
autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'valloric/youcompleteme'
Plug 'airblade/vim-gitgutter'
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-commentary'
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'lilydjwg/colorizer'
Plug 'gerw/vim-hilinktrace'
Plug 'godlygeek/tabular'

" Color schemes
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'mhartington/oceanic-next'
Plug 'kamwitsta/flatwhite-vim'

call plug#end()

let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:quantum_italics = 1
let g:quantum_black = 1

if has('gui_running')
  colorscheme QuantumOcean
  set guifont=Iosevka_Type_ExtraLight:h15
endif

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

let g:polyglot_disabled = ['markdown']

" Ripgrep
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" File Browser
let g:netrw_browse_split = 4 " Open in last window 
let g:netrw_winsize = 18 " 25% of window
let g:netrw_banner = 0
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
