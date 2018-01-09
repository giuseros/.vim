" General settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set nocompatible

" Plugins config
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
call vundle#end() 

let g:ycm_filetype_whitelist = {'cpp':1}
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_confirm_extra_conf = 0
 
filetype plugin indent on
function! IsNERDTreeOpen()        
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a
" modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction


function LoadCIDE()
    nnoremap <C-n> :NERDTreeToggle<CR>

    set number
    set foldmethod=syntax
    set foldlevel=20

    nnoremap <C-n> :NERDTreeToggle<CR>
    " Highlight currently open buffer in NERDTree
    NERDTree
    wincmd p
    call SyncTree()
    " Ycm commands
    nnoremap <C-k>i : YcmCompleter GoToInclude<CR>
    nnoremap <C-k>e : YcmCompleter GoToDeclaration<CR>
    nnoremap <C-k>f : YcmCompleter GoToDefinition<CR>
    nnoremap <C-k>t : YcmCompleter GetType<CR>


endfunction

autocmd VimEnter *.cpp,*.h call LoadCIDE()
autocmd BufEnter *.cpp,*.h call SyncTree()
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
