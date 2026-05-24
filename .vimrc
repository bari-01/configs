let mapleader="\\"
let maplocalleader=","

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
"Plug 'gergap/vim-ollama'
Plug 'lervag/vimtex'
Plug 'slint-ui/vim-slint'
Plug 'wellle/context.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'dedzago/latex-img-paste.vim'
Plug 'cpiger/vim-qt'

"Plug 'github/copilot.vim'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"Plug 'vim-airline/vim-airline'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"
" vimtex
"
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"" Or with a generic interface:
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_syntax_conceal = {
\ 'spacing': 0,
\}
let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_compiler_tectonic = {
        \ 'out_dir' : '',
        \ 'hooks' : [],
        \ 'options' : [
        \   '--keep-logs',
        \   '--synctex',
        \   '-Z shell-escape',
        \ ],
        \}
nnoremap <localleader>lc :w<cr>:VimtexCompileSS<cr>
nnoremap <localleader>lv :VimtexView<cr>
"autocmd FileType tex,latex nnoremap <silent> <leader>p :call mdip#LatexClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
"let g:mdip_imgname = 'images'
"
function! PasteImage()
    " Check if clipboard has an image
    let l:types = system('wl-paste --list-types')
    if l:types =~ 'image/png'
        " Generate file path
        let l:file = 'img/img_' . strftime('%s') . '.png'
        " Save clipboard image
        call system("wl-paste -t image/png > " . shellescape(l:file))
        " Insert LaTeX code
        execute "normal! o\\begin{figure}"
        execute "normal! o  \\centering"
        execute "normal! o  \\includegraphics[width=0.8\\linewidth]{" . l:file . "}"
        execute "normal! o  \\caption{}"
        execute "normal! o  \\label{fig:}"
        execute "normal! o\\end{figure}"
    else
        echo "No image in clipboard"
    endif
endfunction

nnoremap <leader>p :call PasteImage()<CR>

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<f2>'
let g:UltiSnipsJumpForwardTrigger = '<f2>'
let g:UltiSnipsJumpBackwardTrigger = '<f3>'
Plug 'honza/vim-snippets'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_language_server = [
    \ {
    \   'name': 'rust',
    \   'filetypes': ['rust'],
    \   'cmdline': ['rust-analyzer'],
    \   'project_root_files': ['Cargo.toml', '.git'],
    \   'initialization_options': {
    \       'cargo': {'buildScripts': {'enable': v:true}},
    \       'procMacro': {'enable': v:true}
    \   },
    \   'env': {'RUST_BACKTRACE': '1'},
    \ },
    \ {
    \   'name': 'slint',
    \   'filetypes': ['slint'],
    \   'cmdline': ['slint-lsp'],
    \   'project_root_files': ['.git'],
    \   'initialization_options': {},
    \ },
    \ {
    \   'name': 'texlab',
    \   'filetypes': ['tex', 'bib'],
    \   'cmdline': ['texlab'],
    \   'project_root_files': ['main.tex', '.git'],
    \   'initialization_options': {},
    \ }
\ ]

"if executable('rust-analyzer')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'rust-analyzer',
"        \ 'cmd': {server_info -> ['rust-analyzer']},
"        \ 'allowlist': ['rust'],
"        \ })
"endif
"
"function! s:on_lsp_buffer_enabled() abort
"    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"    nmap <buffer> gd <plug>(lsp-definition)
"    nmap <buffer> gs <plug>(lsp-document-symbol-search)
"    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"    nmap <buffer> gr <plug>(lsp-references)
"    nmap <buffer> gi <plug>(lsp-implementation)
"    nmap <buffer> gt <plug>(lsp-type-definition)
"    nmap <buffer> <leader>rn <plug>(lsp-rename)
"    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"    nmap <buffer> K <plug>(lsp-hover)
"    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
"    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
"
"    let g:lsp_format_sync_timeout = 1000
"    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
"
"    " refer to doc to add more commands
"endfunction
"
"augroup lsp_install
"    au!
"    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END
"
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"
"" allow modifying the completeopt variable, or it will
"" be overridden all the time
"let g:asyncomplete_auto_completeopt = 0
"
"set completeopt=menuone,noinsert,noselect,preview
"
"autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"let g:lightline = {'colorscheme': 'catppuccin_frappe'}
"let g:airline_theme = 'catppuccin_mocha'
syntax enable
se termguicolors
set shell=/bin/zsh
colorscheme catppuccin_mocha

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set encoding=utf8
se cinoptions=l1
set completeopt=menu,menuone,noselect

set number
set cursorline
set mouse=a
filetype indent on
set wildmenu
set wildoptions=pum,fuzzy
set wildmode=longest:full,full
set wildignorecase
set lazyredraw
set showmatch
set ignorecase
set smartcase
set hlsearch
set nomodeline
set colorcolumn=80

set incsearch
set foldenable
set foldlevelstart=10
nnoremap <space> za
set foldmethod=syntax

nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap s $i<CR><ESC>

nnoremap <leader>t :tabnew<CR>
nnoremap <leader>Left :tabp<CR>
nnoremap <leader>Right :tabN<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>ju :YcmCompleter GoToCallers<CR>
nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
nmap <leader>jf <Plug>(YCMFindSymbolInWorkspace)
nnoremap <Leader>jk :lprevious<CR>zz
nnoremap <Leader>jj :lnext<CR>zz
nnoremap <leader>jt :YcmCompleter GetType<CR>
nnoremap <leader>jo :YcmCompleter GetDoc<CR>
nnoremap <leader>jx :YcmCompleter FixIt<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
  \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
  \   execute 'NERDTree' argv()[0] |
  \   wincmd p |
  \   enew |
  \ else |
  \   NERDTree |
  \   wincmd p |
  \ endif
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
                        \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2

let g:bottom_term_buf = -1

function! ToggleBottomTerminal()
  if bufexists(g:bottom_term_buf)
    if bufwinnr(g:bottom_term_buf) != -1
      execute bufwinnr(g:bottom_term_buf) . 'hide'
      return
    endif

    belowright 12split
    execute 'buffer ' . g:bottom_term_buf
    call feedkeys("i")
    return
  endif

  belowright 8split
  term ++curwin
  let g:bottom_term_buf = bufnr('%')
  "startinsert
endfunction

nnoremap <leader>tt :call ToggleBottomTerminal()<CR>
tnoremap <leader>tt <C-\><C-n>:call ToggleBottomTerminal()<CR>

set backup
set backupdir=~/.vim-tmp
"set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp
set writebackup

set undofile
set undodir=~/.vim-tmp/undo
