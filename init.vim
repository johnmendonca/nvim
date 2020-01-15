syntax on
filetype plugin indent on

set nocompatible
set number
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set background=dark
set laststatus=0
set encoding=utf-8

colo darkblue
hi Keyword ctermfg=darkcyan
hi Constant ctermfg=5*
hi Comment ctermfg=2*
hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey

"Disable highlighted matching parens
let g:loaded_matchparen=1

inoremap <M-o> <Esc>o
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

autocmd BufEnter *.html :setlocal filetype=eruby
autocmd BufEnter *.vue  :setlocal filetype=html

execute pathogen#infect()

"Open NERDTree when nvim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

"Exclude gitignore items from CtrlP search
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Use Grepper
nnoremap <leader>ga :Grepper<cr>
nnoremap <leader>gb :Grepper -buffer<cr>

"Hack for neovim and vim-tmux-navigator
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

"haskell-vim settings
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

let g:intero_backend = { 'command': 'stack ghci' }

" Automatically reload on save
au BufWritePost *.hs InteroReload
" Automatically load opened file
au BufWinEnter *.hs call InteroStartAndLoadFile()

" Wait a bit to load a file if plugin has not started
function! InteroStartAndLoadFile()
  if g:intero_started
    :InteroLoadCurrentFile
  else
    ":InteroStart "this happens automatically when file opened
    call timer_start(1000, { tid -> execute('InteroLoadCurrentFile')})
  endif
endfunction

" Lookup the type of expression under the cursor
au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
" Insert type declaration
au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
" Show info about expression or type under the cursor
au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

" Open/Close the Intero terminal window
au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

" Reload the current file into REPL
au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
" Jump to the definition of an identifier
au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
" Evaluate an expression in REPL
au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

" Start/Stop Intero
au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

" Reboot Intero, for when dependencies are added
au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>

" Managing targets
" Prompts you to enter targets (no silent):
au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>

" Run the spec in the current file 
au FileType haskell nnoremap <silent> <leader>nb :InteroSend hspec spec<CR>

" Ctrl-{hjkl} for navigating out of terminal panes
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_haskell_enabled_makers = []

au FileType haskell nnoremap <silent> <leader>ims :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>imm :HsimportModule<CR>

let g:hindent_on_save = 0
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

let g:stylishask_on_save = 0
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

" Supertab
"let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let b:SuperTabDisabled = 1

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>< :Tabularize /<-<CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>
nnoremap <leader>: :Tabularize /::<CR>
nnoremap <leader>[ :Tabularize /[<CR>

" Replace all instances of word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

au FileType purescript nm <buffer> <silent> <leader>L :Plist<CR>
au FileType purescript nm <buffer> <silent> <leader>l :Pload!<CR>
au FileType purescript nm <buffer> <silent> <leader>r :Prebuild!<CR>
au FileType purescript nm <buffer> <silent> <leader>f :PaddClause<CR>
au FileType purescript nm <buffer> <silent> <leader>mt :PaddType<CR>
au FileType purescript nm <buffer> <silent> <leader>a :Papply<CR>
au FileType purescript nm <buffer> <silent> <leader>A :Papply!<CR>
au FileType purescript nm <buffer> <silent> <leader>C :Pcase!<CR>
au FileType purescript nm <buffer> <silent> <leader>i :Pimport<CR>
au FileType purescript nm <buffer> <silent> <leader>qa :PaddImportQualifications<CR>
au FileType purescript nm <buffer> <silent> <leader>g :Pgoto<CR>
au FileType purescript nm <buffer> <silent> <leader>p :Pursuit<CR>
au FileType purescript nm <buffer> <silent> <leader>t :Ptype<CR>

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

let g:ragtag_global_maps = 1
let g:user_emmet_leader_key='<C-F>'

