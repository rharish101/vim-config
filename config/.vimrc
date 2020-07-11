" Set very magic mode on by default
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

let mapleader=","                   " map leader changed to comma
set noruler                         " hide the position of cursor in the buffer
set laststatus=0                    " hide the statusline
set encoding=utf-8                  " allow UTF8 characters to be viewed
set nowrap                          " don't wrap lines
set nrformats=alpha                 " allow incrementing alphabets
set splitbelow                      " split new windows below current
set splitright                      " split new windows to the right of current
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set number relativenumber           " always show line numbers
set cursorline cursorlineopt=number " highlight the current line number
set visualbell                      " don't beep
set noerrorbells                    " don't beep
set showmatch                       " set show matching parenthesis
set updatetime=1000                 " set update time for the swap file
set mouse=a                         " enable mouse support
set undofile                        " maintain undo history between sessions
set undodir=~/.vim/undodir          " undo save directory
set formatoptions+=ro               " allow auto-adding of comments

" Indentation
set expandtab     " convert tab to spaces
set tabstop=4     " a tab is four spaces
set softtabstop=4 " erase four indentation spaces with single backspace
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" Searching
set ignorecase " ignore case when searching
set smartcase  " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch   " highlight search terms
set incsearch  " show search matches as you type

" Folding
set foldmethod=indent " allow folding of code by indentation
set foldignore=       " allow folding of everything
" shortcut for toggling a fold
nnoremap <space> za
" remember folds after closing and when opening files
augroup AutoSaveFolds
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent loadview
augroup END

" Buffers
set hidden                  " allow changing buffers without saving
command BufDelete bp | bd # " command to delete buffer compatible with NERDTree
" shortcuts for moving b/w buffers
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" File extension specific settings
filetype plugin indent on           " enable plugins, indentation and features based on the filetype
let g:tex_flavor = 'latex'          " use filetype tex for all .tex files
autocmd FileType php,javascript,typescript,html,css,scss,json,vim,r,yaml
  \ call SetIndent(2)
autocmd FileType go,text
  \ setlocal noexpandtab            " do not convert tabs to spaces for standard text
autocmd FileType tex
  \ setlocal spell spelllang=en_gb  " UK English spell check for tex files

" Put \begin{} \end{} tags around the current word in TeX
au FileType tex inoremap <buffer> <C-N> <ESC>YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<ESC>kA
" Put inline \begin{} \end{} tags around the current Word in TeX
au FileType tex inoremap <buffer> <C-P> <ESC>yiWi\begin{<ESC>Ea}<space>\end{<ESC>pa}<ESC>Bhi

" Change case with ~ key
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Shortcuts for clipboard functionality
" do not erase clipboard on exit
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')
" normal mode
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p o<space><ESC>v"+p
nmap <leader><S-p> <S-o><space><ESC>v"+p
nmap <leader>d "+d
" visual mode
vmap <leader>y "+y
vmap <leader>Y "+yy
vmap <leader>p "+p
vmap <leader><S-p> <S-o><space><ESC>v"+p
vmap <leader>d "+d

" Options for the plugin ALE
" Enable some linters not done by default
let g:ale_linters={
  \ 'python': ['pyls'],
  \ 'cpp': ['clangd', 'gcc'],
  \ }
" Set fixers for linting issues
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
nnoremap <leader>f :ALEFix \| let &foldmethod=&foldmethod <CR>

" Options for the plugin indentLine
let g:indentLine_showFirstIndentLevel = 1   " show first indent level
let g:indentLine_first_char = '▏'           " character for indent lines
let g:indentLine_char = '▏'                 " character for indent lines
let g:indentLine_color_term = 8             " do not change gray color
let g:indentLine_color_gui = '#505666'      " do not change gray color
let g:indentLine_concealcursor = 'c'        " when to display concealed content in the cursor line
let g:indentLine_fileTypeExclude = ['text']
" define command and function for changing indentation level for tabs
" this is because the indentLine plugin also needs to be refreshed
function SetIndent(indent)
  let &tabstop=a:indent
  let &softtabstop=a:indent
  let &shiftwidth=a:indent
  if (index(g:indentLine_fileTypeExclude, &filetype) < 0)
    execute ":IndentLinesReset"
  endif
endfunction
command -nargs=1 SetIndent call SetIndent(<f-args>)

" Options for other plugins
let g:instant_markdown_autostart = 0                           " don't start instant markdown preview on start
let g:SuperTabDefaultCompletionType = '<c-n>'                  " tab completion from top to bottom
let g:NERDSpaceDelims = 1                                      " delimit comments by one space
let g:NERDCustomDelimiters = {'python': {'left': '#'}}         " workaround for double-space in python
let g:NERDDefaultAlign = 'left'                                " align comment symbols to the left
let g:livepreview_engine = 'xelatex -shell-escape'             " default pdf engine for latex-preview
au FileType tex let b:AutoPairs = AutoPairsDefine({'$' : '$'}) " add custom auto-pairs mapping for inline math in LaTeX
" close NERDTree on closing all buffers
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

packloadall          " load all plugins
silent! helptags ALL " load all helptags

" Syntax highlighting requires a loaded plugin
syntax on
set background=dark
set termguicolors " enable true-color support
colorscheme solarized8
