" Include neobundle configuration.
execute 'source ~/.vim/.vimrc-neobundle'

" Default private variables
let g:private_vdebug_server=''
let g:private_vdebug_path_maps={}

" Include private vim configuration if it exists.
let s:vimrc_private='/home/' . $USER . '/.vim/.vimrc-private'
if filereadable(s:vimrc_private)
  execute 'source ' . s:vimrc_private
endif

"
" Syntastic
" =========
let g:syntastic_check_on_open=1

"
" NERDTree
" ========
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd vimenter * if !argc() | NERDTree | endif

"
" Fugitive
" ========
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"
" Vdebug
" ======
let g:vdebug_options= {
\  'port' : 9000,
\  'server' : g:private_vdebug_server,
\  'timeout' : 60,
\  'on_close' : 'detach',
\  'break_on_open' : 0,
\  'ide_key' : '',
\  'path_maps' : g:private_vdebug_path_maps,
\  'debug_window_level' : 0,
\  'debug_file_level' : 0,
\  'debug_file' : '',
\  'watch_window_style' : 'compact',
\  'marker_default' : '⬦',
\  'marker_closed_tree' : '▸',
\  'marker_open_tree' : '▾',
\  'continuous_mode' : 1,
\}
let g:vdebug_features= {
\  'max_depth' : 6,
\  'max_children' : 128,
\}

"
" Tagbar
" ======
autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd BufEnter * nested :call tagbar#autoopen(0)
let g:tagbar_compact = 1
let g:tagbar_type_php = {
\  'ctagstype': 'php',
\  'kinds': [
\    'i:interfaces',
\    'c:classes',
\    'd:constant definitions',
\    'f:functions',
\    'j:javascript functions:1'
\  ]
\}

" 
" neocomplcache 
" =============
let g:neocomplcache_enable_at_startup=1

" key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"
" neosnippet
" ==========
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" 
" vim-signify
" ===========
let g:signify_vcs_list = ['git']

"
" Functions 'n Stuff
" ==================

" Function to sync with test server
" Utilize this function in .vimrc-private.
function! RsyncTestServer(host, ldir, rdir, exclude)
  let host=a:host
  let ldir=a:ldir
  let rdir=a:rdir
  let exclude=a:exclude
  execute "!rsync -crlv --delete --exclude-from=" . exclude . " " . ldir . " " . host . ":" . rdir
endfunction

" Function to strip trailing whitespace on write
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
augroup StripTrailingWhitespaces
  au! FileType c,cpp,java,php,ruby,python,javascript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

" DiffOrig command
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
endif

" Automatically reload vimrc.
augroup reloadVIMRC
  autocmd! BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" 
" Everything else
" ===============
syntax on
filetype plugin indent on
colorscheme molokai
:nnoremap <C-b> :bnext<CR>
:inoremap {<CR> {<CR>}<C-o>O
set mouse=a
set nowrap
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set guioptions-=T
set number
set wildignore+=*.swp,*.swo,*.un~
set shell=bash

