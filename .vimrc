"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
call neobundle#end()

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"insert here your Neobundle plugins"
call neobundle#begin()
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jimsei/winresizer.git'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'grep.vim'
NeoBundle 'evidens/vim-twig'
NeoBundle 'miyakogi/seiya.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'fatih/vim-go'
call neobundle#end()

filetype plugin indent on

"==============================
" Basic Setting
"==============================
let mapleader=","

"""key mapping
nnoremap <Leader>t :NERDTreeToggle<CR>

"==============================
" winresizer
"==============================
let g:winresizer_enable = 1
let g:winresizer_start_key = '<C-E>' 

"==============================
" grep.vim
"==============================
" for mac
if has('unix')
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    if system('which gxargs')
      let Grep_Xargs_Path = 'gxargs'
    else
      let Grep_Find_Use_Xargs = 0
    endif
  endif
endif

" Rgrep under the current directory with :gr <args>
command! -nargs=1 Gr :Rgrep <args> *<Enter><CR>
"skip the following files from grep
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~'

"==============================
" seiya.vim
"==============================
let g:seiya_auto_enable=1

" edit tabs
nnoremap <C-w>t :tabnew<CR>

" move between tabs
nnoremap <C-n> gt
nnoremap <C-p> gT 

""" color
if &term =~ "xterm-256color" || &term =~ "screen-256color" || &term == "xterm"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" enable syntax highlighting
syntax enable

"""colorscheme molokai
"""colorscheme jellybeans
colorscheme iceberg

"""indent
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
set nu

"""indentLine
"""let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦' "use ¦, ┆ or │

"""neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets/,~/.vim/snippets'

"""lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [
      \      [ 'mode', 'paste' ],
      \      [ 'gitbranch', 'readonly', 'filename', 'modified' ]
      \    ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'fugitive#head'
      \ },
    \ }

function! LightlineFilename()
"  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
"show statusbar
set laststatus=2
