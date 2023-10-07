set number
set mouse=a
syntax enable
set showcmd
set ruler
set showmatch
colorscheme default
set tabstop=8
set softtabstop=4
set shiftwidth=4
set guicursor=

" Restore cursor style when quitting
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
"au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"  \,sm:block-blinkwait175-blinkoff150-blinkon175

au VimLeave,VimSuspend * set guicursor=a:hor20,a:blinkon0
" augroup Shape autocmd! autocmd VimLeave * set guicursor=a:hor20 augroup END

" "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
"   if (has("nvim"))
"     "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"   endif
"   "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"   "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"   " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"   if (has("termguicolors"))
"     set termguicolors
"   endif
" endif


call plug#begin(stdpath('data') . '/plugged')

" nvim gruvbox theme
Plug 'morhetz/gruvbox'
" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" NerdTree
Plug 'https://github.com/preservim/nerdtree'

call plug#end()


" Gruvbox theme adjustment
" let g:gruvbox_bold = '1'
" let g:gruvbox_italic = '1'
" let g:gruvbox_transparent_bg = '1'
" let g:gruvbox_underline = '1'
" let g:gruvbox_undercurl = '1'
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox

autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE

" NERDTree keybindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
