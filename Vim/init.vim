" Copyright 2023 Sunny Blake-Webber, All Rights Reserved.


"	MESA-TOOLS AUTO VIM CONFIGURATION


"-----------------------------------------------------------
"	CONFIGURE NVIM DEFAULTS
"-----------------------------------------------------------

" Configure Vim
set number
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4

"-----------------------------------------------------------
"	PLUGIN INSTALLATION
"-----------------------------------------------------------

" Install Plugins
call plug#begin()

	" Theme
	Plug 'rebelot/kanagawa.nvim'

	" Dependencies / Common
	Plug 'nvim-lua/plenary.nvim'

	" Telescope
	Plug 'nvim-telescope/telescope.nvim'

	" Conquer of Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Copilot
	"Plug 'github/copilot.vim'

	" Lightline
	Plug 'itchyny/lightline.vim'

	" Signify
	Plug 'mhinz/vim-signify'

	" Better whitespace
	Plug 'ntpeters/vim-better-whitespace'

call plug#end()

"-----------------------------------------------------------
"	CONQUER OF COMPLETION
"-----------------------------------------------------------

let g:coc_global_extensions = ['coc-clangd', 'coc-rust-analyzer', 'coc-highlight']
let g:coc_disable_startup_warning = 1
" Controls-sorta
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

"-----------------------------------------------------------
"	KEYBINDING
"-----------------------------------------------------------

" Apply Theme
"colorscheme kanagawa-lotus

" VIM Default Keyset Override
noremap <C-h> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-k> <C-w><Left>
noremap <C-l> <C-w><Right>

" Telescope
noremap <S-A-o> :Telescope find_files hidden=true<CR>
noremap <S-A-s> :Telescope live_grep<CR>

"-----------------------------------------------------------
"	TERMINAL FUNCTION
"-----------------------------------------------------------

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
			if has('win32') || has('win64')
				call termopen('powershell.exe', {"detach": 0})
			else
				call termopen($SHELL, {"detach": 0})
			endif
			let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
	endif
endfunction

" Terminal
" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

