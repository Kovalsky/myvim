 set nocompatible               " be iMproved
 filetype off                   " required!
 set rtp+=~/.vim/bundle/Vundle.vim
 set rtp+=/usr/local/opt/fzf
 call vundle#begin()

 Plugin 'gmarik/vundle'
 Plugin 'junegunn/fzf.vim'
 Plugin 'wincent/ferret'
 Plugin 'tpope/vim-surround'
 Plugin 'tpope/vim-endwise'
 Plugin 'ervandew/supertab'
 Plugin 'wincent/Command-T'
 Plugin 'mileszs/ack.vim'
 Plugin 'https://github.com/ReekenX/vim-rename2'
 Plugin 'tpope/vim-obsession'
 Plugin 'terryma/vim-multiple-cursors'
 Plugin 'bronson/vim-trailing-whitespace'
 Plugin 'victorfeijo/binding-pry-vim'
 Plugin 'tonekk/vim-binding-pry'
 Plugin 'sheerun/vim-polyglot'
 Plugin 'w0rp/ale'
 Plugin 'yggdroot/indentline'

 Plugin 'vim-ruby/vim-ruby'
 Plugin 'tpope/vim-rails'
 Plugin 'tpope/vim-haml'
 Plugin 'https://github.com/digitaltoad/vim-pug'
 Plugin 'slim-template/vim-slim.git'
 Plugin 'pangloss/vim-javascript'
 Plugin 'vim-coffee-script'
 Plugin 'https://github.com/scrooloose/nerdtree.git'
 "themes
 Plugin 'git://github.com/altercation/vim-colors-solarized.git'
 Plugin 'liuchengxu/space-vim-theme'

 Plugin 'https://github.com/rakr/vim-one'
 Plugin 'https://github.com/shemerey/vim-peepopen.git'
 Plugin 'tpope/vim-fugitive'
 Plugin 'tpope/vim-rhubarb'
 Plugin 'shumphrey/fugitive-gitlab.vim'
 Plugin 'tpope/vim-bundler'
 Plugin 'christoomey/vim-tmux-navigator'
 Plugin 'vim-scripts/Conque-Shell'
 Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
 Plugin 'thoughtbot/vim-rspec'

 call vundle#end()
 if 0 | endif



 filetype plugin indent on



 syntax enable
 set t_Co=16
 "let g:solarized_termcolors=256
 "colorscheme solarized
 "set background=dark
 "colorscheme space_vim_theme
 colorscheme one
 set background=dark " for the dark version
 " set background=light " for the light version
 set guifont=Monaco:h15
 set backspace=indent,eol,start
 let mapleader = ","

 filetype plugin indent on     " required!

 set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
 set nu ruler
 set shellpipe=>
 set mouse=a
 set laststatus=2
 set shell=bash

 setglobal complete-=i

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
 imap jj <Esc>
 tnoremap jj <C-\><C-n>

 "CtrlP mappings
 let g:ctrlp_map = '<c-p>'
 let g:ctrlp_cmd = 'CtrlP'

 let g:indentLine_char = '¦'

" ALE linter
let g:ale_linters = {
\   'ruby': ['ruby', 'rubocop'],
\   'javascript': ['eslint'],
\}
let g:airline#extensions#ale#enabled = 1


 "vim-rspec mapping
 map <Leader>t :call RunCurrentSpecFile()<CR>
 map <Leader>s :call RunNearestSpec()<CR>
 map <Leader>l :call RunLastSpec()<CR>
 map <Leader>a :call RunAllSpecs()<CR>

 "Command-T call
 "nmap <leader>t :CommandT<CR>
 "nmap <leader>ft :CommandTFlush<CR>
 "if &term =~ "xterm" || &term =~ "screen"
 "  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
 "endif

 "execute rails and rake command with ConqueTerm
 "command -nargs=1 Rails execute ":ConqueTermSplit rails" '<args>'
 "command -nargs=1 Rake execute ":ConqueTermSplit rake" '<args>'
 "

 "fugitive-gitlab
 let g:fugitive_gitlab_domains = ['https://git.shiphawk.com']
 let g:gitlab_api_keys = {'gitlab.com': 'Q_NwFy79ZznWEQksx1TK'}


 "Better window navigation
 nnoremap <C-l> <C-w>l
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l

 tnoremap <C-j> <C-w>j
 tnoremap <C-k> <C-w>k
 tnoremap <C-h> <C-w>h
 tnoremap <C-h> <C-w>h


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
       let index=((ctpn%ntp) +1)
     endif

     " move tab page.
     execute "tabmove ".index
   endif
 endfunction

 map <Space>h :call TabMove(-1)<CR>
 map <Space>l :call TabMove(1)<CR>

 au BufEnter *.rb syn match error contained "\<binding.pry\>"
 au BufEnter *.rb syn match error contained "\<debugger\>"


 "set clipboard both of system and xterm
 if has('unnamedplus')
     set clipboard=unnamed,unnamedplus
 endif

 vnoremap <Leader>a y:Ag <C-r>=fnameescape(@")<CR><CR>
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
 
