"close vi compatible mode
set nocompatible

"show the line number before each line
set number

"set the syntax on 
syntax on

"open plugin
filetype on
filetype plugin on
filetype plugin indent on

"we have a fast terminal
set ttyfast

let maplocalleader=','        " all my macros start with ,
"set foldmethod=syntax         " fold on syntax automagically, always
"set foldcolumn=2              " 2 lines of column for fold showing, always
" open all folds
nmap <LocalLeader>fo  :%foldopen!<cr>
" close all folds
nmap <LocalLeader>fc  :%foldclose!<cr>
set dictionary=/usr/share/dict/words " more words!

"
"auto indent when start a new line
set autoindent

"auto read file which was changed outside vim
set autoread

"Do smart indent in c-like language
set smartindent

set cindent

"
set shiftwidth=4

set tabstop=4
set vb t_vb=
set ruler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Search Configure
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"increase search when type in
set incsearch

"highlight all match items, to cancel use command :noh
set hlsearch

"ignore case when search
set ignorecase

"scroll when the cursor is 3 lines bottom
set scrolloff=3

"set the line number width
set numberwidth=4

"highlight current line
set cursorline
:hi CursorLine cterm=none ctermbg=none ctermfg=blue

"set on menu prompt
set wildmenu

"set \ between windows
set fillchars=vert:\ ,stl:\ ,stlnc:\

""""""""""""""""""""""""""""""
" NERDTree setting
""""""""""""""""""""""""""""""
let NERDChristmasTree=1
let NERDTreeWinSize=40 
nmap <silent> <leader>tt :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Program Configure
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"auto insert header message
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.php exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'php' || filetype == 'java'
		call setline(1, "/******************************************************************")
		call append(line("."), " * File Name: ".expand("%"))
		call append(line(".")+1, " * Author: Fangmin Lv")
		call append(line(".")+2, " * mail: lvfm@yahoo-inc.com")
		call append(line(".")+3, " * Create Time: ".strftime("%c"))
		call append(line(".")+4, " ******************************************************************/")
		call append(line(".")+5, "")
	endif
	
	if &filetype == 'c'
		call append(line(".")+6, "#include <stdio.h>")
		call append(line(".")+7, "")
	elseif &filetype == 'cpp'
		call append(line(".")+6, "#include <iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")			
	endif
	"auto go to the end of the file
	"not work!!!!!
	autocmd BufNewFile * normal G
endfunc

" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
" ,tt will toggle taglist on and off
" nmap <LocalLeader>tt :Tlist<cr>

" Settings for tagbar.vim
nmap <LocalLeader>tt :TagbarToggle<cr>
let g:tagbar_compact=1

" ,nn will toggle NERDTree on and off
nmap <LocalLeader>nn :NERDTreeToggle<cr>
" theme
" colorscheme darkblue_my 
" sy on

"java auto complete
autocmd Filetype java set omnifunc=javacomplete#Complete
autocmd Filetype java set completefunc=javacomplete#CompeleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"autocmd Filetype java,javascript,jsp inoremap <buffer> . .<C-X><C-O><C-P>

" map keys
imap ;so System.out.println();<left><left>

" press enter to select auto complete
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" status line
set laststatus=2
if has('statusline')
	function! SetStatusLineStyle()
		let &stl="%f %y " .
				\"%([%R%M]%)" .	
				\"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
				\"%{'$'[!&list]}"               .
				\"%{'~'[&pm=='']}"              .
				\"%="                           .
		 		\"#%n %l/%L,%c%V "              .
				\""
	endfunc
	call SetStatusLineStyle()

	if has('title')
		set titlestring=%t%(\ [%R%M]%)
	endif
endif

" ---------------------------------------------------------------------------
"  mouse stuffs
set mouse=a                   " mouse support in all modes
set mousehide                 " hide the mouse when typing
" this makes the mouse paste a block of text without formatting it
" (good for code)
map <MouseMiddle> <esc>"*p

" ---------------------------------------------------------------------------
"  backup options
set backup
"  set backup to dedicated dir, not current dir
set backupdir=~/.backup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set history=200
"set viminfo='100,f1

" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700
	setlocal spell spelllang=en
	nmap <LocalLeader>ss :set spell!<CR>
endif

" toggle off help
let NERDTreeMinimalUI=0

" If I forgot to sudo vim a file, do that with :w!!
cmap w!! %!sudo tee > /dev/null %
" ruby helpers
iab rbang #!/usr/bin/env ruby
iab idef def initialize

" ---------------------------------------------------------------------------
" tabs
" (LocalLeader is ",")
map <LocalLeader>tc :tabnew %<cr>    " create a new tab
map <LocalLeader>td :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location

" jump between java import files, not sure why not working
" set suffixesadd+=.java

" bundle
call pathogen#infect()

" powerline setting
set guifont=utf-8
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'

" map c-h to c-w h
map <c-h> <c-w>h<c-w>
map <c-l> <c-w>l<c-w>
map <c-j> <c-w>j<c-w>
map <c-k> <c-w>k<c-w>

" no back up file
set nobackup
set nowritebackup

map ; :

set pastetoggle=<F2>
