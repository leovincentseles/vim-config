" *********** General settings ***********
set nocompatible		" not compatible with vi
syntax on				" highlight code
set autoindent			" auto indent
set number				" turn on line number
set bg=dark				" highlight for dark background color
set backspace=2			" backspace can delete
set tabstop=4			" tab is appeared 4 characters width 
set shiftwidth=4		" for Ultisnips tab 
set hlsearch			" highlight search text
set incsearch			" search when text changed
set ignorecase			" search case insensitive
set smartcase			" upper letter search case sensitive
set showcmd				" show current command buffer
set wildmenu			" show the wild menu
set autoread			" file changed outside autoread it
set backupdir=~/tmp,.	" Where to write backup file
set backupext=.bak		" backup file extension
set backup				" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
" auto close quickfix window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" If no screen, use color term
if ($TERM == "vt100")
    " xterm-color / screen
    set t_Co=256
    set t_AF=[1;3%p1%dm
    set t_AB=[4%p1%dm
endif

if version >= 600		" VIM 6.0,
    set foldmethod=marker
    set foldlevel=1
    set fileencodings=ucs-bom,utf-8,sjis,big5,latin1
else
    set fileencoding=taiwan
endif

" key Mapping
if version >= 700
	map <F1> :NERDTreeToggle<CR>
    map <F4> :set invcursorline<CR>
	nnoremap <C-j> :bp<CR>
	nnoremap <C-l> :bn<CR>
	nnoremap <C-d> :bp\|bd #<CR>
end

nmap <F10> :set relativenumber<CR>
nmap <F11> :set norelativenumber<CR>
nnoremap <F3> :noh<CR>

" *********** ctags setting **************
set tags=tags;
set autochdir
nmap <C-o> <C-]>
nmap <C-p> g]

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
		silent !ctags --fields=+l -R *
    endif
    execute ":cd " . curdir
endfunction

" autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags()

" *********** Vim Plugin *****************
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
 
Plugin 'gmarik/vundle'					" Plugin manager
Plugin 'vim-airline/vim-airline'		" airline status bar
Plugin 'vim-airline/vim-airline-themes' " airline themes
Plugin 'tpope/vim-fugitive'				" detect git branch
Plugin 'Valloric/YouCompleteMe'			" autocomplete
Plugin 'scrooloose/nerdtree'			" Nerd Tree
Plugin 'ludovicchabant/vim-gutentags'	" ctags gtags manager
Plugin 'skywind3000/gutentags_plus'		" handle switch between cscope databases
" Plugin 'wesleyche/SrcExpl'				" Source Preview
 
call vundle#end()
filetype plugin indent on

" *********** Vim airline ****************
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='light'
set laststatus=2
let g:airline_left_sep = ''
let g:airline_right_sep = '|'
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '*'
let g:airline_skip_empty_sections=1
let g:airline_detect_whitespace=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#format = 0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_section_c='%t'

" ************ YouCompleteMe **************
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_invoke_completion = ''
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_cache_omnifunc = 0
let g:syntastic_c_checkers=['make']
let g:syntastic_always_populate_loc_list = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
set completeopt-=preview

" ************ gutentags ************ 
" Porject root directory marker
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" Generate tag file name
let g:gutentags_ctags_tagfile = '.tags'

" Gtags advanced command
let g:gutentags_define_advanced_commands = 1

" add ctags and gtags support
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" ctags option
let g:gutentags_cache_dir = expand('~/.cache/tags')	" tags directory
let g:gutentags_ctags_extra_args = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" ************ gutentags_plus ************ 
" gutentags_plus has defined some key map to use gtags-cscope
let g:gutentags_plus_switch = 1

" ************ memo **********************
" <leader> is mapped to '/'
