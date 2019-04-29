" Allow use of local .vimrc files
set exrc

" But prevent them from doing something potentially dangerous
" like running shell commands.
set secure

" Use a <leader> character easier to type than \
let mapleader = ","

" When opening a file with vim without cd to working directory first
" (e.g. when opening through GUI), change the working directory to the
" directory containing the file.
cd %:h

" Change tab size, as advised in the Vim documentation (:h tabstop)
set softtabstop=4
set shiftwidth=4
set noexpandtab

" To change the tab size for a specific file type, use autocommands,
" e.g. autocmd Filetype css setlocal tabstop=5
" (from https://stackoverflow.com/2054627/how-do-i-change-tab-size-in-vim)

" Limit line length to 72 characetrs in (La)TeX and Markdown files
autocmd bufreadpre *.tex setlocal textwidth=72
autocmd bufreadpre *.md setlocal textwidth=72

" For plugins to load correctly
filetype plugin indent on

" Automatic installation
" from https://github.com/junegunn/vim-plug/wiki/tips
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Change the local leader for mappings
let maplocalleader = ","

" Directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex' " A modern vim plugin for editing LaTeX files

Plug 'w0rp/ale' " Asynchronous Lint Engine: check syntax and semantics

Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal

Plug 'junegunn/goyo.vim' " Distraction-free writing in Vim

Plug 'junegunn/limelight.vim' " Hyperfocus writing in Vim

Plug 'JuliaEditorSupport/julia-vim' " Vim support for Julia

Plug 'davidhalter/jedi-vim', { 'commit': '1773837a11f311bd04755c70de363b5000c9cd15' } " Using the jedi autocompletion library for VIM

" Initialize plugin system
call plug#end()

" Remove the unwanted line of carets when using Goyo
" (Use <leader>yo instead of :Goyo to fire it up.)
map <leader>yo :Goyo <bar> highlight StatusLineNC ctermfg=white<CR>

" Limit the text width at 72 characters when using Goyo
let g:goyo_width = 72

" Set color for un-focused text when Limelight is enabled
let g:limelight_conceal_ctermfg = 'DarkMagenta'

" Fire up Limelight whenever Goyo is started
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Ensure :q to quit even when Goyo is active
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

map <leader>fi :set foldmethod=indent<CR>
map <leader>sc :setlocal spell spelllang=en_us<CR>
map <leader>py :Goyo 79<CR>
