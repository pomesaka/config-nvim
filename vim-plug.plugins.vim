"install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
call plug#end()


" ===== vim-airline =====
" theme
" See https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme = 'luna'
" show tab line
let g:airline#extensions#tabline#enabled = 1
" use Powerline Fonts
let g:airline_powerline_fonts = 1


" ===== telescope =====
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ===== fern =====
nnoremap <C-e> :Fern . -reveal=% -drawer -toggle -width=30<CR>
vnoremap <C-e> :Fern . -reveal=% -drawer -toggle -width=30<CR>
lnoremap <C-e> :Fern . -reveal=% -drawer -toggle -width=30<CR>

function! s:init_fern() abort
	setlocal nonumber
endfunction

augroup fern-custom
	autocmd! *
	autocmd FileType fern call s:init_fern()
augroup END

let g:fern#renderer = "nerdfont"

" ===== emment-vim
" https://github.com/mattn/emmet-vim/blob/1f5daf6810d205844c039a4c9efa89317e62259d/doc/emmet.txt
let g:user_emmet_settings = {
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}
