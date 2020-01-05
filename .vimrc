

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under specified directory
call plug#begin('~/.vim/plugged')

" Declare the list of plugins

" Shorthand notation fetches from https://github.com/.. 
" Plug 'sickill/vim-monokai'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'tpope/vim-surround'
" Plug 'gabrielelana/vim-markdown'

" List ends here. Plugins become visible to VIM after this call
call plug#end()

" Fix backspace
set backspace=indent,eol,start	" allow backspacing over all in insert mode

" Look and feel settings
set so=7				" Set 7 lines to cursor when moving vertically
set cursorline			" show cursor line
set wildmenu			" Command line's tab complete options as a menu
set title				" Set window title according to file being edited
set ruler				" Always show cursor position
set cmdheight=2			" Height of command bar
set laststatus=2		" Always show staus line even if only one window
set ttimeoutlen=100		" Set delay for key sequence to complete to 100ms
set number				" Enable line numbers

" Colorscheme, fonts and size set for GUI and Terminal
if has("gui_running")
	colorscheme industry
	set lines=70 columns=250
	set linespace=1
	if has('gui_macvim')
		set guifont=Monaco:h13
	elseif has('gui_win32')
		set guifont=Lucida_Console:h11
	elseif has('gui_gtk2')
		set guifont=Lucida_Console:h11
	endif
	" set guioptions-=m  "remove menu bar
	" set guioptions-=T  "remove toolbar
	" set guioptions-=r  "remove right-hand scroll bar
	" set guioptions-=L  "remove left-hand scroll bar
else
	colorscheme industry
endif

" Default status line with added format options
" set statusline=%<%f\ %h%m%r\ %{&fo}%=%-14.(%l,%c%V%)\ %P

" Custom status line with extra information related to buffers in use
set statusline=							" Start with blank status line

set statusline+=%t\ %y					" <file name> <file type>
set statusline+=\ %m%r					" <modified flag><read only flag>
set statusline+=\ fo:[%{&fo}]			" Format options

set statusline+=%=						" right-align from now on

set statusline+=%{SpellForStatusLine()}	" Spell flag
set statusline+=%{PasteForStatusLine()}	" paste flag
set statusline+=\ [%{mode()}\]          " current mode

set statusline+=\ %v\:%l\/%L            " column:line/lines 
set statusline+=\ B[%{bufnr('%')}]		" buffer number
set statusline+=\ W[%{winnr()}]			" window number

set statusline+=\ %#warningmsg#                 " Syntastic notifcations
set statusline+=\ %{SyntasticStatuslineFlag()}  " Syntastic status line 
set statusline+=\ %*

" Function to return text of paste status for display on status line
function! PasteForStatusLine()
    let paste_status = &paste
    if paste_status == 1
        return " [paste] "
    else
        return ""
    endif
endfunction
"
" Function to return text of spell status for display on status line
function! SpellForStatusLine()
    let spell_status = &spell
    if spell_status == 1
        return " [spell] "
    else
        return ""
    endif
endfunction

" Text entry setting defaults for code  - override with file specific later
set textwidth=79		" Set line length to 79
set colorcolumn=+1		" Highlight column at textwidth
set nowrap				" Do not wrap text at textwidth
set nolinebreak			" Do not break lines at textwidth
syntax enable			" Enable syntax highlighting
set nospell				" Enable only for language files
set formatoptions=ro

" Add format list pattetn to support unordered lists in markdown
set flp+=\\\|^\\s*\\[*+-]\\s*

" Reload files if changed from outside
set autoread

" Ignore temporary and other files in autocomplete
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

" Automatic options on buffer change
set autowriteall		" Autosave buffer on switch away
" set autochdir			" Auto set working dir to active buffer

" Prevent temporary files being created (and left)
set nobackup
set noswapfile	

" Undo options - persistent undo
if empty(glob("$HOME/.vim/undo/"))
	silent !mkdir -p $HOME/.vim/undo
endif

set undofile			" Create an undo file for each file
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Matchig brackets
set showmatch     		" Show matching parenthesis
set mat=2				" How many seconds to blink matching bracket this

" Search settings
set ignorecase 			" ignore case when searching
set smartcase    		" ignore case if search pattern is all lowercase
						" case-sensitive otherwise
