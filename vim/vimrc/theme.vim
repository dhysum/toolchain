if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has("gui")
  " Setup pathogen
  filetype off
  call pathogen#runtime_append_all_bundles()
endif

set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

func! FuncColorElflord()
	colorscheme elflord
endfunc

"func! FuncColorDarkblue()
"colorscheme darkblue
"endfunc

func! FuncColorKoehler()
	colorscheme koehler
endfunc

func! FuncColorMurphy()
	colorscheme murphy
endfunc

func! FuncColorTorte()
	colorscheme torte
endfunc

"colorscheme darkblue

" Chinese support
set fileencoding=utf-8
set termencoding=utf-8

"hl-CursorLine guibg=blue guifg=red 
"set cursor
set cursorline 
set cursorcolumn
hi CursorLine term=bold cterm=bold guibg=grey40 
hi CursorColumn term=bold cterm=bold guibg=grey40 ctermbg=black ctermfg=white


