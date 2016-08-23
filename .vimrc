" TODO before this config file works:
" 0. $ mkdir ~/.vimbackups
"    # On Windows: $ mkdir <homedir>/vimfiles
" 1. On Linux: install the Inconsolata font.
" 2. Install Vundle:
"    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"    # Start Vim and run :PluginInstall

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set cpoptions=

" Don't use the viminfo file.
set viminfo=

" Put backups in a specific directory.
set backupdir=~/.vimbackups
set directory=~/.vimbackups
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'

" DISABLED: Disable backups and swap files altogether.
" set nobackup
" set nowritebackup
" set noswapfile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Clipboard.
set clipboard^=unnamed,unnamedplus " Set the OS clipboard to the unnamed register for copy/paste .
set guioptions+=a " Visual highlighting automatically copies to clipboard.

" autochdir: set cwd to whatever the current buffer is.
" NOTE: This breaks some plugins (haven't found any in practice).
set autochdir

" Autoindent.
set autoindent

" Searching.
set incsearch " do incremental searching
set ignorecase " make it case insensitive...
set smartcase " but only if it contains no uppercase letters
set wrapscan " and let it wrap around
set scrolloff=5 " show 5 lines around found searches, to give it some context

" Tabbing.
set shiftwidth=4 " tab is 4 spaces
set tabstop=4 " tab is 4 spaces
set expandtab " hitting tab produces spaces
set smarttab " tab the shiftwidth

" DISABLED: Map tab to >>.
" Unfortunately, in Vim, tab is the same as Ctrl-I and one cannot be remapped
" without the other. Ctrl-I moves forward in the jumplist.
" nnoremap <Tab> >>_
" Map shift-tab to << and (capital) Q to >>.
nnoremap <S-Tab> <<
nnoremap Q >>
" In insert mode, shift-tab to reverse tab (tab already behaves correctly).
inoremap <S-Tab> <C-d>
" In visual mode, make it so that shifting does not lose the selection.
vnoremap > >gv
vnoremap < <gv

" Setup commandline.
set history=10000 " keep 10000 lines of command line history
set showcmd " display incomplete commands

" Set text width.
set textwidth=80 " text width is 80 columns
set wrap " wrap text that's longer than 80 columns
set linebreak " when wrapping, break lines at word boundaries

" Hide buffers instead of abandoning them.
set hidden

" Highlight the current line.
set cursorline

" Make tab behave like bash when opening files
set wildmode=longest,list
set wildmenu
set wildignorecase " Make 'e' case insensitive

" Show line numbers.
set number

" Show the cursor position all the time at the bottom.
set ruler

" If the terminal has more than 2 colors, or when the GUI is running.
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=light
  if has("win32")
      set guifont=Consolas:h10:cANSI
  elseif has("gui_gtk2")
      set guifont=Inconsolata\ Medium\ 11
  endif
endif

" Add UTF-8 support.
if has("multi_byte")

  " 'termencoding' defines how your keyboard encodes what you type.  Here we
  " save the value corresponding to your locale before changing 'encoding'.
  if &termencoding == ""
    let &termencoding = &encoding
  endif

  " Internally use UTF-8
  set encoding=utf-8

  " 'fileencoding' is local to a buffer.  Set it globally.
  setglobal fileencoding=utf-8

  " Don't use 'bomb': we don't need a byte-order-mark (BOM) with UTF-8
  " The nice thing about 'bomb' is that when Vim reads a file, and the file has a BOM already included, Vim will automatically set 'bomb' local to the buffer so that it is written out again. So as a general rule, it is probably best to set 'bomb' local to the buffer, only on the files where it is considered useful.
  " setglobal bomb

  " 'fileencodings' defines the heuristic to set 'fileencoding' (local to buffer) when reading an existing file. The first one that matches will be used. Ucs-bom is "ucs with byte-order-mark"; it must not come after utf-8 if you want it to be used.
  set fileencodings=ucs-bom,utf-8,latin1

endif

" completion behavior
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Vundle
if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
endif

" Let Vundle manage Vundle, required.
Plugin 'gmarik/vundle'

" Solarized
Plugin 'altercation/vim-colors-solarized'

" CtrlP.
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
" search both files and buffers
let g:ctrlp_cmd = 'CtrlPMixed'
" when a starting directory isn't specified
" set internal local working directory to
" r: the nearest ancestor that contains one of
" .git, .hg, .svn, etc
" a: use directory of current file when
" cwd outside of CtrlP isn't a direct ancestor
" of the dir of the current file
" https://github.com/kien/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'

" NERDTree.
Plugin 'scrooloose/nerdtree'
" toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

" MiniBufExpl.
Plugin 'techlivezheng/vim-plugin-minibufexpl'
let g:miniBufExplVSplit = 20 " vertical splits
let g:miniBufExplBRSplit = 1 " on right
let g:miniBufExplUseSingleClick = 1 " single click to select
let g:miniBufExplCycleArround = 1 " loop around
" <C-TAB> and <C-S-TAB> cycles through buffers in MRU fashion
noremap <C-TAB>   :MBEbf<CR>
noremap <C-S-TAB> :MBEbb<CR>

" bclose: close a buffer without closing its window.
Plugin 'rbgrouleff/bclose.vim'

" OmniCppComplete.
Plugin 'https://github.com/vim-scripts/OmniCppComplete'
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window

" SuperTab.
Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Python indent.
Plugin 'vim-scripts/python.vim'

" Python syntax.
Plugin 'vim-scripts/python.vim--Vasiliev'

" IPython interop.
Plugin 'ivanov/vim-ipython'

" Command aliases.
" So I can remap bc --> BClose
Plugin 'vim-scripts/cmdalias.vim'

call vundle#end()

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " command aliases
  augroup CmdAlias
    autocmd!

    " bc --> Bclose
    " bd --> Bclose
    autocmd VimEnter * Alias bc Bclose
    autocmd VimEnter * Alias bd Bclose
  augroup END " CmdAlias

  " Automatically maintain window proportions.
  autocmd VimResized * wincmd =

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Strip trailing whitespace on given file types
  autocmd FileType c,h,cpp,cc,hpp,java,htm,html,py,sh
    \ autocmd BufWritePre <buffer> StripWhitespace

  " NERDTree
  " Open NERDTree automatically when vim starts up.
  " autocmd vimenter * NERDTree

  " Open NERDTree automatically when vim starts up with no args.
  autocmd vimenter * if !argc() | NERDTree | endif

endif " has("autocmd")

" This has to come after the Vundle block.
colorscheme solarized

" Load anything machine-specific.
if filereadable('~/.vimrc_local')
  source ~/.vimrc_local
endif
