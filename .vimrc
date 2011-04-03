syntax on

set vb
set smarttab
set tabstop=4
set smartindent
set expandtab
" Python
let python_highlight_all=1
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 fileformats=unix smarttab textwidth=80 smartindent
autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 fileformats=unix smartindent smarttab textwidth=80
" Perl
let perl_include_pod = 1
let perl_extended_vars = 1

" Menu and alike
set wildmenu
set ruler
set guioptions-=T
set laststatus=2

"set cursorline
"set completeopt-=preview
" Show those stupid trailing whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
