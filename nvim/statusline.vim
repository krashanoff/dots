"
" Statusline
"

call plug#begin(g:plug_directory)
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'itchyny/lightline.vim'
call plug#end()

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_y = '0x%B | [%{&fenc=="" ? &enc : &fenc}%{exists("+bomb") && &bomb ? " B":""}]'
let g:airline_section_z = '%2p%% ≡ %l/%L : %c'

" lightline, if I'm using it
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \ },
      \ 'component_function': {
      \   'mode': 'Mode',
      \ },
      \ }

function! Mode()
    return &filetype ==# 'TelescopePrompt' ? 'TEL' :
        \ lightline#mode()
endfunction

if exists('g:lightline')
    set noshowmode " mode is already shown by lightline.
else
    set showmode
end