set hlsearch      		" highlight search terms:set
set incsearch     		" show search matches as you type

" Indentation settings							
set autoindent			" Set cursor at same indent as above
set smartindent			" Try to be smart about indenting (C-Style)
set copyindent			" Use existing indents for new indents
set preserveindent		" Preserve as much indent as possible
set tabstop=4    		" a tab is four spaces
set softtabstop=4		" Set virtual tab stop (compat for 8-wide tabs)
set shiftwidth=4  		" number of spaces to use for autoindenting
set smarttab     		" insert tabs according to shiftwidth, not tabstop
set shiftround    		" Always round indents to muiltiples of sw
set cinoptions=:0		" Set cinoptions for code style
						" :0 do not indent switch case labels

" Enable filetype detection
" used for file specific autocmds 
filetype plugin on		" Enable filetype plugin
filetype indent on		" Enable indendation rules that are type specific

augroup FileSpecific
	au!
	au FileType text setl fo=n2qt wrap lbr et sts=4 sw=4 spell 
	au FileType markdown setl tw=79 fo=n2qt wrap lbr et sts=4 sw=4 spell 
	au FileType c setl fo=ro fdm=syntax 
	au FileType cpp setl fo=ro fdm=syntax
	au FileType make setl fo=ro noet ts=4
	au FileType vim setl fo=ro
	au FileType qf setl wrap
augroup END
" et[expandtab]		Insert spaces for TABSs
" fo[formatoption]	Format option
" ts[tabstop]		Number of columns for TAB
" sw[shiftwidth]	Number of coumns for indent
" sts[softtabstop]	Number of spaces to insert/remove for TAB
" tw[textwidth]		Text column to wrap at (display colour column)
" wrap				Wrap at end of visual line
" lbr[linebreak}	Break only at character in breakat

" Display cursor line only in active window
augroup CursLineInActiveWin
	au!
	au VimEnter,WinEnter,BufWinEnter * setl cursorline
	au WinLeave * setl nocursorline
augroup END

" 
" Plugin configuration 
" 

" Netrw config
"
" Disable Netrw - set loaded status to 1 prevents a module loading
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" NERDTree Config
"
" Intial width
let g:NERDTreeWinSize = 40
" Start in minimal UK mode (no help lines)
let g:NERDTreeMinimalUI = 1
" Use compact menu for file actions that fits on a single line
let g:NERDTreeMinimalMemu = 1
" Auto delete the buffer of the file just deleted in NERDTree
let g:NERDTreeAutoDeleteBuffer = 1
" Display tree direction arrows
let g:NERDTreeDirArrows = 1
" Show bookarks on open
let g:NERDTreeShowBookmarks = 1
" Character to seperate file/dir name from remainder
" \u00a0 is non breaking space
let g:NERDTreeNodeDelimiter = "\u00a0"
" Close sidebar when opening a file
let g:NERDTreeQuitOnOpen = 1
" Array of regex of files to ignore
let g:NERDTreeIgnore = ['\.pyc$','\.o$']

" Syntastic Config
"
" Always load loaction list with errors
let g:syntastic_always_populate_loc_list = 1
" Check files when opened or written back
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Open location list when errors detected and close when none
" let g:syntastic_auto_loc_list = 1
" Do not open location list when errors detected and close when none
let g:syntastic_auto_loc_list = 2
" Change status line text - [E:firstline #noerrs, W:firstline, #nowarns]
let g:syntastic_stl_format = "[%E{E: %fe #%e}%B{, }%W{W: %fw #%w}]"
let g:syntastic_error_symbol = "✗"

" Key mappings to make some things easier

mapclear

" Toggle NERDTree with <leader>n or <leader>N
" nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <F3> :NERDTreeToggle<cr>
nnoremap <S-F3> :NERDTreeFind<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

" Change pwd to directory of current file
nnoremap <leader>d :lcd %:p:h<cr>:pwd<cr>

" Toggle TagBar with <leader>t or F8
nnoremap <F8> :TagbarToggle<cr>
nnoremap <leader>t :TagbarToggle<cr>

" Toggle Syantastic mode
nnoremap <leader>S :SyntasticToggleMode<cr>
nnoremap <leader>c :SyntasticCheck<cr>
nnoremap <leader>C :SyntasticReset<cr>

