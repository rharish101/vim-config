" Silently execute python3 to avoid deprecation warnings
if has('python3')
  silent! python3 1
endif

" Set very magic mode on by default
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

set nocompatible                    " don't go into Vi mode, use VIM's features
let mapleader=","                   " map leader changed to comma
set noruler                         " hide the position of cursor in the buffer
set laststatus=0                    " hide the statusline
set encoding=utf-8                  " allow UTF8 characters to be viewed
set nowrap                          " don't wrap lines
set nrformats=alpha                 " allow incrementing alphabets
set fileformat=unix                 " set unix file format
set splitbelow                      " split new windows below current
set splitright                      " split new windows to the right of current
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set number relativenumber           " always show line numbers
set cursorline cursorlineopt=number " highlight the current line number
set visualbell                      " don't beep
set noerrorbells                    " don't beep
set showmatch                       " set show matching parenthesis
set updatetime=1000                 " set update time for the swap file
set history=1000                    " remember more commands and search history
set mouse=a                         " enable mouse support
set undolevels=1000                 " use many muchos levels of undo
set undofile                        " maintain undo history between sessions
set undodir=~/.vim/undodir          " undo save directory
set formatoptions+=ro               " allow auto-adding of comments
" highlight extra whitespace
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/

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
" shortcut for fixing indent-issues
nnoremap <leader>s :set foldmethod=indent<CR>
" shortcut for toggling a fold
nnoremap <space> za
" remember folds after closing and when opening files
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent loadview
  autocmd BufWinEnter ?* set foldmethod=indent
augroup END

" Buffers
set hidden                  " allow changing buffers without saving
command BufDelete bp | bd # " command to delete buffer compatible with NERDTree
" shortcuts for moving b/w buffers
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Syntax Highlighting
if &t_Co >= 256 || has("gui_running")
  colorscheme gogh
endif
if &t_Co > 2 || has("gui_running")
  syntax on " switch syntax highlighting on, when the terminal has colors
endif

" File extension specific settings
autocmd FileType python setlocal completeopt-=preview
filetype plugin indent on           " enable plugins, indentation and features based on the filetype
" Indentation for webdev languages, markdown and vimrc
au BufNewFile,BufRead *.php,*.js,*.ts,*.html,*.css,*.scss,*.json,*.vimrc,*.R
  \ setlocal tabstop=2 |
  \ setlocal shiftwidth=2
au BufNewFile,BufRead *.py
  \ set foldignore-=#               " allow folding of comments
au BufNewFile,BufRead *.ts
  \ setlocal filetype=javascript    " enable javascript-like syntax highlighting for typescript
au BufNewFile,BufRead *.tex
  \ setlocal filetype=tex           " by default it is simpletex
au FileType tex
  \ setlocal spell spelllang=en_gb  " UK English spell check for tex files
au FileType text
  \ execute ':IndentLinesDisable' | " disable indentation lines
  \ setlocal noexpandtab            " do not convert tabs to spaces for standard text

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \ gvy/<C-R><C-R>=substitute(
  \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \ gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \ gvy?<C-R><C-R>=substitute(
  \ escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \ gV:call setreg('"', old_reg, old_regtype)<CR>

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
  \ 'r': ['rlanguageserver'],
  \ }
let g:ale_python_black_options='--fast --line-length=79'     " use black with line length limit of 79
" Enable pydocstyle for docstring linting
let g:ale_python_pyls_config={'pyls': {'plugins': {
  \ 'pydocstyle': {'enabled': v:true}
  \ }}}
let g:ale_haskell_ghc_options='-dynamic'
" Set fixers for linting issues
let g:ale_fixers={
  \ 'python': ['black', 'isort'],
  \ 'go': ['gofmt'],
  \ 'cpp': ['clang-format', 'clangtidy'],
  \ 'r': ['styler'],
  \ }
let g:ale_fix_on_save=1                                      " fix files on save
let g:ale_completion_enabled=1                               " enable ALE's completion through LSP
set omnifunc=ale#completion#OmniFunc                         " make vim's omnicompletion use ALE, because supertab uses it for tab completion
set completeopt+=noinsert                                    " fix for ALE auto completion
let g:ale_set_balloons=1                                     " enable ballon text using mouse hover through LSP
nmap <leader>f :ALEFix<CR>
nmap <leader>gd :ALEGoToDefinition<CR>

" Options for the plugin indentLine
let g:indentLine_showFirstIndentLevel = 1                      " show first indent level
let g:indentLine_first_char = '▏'                              " character for indent lines
let g:indentLine_char = '▏'                                    " character for indent lines
let g:indentLine_color_term = 8                                " do not change gray color
let g:indentLine_color_gui = '#505666'                         " do not change gray color
let g:indentLine_bufTypeExclude = ['tex', 'json', 'markdown']  " exclude tex and json files
let g:indentLine_fileTypeExclude = ['tex', 'json', 'markdown'] " exclude tex and json files
" define command and function for changing indentation level for tabs
" this is because the indentLine plugin also needs to be refreshed
function SetIndent(indent)
  let &shiftwidth=a:indent
  execute ":IndentLinesReset"
endfunction
command -nargs=1 SetIndent call SetIndent(<f-args>)

" Options for the plugin vim-shebang
let g:shebang#shebangs = {
  \ 'python' : '#!/usr/bin/env python3',
  \ 'awk': '#!/usr/bin/awk -f',
  \ 'php': '',
  \ 'sh' : '#!/usr/bin/zsh',
  \ }

" Options for other plugins
let g:instant_markdown_autostart = 0                           " don't start instant markdown preview on start
let g:SuperTabDefaultCompletionType = '<c-n>'                  " tab completion from top to bottom
let g:NERDSpaceDelims = 1                                      " delimit comments by one space
let g:NERDCustomDelimiters = {'python': {'left': '#'}}         " workaround for double-space in python
let g:NERDDefaultAlign = 'left'                                " align comment symbols to the left
let g:strip_whitespace_on_save = 1                             " strip trailing whitespace on save
let g:livepreview_engine = 'xelatex -shell-escape'             " default pdf engine for latex-preview
let g:fastfold_fold_command_suffixes = []                      " fastfold
au FileType tex let b:AutoPairs = AutoPairsDefine({'$' : '$'}) " add custom auto-pairs mapping for inline math in LaTeX
" close NERDTree on closing all buffers
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

packloadall          " load all plugins
silent! helptags ALL " load all helptags

call ale#linter#Define('r', {
\   'name': 'rlanguageserver',
\   'lsp': 'stdio',
\   'executable': 'R',
\   'command': 'R --slave -e "languageserver::run()"',
\   'project_root': '',
\})
