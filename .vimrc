set nocompatible               " be iMproved
 filetype off                   " required!

 execute pathogen#infect()
 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 Bundle 'gmarik/vundle'
 Bundle 'tpope/vim-surround'
 Bundle 'tpope/vim-endwise'
 Bundle 'tsaleh/vim-supertab'
 Bundle 'wincent/Command-T'
 Bundle 'mileszs/ack.vim'

 Bundle 'vim-ruby/vim-ruby'
 Bundle 'tpope/vim-rails'
 Bundle 'tpope/vim-haml'
 Bundle 'pangloss/vim-javascript'
 Bundle 'vim-coffee-script'
 Bundle 'https://github.com/scrooloose/nerdtree.git'
 "solorized
 Bundle 'git://github.com/altercation/vim-colors-solarized.git'
 Bundle 'https://github.com/shemerey/vim-peepopen.git'


 syntax enable
 colorscheme solarized
 set background=dark
 set guifont=Monaco:h15
 

 filetype plugin indent on     " required!

 set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
 set nu ruler
 set shellpipe=>

 function! MarkWindowSwap()
   let g:markedWinNum = winnr()
 endfunction

 function! DoWindowSwap()
       "Mark destination
       let curNum = winnr()
       let curBuf = bufnr( "%" )
       exe g:markedWinNum . "wincmd w"
       "Switch to source and shuffle dest->source
       let markedBuf = bufnr( "%" )
       "Hide and open so that we aren't prompted and
       keep history
       exe 'hide buf' curBuf
       "Switch to dest and shuffle
       source->dest
       exe curNum . "wincmd w"
       "Hide and open so that we
       aren't prompted and keep
       history
       exe 'hide buf' markedbuf
 endfunction

 nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
 nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" map jj to Esc
 map! jj <Esc> 

"Command-T call
 nmap <leader>t :CommandT<CR>

"tab commands
 noremap <Space>t :tabnew<CR>
 noremap <S-h> :tabp<CR>
 noremap <S-l> :tabn<CR>


 "Move current tab into the specified direction.
 "
 " @param direction -1 for left, 1 for right.
 function! TabMove(direction)
   " get number of tab pages.
   let ntp=tabpagenr("$")
   " move tab, if necessary.
   if ntp > 1
     " get number of current tab page.
     let ctpn=tabpagenr()
     " move left.
     if a:direction < 0
       let index=((ctpn-1+ntp-1)%ntp)
     else
       let index=(ctpn%ntp)
     endif

     " move tab page.
     execute "tabmove ".index
   endif
 endfunction

 map <Space>h :call TabMove(-1)<CR>
 map <Space>l :call TabMove(1)<CR>

 ":nnoremap gr :Ack '\b<cword>\b' *<CR>
 ":nnoremap gR :Ack <cword> *<CR>

 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "" => vimgrep searching and cope displaying
 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "" When you press gr you vimgrep after the selected text
 "vnoremap <silent> gr :call VisualSelection('gr')<CR>
 "

 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "" => Helper functions
 "" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "function! CmdLine(str)
 "     exe "menu Foo.Bar :" . a:str
 "     emenu Foo.Bar
 "     unmenu Foo
 "endfunction
 "
 "function! VisualSelection(direction) range
 "     let l:saved_reg = @"
 "     execute "normal! vgvy"
 "
 "     let l:pattern = escape(@", '\\/.*$^~[]')
 "     let l:pattern = substitute(l:pattern, "\n$","", "")

 "     if a:direction == 'b'
 "       execute "normal ?" . l:pattern . "^M"
 "     elseif a:direction == 'gr'
 "       execute "Ack " l:pattern
 "     elseif a:direction == 'replace'
 "       call CmdLine("%s" . '/'. l:pattern . '/')
 "     elseif a:direction == 'f'
 "       execute "normal /" . l:pattern . "^M"
 "     endif

 "     let @/ = l:pattern
 "     let @" = l:saved_reg
 "endfunction