" Toggle line numbers with leader + l/r 
" nnoremap <silent> <leader>l :set number!<cr>
nnoremap <silent> <leader>r :set relativenumber!<cr>

" Clear search buffer with <leader>/ - remove highlights
nnoremap <silent> <leader>/ :nohlsearch<CR>
" Clear search buffer with <c-s> - remove highlights
nnoremap <silent> <c-s> :nohls<cr>

" Buffer maps
" Switch buffers with leader leader
nnoremap <leader><leader> <C-^>
" Easy buffer list with <leader>b then command e.g. <leader>b5<cr>
nnoremap <leader>b :ls<cr>:b

" <leader> + f=write, x=cloe and keep win/tab, X=delete buffer (and win)
nnoremap <leader>f :w<cr>
nnoremap <leader>x :bp<cr>:bd # <cr>
nnoremap <leader>X :bd<cr>

" Toggle paste with leader+p
set pastetoggle=<leader>p

" K Splits line - complement of built-in J to join
nnoremap K i<cr><Esc>

" Insert a blank line in normal mode
" [<space> before the cursor (line above)
" ]<space> after the cursor (line below)
nnoremap <silent> [<space> O<esc>j
nnoremap <silent> ]<space> o<esc>k

" Build (change to leader-M?)
nnoremap <silent> <F9> :make<cr>
nnoremap <silent> <F8> :make clean<cr>
nnoremap <silent> <F10> :make run<cr>
nnoremap <silent> <leader>mm :make<cr>
nnoremap <silent> <leader>ma :make<cr>
nnoremap <silent> <leader>mc :make clean<cr>
nnoremap <silent> <leader>mr :make run<cr>

" Toggle spelling with <leader>s
nnoremap <silent> <leader>s :set spell!<cr>

" QuickFix navigation - make etc.
" leader+q/Q open/close quickfix
" []+q -  next/previous
" []+Q - first/last
nnoremap <silent> <leader>q :cw<cr>
nnoremap <silent> <leader>Q :cclose<cr>
nnoremap [q :cp<cr>
nnoremap ]q :cn<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

" Location List navigation - Syntastic errors, grep etc
" leader+l/L - open/close location list
" []+l -  next/previous
" []+L - first/last
" nnoremap <silent> <leader>e :Errors<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>L :lclose<cr>
nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [L :lfirst<cr>
nnoremap ]L :llast<cr>

" TAB navigation with TAB and S-TAB
" nnoremap <tab> :tabn<cr>
" nnoremap <S-tab> :tabp<cr>

" TAB navigation with [] + t/T
nnoremap [t :tabp<cr>
nnoremap ]t :tabn<cr>
nnoremap [T :tabfirst<cr>
nnoremap ]T :tablast<cr>

" Buffer management and movement
" Buffer navigation with [] + b/B
nnoremap [b :bnext<cr>
nnoremap ]b :bprev<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>
" Switch buffers with leader leader
nnoremap <leader><leader> <C-^>
" Easy buffer list with <leader>b then command e.g. <leader>b5<cr>
nnoremap <leader>b :ls<cr>:b

" Window command activation with <leader>w
:nnoremap <leader>w <C-w>

" Window navigation with C-hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quickly edit/reload vimrc
nnoremap <silent> <leader>ve :e $MYVIMRC<cr>
nnoremap <silent> <leader>vs :so $MYVIMRC<cr>

" Fold method with leader z
nnoremap <leader>zs :setl foldmethod=syntax<cr>
nnoremap <leader>zi :setl foldmethod=indent<cr>
nnoremap <leader>zn :setl foldmethod=manual<cr>
" Navigate folds with [z and ]z
nnoremap [z zk
nnoremap ]z zj

" Show whitepsace with leader k
" Show all TABs
nnoremap <leader>kt :/\t<cr>
" Show trailing whitespace
nnoremap <leader>ks :/\s\+$
" Show spaces before TABs
nnoremap <leader>kb :/ \+\ze\t
" Show spaces after TABs
nnoremap <leader>ka :/ \t\zs \+
" Show trailing whitespace after some text
nnoremap <leader>kw :/\S\zs\s\+$
