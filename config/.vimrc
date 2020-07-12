let mapleader=','                   " map leader changed to comma
set noruler                         " hide the position of cursor in the buffer
set laststatus=0                    " hide the statusline
set encoding=utf-8                  " allow UTF8 characters to be viewed
set nowrap                          " don't wrap lines
set nrformats=alpha                 " allow incrementing alphabets
set splitbelow splitright           " split new windows below or to the right of current
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set number relativenumber           " always show line numbers
set visualbell noerrorbells         " don't beep
set showmatch                       " set show matching parenthesis
set updatetime=1000                 " set update time for the swap file
set mouse=a                         " enable mouse support
set undofile undodir=~/.vim/undodir " maintain undo history between sessions in a directory
set formatoptions+=ro               " allow auto-adding of comments
set hidden                          " allow changing buffers without saving

" Indentation
set expandtab     " convert tab to spaces
set tabstop=4     " a tab is four spaces
set softtabstop=4 " erase four indentation spaces with single backspace
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" Searching
set ignorecase smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch            " show kearch matches as you type
set hlsearch             " highlight all search terms

" Folding
set foldmethod=indent " allow folding of code by indentation
set foldignore=       " allow folding of everything

" Highlight the current line number.
" Before this patch, setting 'relativenumber' did this, and 'cursorlineopt' wasn't present.
if has('patch-8.1.2019')
  set cursorline cursorlineopt=number
endif

" Save the file 'view' after closing and load it when opening
augroup AutoSaveFolds
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent loadview
augroup END

" File extension specific settings
filetype plugin indent on           " enable plugins, indentation and features based on the filetype
let g:tex_flavor = 'latex'          " use filetype tex for all .tex files
autocmd FileType php,javascript,typescript,html,css,scss,json,vim,r,yaml
  \ call SetIndent(2)
autocmd FileType go,text
  \ setlocal noexpandtab            " do not convert tabs to spaces for standard text
autocmd FileType tex
  \ setlocal spell spelllang=en_gb  " UK English spell check for tex files

" Do not erase clipboard on exit
autocmd VimLeave *
  \ call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')

" ==================================================
" Plugin Options
" ==================================================

" ALE
let g:ale_linters={
  \ 'python': ['pyls'],
  \ 'cpp': ['clangd', 'gcc'],
  \ }
let g:ale_fixers={
  \ 'python': ['black', 'isort'],
  \ 'cpp': ['clang-format', 'clangtidy'],
  \ }
let g:ale_python_black_options='--line-length=79'
let g:ale_python_pyls_config={'pyls': {
  \ 'configurationSources': ['flake8'],
  \ 'plugins': {
  \   'pydocstyle': {'enabled': v:true},
  \   'pyls_mypy': {'live_mode': v:false},
  \ },
  \ }}
let g:ale_fix_on_save=1              " fix files on save
let g:ale_completion_enabled=1       " enable ALE's completion through LSP
set omnifunc=ale#completion#OmniFunc " make vim's omnicompletion use ALE, because supertab uses it for tab completion
set completeopt="menu,noinsert"      " display just the completion menu (without preview), and don't insert text automatically
let g:ale_set_balloons=1             " enable ballon text using mouse hover through LSP

" indentLine
let g:indentLine_showFirstIndentLevel = 1   " show first indent level
let g:indentLine_first_char = '▏'           " character for indent lines
let g:indentLine_char = '▏'                 " character for indent lines
let g:indentLine_color_term = 8             " do not change gray color
let g:indentLine_color_gui = '#505666'      " do not change gray color
let g:indentLine_concealcursor = 'c'        " when to display concealed content in the cursor line
let g:indentLine_fileTypeExclude = ['text']

" Other plugins
let g:instant_markdown_autostart = 0                   " don't start instant markdown preview on start
let g:SuperTabDefaultCompletionType = '<c-n>'          " tab completion from top to bottom
let g:NERDSpaceDelims = 1                              " delimit comments by one space
let g:NERDCustomDelimiters = {'python': {'left': '#'}} " workaround for double-space in python
let g:NERDDefaultAlign = 'left'                        " align comment symbols to the left
let g:livepreview_engine = 'latexmk'                   " default pdf engine for latex-preview
autocmd FileType tex                                   " custom auto-pairs for inline math in LaTeX
  \ let b:AutoPairs = AutoPairsDefine({'$' : '$'})
autocmd BufEnter *                                     " close NERDTree on closing all buffers
  \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

packloadall          " load all plugins
silent! helptags ALL " load all helptags

" NOTE: Syntax highlighting requires a loaded plugin
syntax on
set background=dark
set termguicolors      " enable true-color support
colorscheme solarized8

" ==================================================
" Custom Functions and Commands
" ==================================================

" Command and function for changing tab indentation level
function! SetIndent(indent) abort
  let &l:tabstop=a:indent
  let &l:softtabstop=a:indent
  let &l:shiftwidth=a:indent
  " Refresh the indentLine plugin's indentation lines
  if (index(g:indentLine_fileTypeExclude, &filetype) < 0)
    execute ':IndentLinesReset'
  endif
endfunction
command! -nargs=1 SetIndent call SetIndent(<f-args>)

" Change case with ~ key
function! TwiddleCase(str) abort
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction

" Delete buffer while moving to the previous buffer
" This does not mess with NERDTree
command! BufDelete bp | bd #

" ==================================================
" Custom Shortcuts
" ==================================================

" 'Very Magic' mode on by default
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v
cnoremap >s/ >s/\v
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Toggle fold
nnoremap <space> za

" Moving b/w buffers
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

autocmd FileType tex
  "\ Put \begin{} \end{} tags around the current word
  \ inoremap <buffer> <C-N> <ESC>YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<ESC>kA
  "\ Put inline \begin{} \end{} tags around the current Word
  \ inoremap <buffer> <C-P> <ESC>yiWi\begin{<ESC>Ea}<space>\end{<ESC>pa}<ESC>Bhi

" Clipboard shortcuts
map <leader>y "+y
map <leader>Y "+yy
map <leader>p o<space><ESC>v"+p
map <leader><S-p> <S-o><space><ESC>v"+p
map <leader>d "+d

" Fix with ALE and take care of folding issues
nnoremap <leader>f :ALEFix \| let &foldmethod=&foldmethod <CR>

" Toggle between lower case, UPPER CASE, Capital Case
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
