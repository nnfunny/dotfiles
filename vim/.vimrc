"""""""""
" UTILS "
"""""""""

if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system("uname"), "\n", "", "")
  endif
endif

function s:count_directories_in_path(path)
  return len(filter(globpath(a:path, '*', 0, 1), 'isdirectory(v:val)'))
endfunction

"""""""""""
" OPTIONS "
"""""""""""

syntax on

filetype plugin indent on

let mapleader = " "

set autoindent
set autoread
set backspace+=nostop
set breakindent
set clipboard+=unnamedplus,unnamed
set cmdheight=1
set colorcolumn=80
set completeopt=menu,menuone,noselect,noinsert
set copyindent
set cursorline
set expandtab
set fileencoding=utf-8
set foldcolumn=1
set foldenable
set foldlevel=99
set foldlevelstart=99
set foldmethod=manual
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
set history=100
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=2
set linebreak
set nobackup
set noswapfile
set noundofile
set nowrap
set nowritebackup
set number
set omnifunc=syntaxcomplete#Complete
set preserveindent
set pumheight=100
set relativenumber
set scrolloff=8
set shiftround
set shiftwidth=2
set showmode
set showtabline=0
set sidescrolloff=8
set signcolumn=yes
set smartcase
set smartindent
set splitbelow
set splitright
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set tabstop=2
set termguicolors
set timeoutlen=500
set undolevels=10000
set updatetime=50
set viewoptions-=curdir
set virtualedit=block
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum,tagfile
set winminwidth=5

""""""""""""
" MAPPINGS "
""""""""""""

" Move to window
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Resize window
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Yanking
nnoremap <leader>ya :%y+<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap Y y$

" Buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>ba :bufdo bd<CR>
nnoremap <leader>be :%bd\|e#<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

"  Move lines
nnoremap <leader>md :m .+1<CR>==
nnoremap <leader>mu :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clear search with <Esc>
nnoremap <Esc> :noh<CR>

" Keeping it centered and stable
nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Quickfix list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz

" Location list
nnoremap <leader>J :lnext<CR>zz
nnoremap <leader>K :lprev<CR>zz

" Toggle spelling checker
map <F4> :setlocal spell! spelllang=en_us<CR>

" Replace currently selected text with default register without yanking it
xnoremap <leader>p "_dP

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" This is going to get me cancelled
inoremap <C-c> <Esc>

" Replace
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Make file executable
nnoremap <silent> <leader>x :!chmod +x %<CR>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Copy the current file's path
nnoremap yp :exec setreg("+", expand("%:p"))<CR>

" Split explorer
nnoremap - :Ex<CR>

" Switch between C source and header file
nnoremap <F5> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" Fix the indentation of an entire file
nnoremap <leader>F gg=G''

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

autocmd BufWritePre * call s:trim_white_space()
function s:trim_white_space()
  let l:save = winsaveview()
  keepjumps keeppatterns silent! %s/\s\+$//e
  keepjumps keeppatterns silent! %s/\%^\n\+//
  keepjumps keeppatterns silent! %s/\(\n\n\)\n\+/\1/
  keepjumps keeppatterns silent! %s/\($\n\s*\)\+\%$//
  call winrestview(l:save)
endfunction

"""""""""
" THEME "
"""""""""

set background=light
colorscheme quiet

autocmd VimEnter * hi Comment guifg=#8c8c8c

" Transparent Column
autocmd VimEnter * hi SignColumn ctermbg=NONE guibg=NONE
autocmd VimEnter * hi FoldColumn ctermbg=NONE guibg=NONE

" Transparent Background
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
autocmd VimEnter * hi NonText ctermbg=NONE guibg=NONE
autocmd VimEnter * hi NormalNC ctermbg=NONE guibg=NONE
autocmd VimEnter * hi NormalFloat ctermbg=NONE guibg=NONE
autocmd VimEnter * hi EndOfBuffer ctermbg=NONE guibg=NONE

"""""""""""
" PLUGINS "
"""""""""""

" plugin utils

let s:PLUGIN_DIR = "~/.vim/pack/plugins/start"

command PluginClean call system("rm -rf " . s:PLUGIN_DIR) | echo "Removed all plugins"
command PluginCount echo "Plugin count: " . s:count_directories_in_path(s:PLUGIN_DIR)

function s:install_plugin(plugin_source_url, plugin_name)
  let l:plugin_dest_dir = expand(s:PLUGIN_DIR . "/" . a:plugin_name)

  if !isdirectory(l:plugin_dest_dir)
    echo "Installing " . a:plugin_name . "..."
    call system("git clone --depth 1 " . a:plugin_source_url . " " . l:plugin_dest_dir)
    echo "Installed " . a:plugin_name . "!"
    echo " "
  endif
endfunction

" plugins

call s:install_plugin("https://github.com/junegunn/fzf.vim", "fzf.vim")
set runtimepath+=~/.fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>ff :Files<CR>
autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>

call s:install_plugin("https://github.com/tpope/vim-fugitive", "vim-fugitive")

call s:install_plugin("https://github.com/lervag/wiki.vim", "wiki.vim")
let s:wiki_root_path_env = getenv("WIKI_ROOT_PATH")
let g:wiki_root = expand(empty(s:wiki_root_path_env) ? "~/wiki" : s:wiki_root_path_env)
if !isdirectory(g:wiki_root)
  call system("mkdir " . g:wiki_root)
endif
nnoremap <leader>wx <plug>(wiki-pages)
