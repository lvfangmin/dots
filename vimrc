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
set fillchars=vert:|

""""""""""""""""""""""""""""""
" NERDTree setting
""""""""""""""""""""""""""""""
let NERDChristmasTree=1
let NERDTreeWinSize=25
nmap <silent> <leader>tt :NERDTreeToggle<cr>

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
set history=1000
set viminfo='100,f1

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
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" no back up file
set nobackup
set nowritebackup

map ; :
set pastetoggle=<F2>

map <LocalLeader>r :MRU<cr>
map <Space> <c-f>

"syntax enable
"set background=light
"colorscheme solarized
let g:solarized_termcolors=256

set visualbell
set wildignore=*.o,*.obj,.git,*.jar,*.class
set title
set noswapfile
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.class

set statusline=%f\ %y\ %([%R%M]%)%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*%{'$'[!&list]}%{'~'[&pm=='']}%=#%n\ %l/%L,%c%V\
set softtabstop=4
set smartcase
set listchars=tab:▸▸,trail:<,extends:>,precedes:<,nbsp:%
set fileencodings=ucs-bom,utf-8,default,latin1
set expandtab
set dictionary=/usr/share/dict/words
set completeopt=menu
set backspace=2

nnoremap <silent> <LocalLeader>sf :CommandT<cr>
nnoremap <silent> <LocalLeader>E :e! ~/.vimrc<cr>
vnoremap <LocalLeader>y "+y"
nnoremap <LocalLeader>g :Ack <C-R><C-W><cr>
map <silent> <LocalLeader>vs :call conque_term#open('bash', ['belowright split', 'resize 8'])<cr>
map <silent> <LocalLeader>vv :call conque_term#open('bash', ['belowright vsplit'])<cr>
nnoremap <LocalLeader>vh :help<C-R><C-W><cr>

nnoremap <LocalLeader>w :so ~/.vimrc<cr>

inoremap <LocalLeader>, <C-X><C-U>

nnoremap <silent> <LocalLeader>h :JavaHierarchy<cr>
nnoremap <silent> <LocalLeader>v :Validate<cr>
nnoremap <silent> <LocalLeader>mg :JavaGetSet<cr>
nnoremap <silent> <LocalLeader>c :JavaCorrect<cr>
nnoremap <silent> <LocalLeader>si :ScalaImport<cr>
nnoremap <silent> <LocalLeader>s :ScalaSearch<cr>
nnoremap <silent> <LocalLeader>j :JavaSearchContext<cr>
nnoremap <silent> <LocalLeader>i :JavaImport<cr>


nmap <silent> <LocalLeader>d <Plug>DashSearch
nmap <LocalLeader>ff :QuickFixClear<cr>
nmap <LocalLeader>ss :SignClearAll<cr>

" edit snippets
map <LocalLeader>ej :sp ~/.vim/bundle/snipmate-snippets/snippets/java.snippets<cr>
map <LocalLeader>eg :sp ~/.vim/bundle/snipmate-snippets/snippets/_.snippets<cr>

nmap <Tab> :bn<CR>
nmap <LocalLeader>iv :set list!<CR>

hi Pmenu ctermbg=117 gui=bold
hi SignColumn ctermbg=NONE ctermfg=NONE

" auto remove all trailing white spaces
autocmd BufWritePre * :%s/\s\+$//e

" RainBow settings
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
