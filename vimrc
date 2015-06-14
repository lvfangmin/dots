"close vi compatible mode
set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
call pathogen#infect()
call pathogen#helptags()

let maplocalleader=','            " all my macros start with ,
filetype plugin indent on         " enable detection, plugins and indenting in one step
syntax on                         " set the syntax on

" ---------------------------------------------------------------------------
" General Settings
set ttyfast                       " always with a fast terminal
set number                        " show the line number before each line
set autoindent                    " auto indent when start a new line
set autoread                      " auto reload files changed outside vim
set smartindent                   " c like smart indent
set cindent
set smarttab                      " insert tabs on the start of a line according to
                                  " shiftwidth
set shiftwidth=2
set tabstop=2                     " spaces occupied by a tab
set softtabstop=2                 " number of spaces that a <Tab> counts for while
                                  " performing editing operations
set expandtab                     " use the appropriate number of spaces to insert
                                  " a <Tab>
set incsearch                     " show search matches as you type
set hlsearch                      " highlight search items
set ignorecase                    " ignore case when searching
set smartcase                     " case sensitive if search contains uppercase
set scrolloff=3                   " keep 3 lines off the edges of the screen when scrolling
set numberwidth=4                 " number column width
set cursorline                    " highlight the current line, for quick orientation
set wildmenu                      " make tab completion for files/buffers act like bash
set mouse=a                       " mouse support in all modes
set mousehide                     " hide the mouse when typing
set nobackup                      " do not keep backup files
set nowritebackup
set noswapfile                    " do not write annoying intermediate swap files
set title                         " change the terminal's title
set pastetoggle=<F2>              " key to paste mode
set visualbell                    " do not beep
set laststatus=2                  " always display the statusline
set history=1000                  " remember more commands and search history
set undolevels=1000               " use many muchos levels of undo
set completeopt=menu
set backspace=2
set wildignore=*.o,*.obj,.git,*.jar,*.class
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.class
set fileencodings=ucs-bom,utf-8,default,latin1

" more words!
set dictionary=/usr/share/dict/words
set vb t_vb=

" ---------------------------------------------------------------------------
" Color Theme

" put on solarized theme
" :so $MYVIMRC will change theme with this background, why?
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

" set cursor line color
hi CursorLine cterm=none ctermbg=none ctermfg=blue
" set menu color
hi Pmenu ctermbg=255 ctermfg=33 gui=bold
" set sign column color
hi SignColumn ctermbg=NONE ctermfg=NONE
" symbols to be used as list chars
set listchars=tab:▸▸,trail:<,extends:>,precedes:<,nbsp:%

" ---------------------------------------------------------------------------
" Shortcuts Keys

" use ; instead of : to eliminate multiple keys being pressed
map ; :
map <space> <c-f>
" easily move between window
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" this makes the mouse paste a block of text without formatting it
" (good for code)
map <MouseMiddle> <esc>"*p

" open/close all folds
nmap <LocalLeader>fo :%foldopen!<cr>
nmap <LocalLeader>fc :%foldclose!<cr>
nmap <LocalLeader>ff :QuickFixClear<cr>
nmap <LocalLeader>ss :SignClearAll<cr>
nmap <Tab> :bn<CR>
nmap <LocalLeader>iv :set list!<CR>

nnoremap <silent> <LocalLeader>sf :CommandT<cr>
nnoremap <silent> <LocalLeader>E :e! ~/.vimrc<cr>
nnoremap <LocalLeader>g :Ack <C-R><C-W><cr>
nnoremap <LocalLeader>vh :help <C-R><C-W><cr>

vnoremap <LocalLeader>y "+y<cr>
inoremap <LocalLeader>, <C-X><C-U>

" ---------------------------------------------------------------------------
" Autocmds

" auto remove all trailing white spaces
if has("autocmd")
  autocmd BufWritePre * :%s/\s\+$//e
endif

" auto source vimrc file after saving it
" if has("autocmd")
"   autocmd BufWritePost $MYVIMRC source $MYVIMRC
" endif


" ---------------------------------------------------------------------------
" Plugins Settings

" NERDTree Settings
nmap <LocalLeader>nn :NERDTreeToggle<cr>
let NERDChristmasTree=1
let NERDTreeWinSize=33
let NERDTreeMinimalUI=0         " toggle off helper

" Tagbar Settings
nmap <LocalLeader>tt :TagbarToggle<cr>
let g:tagbar_compact=1
let g:tagbar_width=33

" AutoCompPop Settings
inoremap <expr> <cr>       pumvisible() ? "\<c-y>" : "\<cr>"

" MRU Settings
map <LocalLeader>r :MRU<cr>

" Powerline Settings
set t_Co=256
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set encoding=utf-8

" RainBow settings
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Dash Settings
nmap <silent> <LocalLeader>d <Plug>DashSearch

" Eclim Settings
nnoremap <silent> <LocalLeader>h :JavaHierarchy<cr>
nnoremap <silent> <LocalLeader>v :Validate<cr>
nnoremap <silent> <LocalLeader>c :JavaCorrect<cr>
nnoremap <silent> <LocalLeader>s :ScalaSearch<cr>
nnoremap <silent> <LocalLeader>j :JavaSearchContext<cr>
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
nnoremap <silent> <LocalLeader>si :ScalaImport<cr>
nnoremap <silent> <LocalLeader>mg :JavaGetSet<cr>

" Conque Settings : not installed
map <silent> <LocalLeader>vs :call conque_term#open('bash', ['belowright split', 'resize 8'])<cr>
map <silent> <LocalLeader>vv :call conque_term#open('bash', ['belowright vsplit'])<cr>
