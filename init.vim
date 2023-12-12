"show number
set number

set langmenu=en_US.UTF-8
language en_US.UTF-8


" not show unsaved message
set hidden

" fold text using syntax
" set foldmethod=manual
" disable folding
set nofoldenable

"auto indent
set autoindent

" auto indent if `{` type
set smartindent
" set cindent

"use blank instead of tab
set expandtab

"tab = N spaces
set tabstop=4

"added space by auto indent ( if 0, follow tabstop )
set shiftwidth=0

"add new pain to right
set splitright

"use clipboard for yank
set clipboard=unnamed

"highligh searching words
set hls

" enhance cursor position
set cursorline
set cursorcolumn

" undo if file has been closed
if has('presistnt_undo')
	set undodir=~/.nvim/undo
	set undofile
endif

"switch ';' and ':' in normal mode
"nnoremap ; :
"nnoremap : ;
"vnoremap : :
"vnoremap : ;

"mapleader(<Leader>) = <Space>
let mapleader="\<Space>"

" pain
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" buffer
nnoremap <silent> zh :bprev<CR>
nnoremap <silent> zl :bnext<CR>
nnoremap <silent> zH :bfirst<CR>
nnoremap <silent> zL :blast<CR>
nnoremap <silent> zw :bdelete<CR>

" tab
nnoremap th gt
nnoremap tl gT
nnoremap <silent> tn :<C-u>tabnew<CR>

" move cursor in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" surround autocompletion
inoremap {<Enter> {<Enter>}<Esc><S-o>
inoremap [<Enter> [<Enter>]<Esc><S-o>
inoremap (<Enter> (<Enter>)<Esc><S-o>
inoremap {<Space> {}<Left>
inoremap [<Space> []<Left>
inoremap (<Space> ()<Left>
inoremap <<Space> <><Left>
inoremap "<Space> ""<Left>
inoremap '<Space> ''<Left>

" for goimports
function! s:exec_goimports()
  set cmdheight=3
  exe ":!goimports -w %"
  exe ":e!"
  set cmdheight=1
endfunction

augroup autoStyle
  autocmd!
  " remove tab/space or other space like charactor
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd bufWritePost *.go call s:exec_goimports()
  autocmd bufWritePre *.ts,*.tsx lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd bufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.ts,*.tsx setlocal tabstop=2
	autocmd BufNewFile,BufRead *.dart setlocal tabstop=2
augroup End

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" ===== vim-plug =====
source $HOME/.config/nvim/vim-plug.plugins.vim

" ===== custom highlight
highlight Visual     cterm=reverse
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21


" ===== lsp settings by lua script ======
" source $HOME/.config/nvim/lua/init.lua
lua require("init")

nnoremap <silent> <C-q> <cmd>lua require('lspsaga.floaterm').open_float_terminal("/bin/zsh")<CR>
tnoremap <silent> <C-q> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

" ===== theme =====
colorscheme onenord
