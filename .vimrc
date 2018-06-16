" I borrowed most of this config on 2017-10-01 from
" https://github.com/riceissa/dotfiles

scriptencoding utf-8
set nocompatible

" Use vim-plug to manage Vim plugins. Install with
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Once all Vim config files are in the right places, just do :PlugInstall in
" Vim to install the plugins.
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'coltongrainger/vim-markdown'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/gv.vim'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'nelstrom/vim-visual-star-search'
Plug 'riceissa/vim-dualist'
Plug 'riceissa/vim-inclusivespace'
Plug 'riceissa/vim-longmove'
Plug 'riceissa/vim-mediawiki'
Plug 'riceissa/vim-more-toggling'
Plug 'riceissa/vim-pasteurize'
Plug 'riceissa/vim-proselint'
Plug 'riceissa/vim-rsi'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dbeniamine/vim-mail'
call plug#end()

" Workaround for https://github.com/tpope/vim-sleuth/issues/29 to override
" sleuth.vim for some filetypes.
runtime! plugin/sleuth.vim

" Override ttimeoutlen later
runtime! plugin/sensible.vim

set nomodeline ignorecase smartcase showcmd noequalalways nojoinspaces
set fo+=aj
set spellfile=~/.spell.en.utf-8.add wildmode=list:longest,full sidescroll=1

nnoremap Y y$

if has('autocmd')
  augroup vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.arbtt/categorize.cfg setlocal syntax=haskell
    autocmd FileType crontab setlocal commentstring=#%s
    autocmd FileType gitcommit,mail,markdown,mediawiki,tex setlocal spell
    autocmd FileType gitconfig setlocal commentstring=#%s
    autocmd FileType help,man nnoremap <buffer> <silent> q :q<CR>
    autocmd FileType help,man setlocal nolist nospell
    autocmd FileType mail setlocal fo+=w
    autocmd FileType mail setlocal tw=79
    autocmd FileType mail,text,help setlocal comments=fb:*,fb:-,fb:+,n:>
    autocmd FileType make setlocal noexpandtab
    autocmd FileType markdown,text,mail setlocal formatprg=par\ -w79qe
    autocmd FileType matlab setlocal commentstring=%%s
    autocmd FileType php setlocal commentstring=//%s
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufRead *.page setlocal filetype=markdown
    " sleuth.vim usually detects 'shiftwidth' as 2, though this depends on how
    " the Markdown is written. As for 'textwidth', I like 79 on most Markdown
    " files, but on *some* Markdown files (such as ones where I am editing
    " pipe tables with long lines) I want 'textwidth' to stay 0. So we set a
    " buffer-local variable to track if we have already run the autocmd so it
    " only runs once. Otherwise if we leave the buffer and come back, the
    " autocmd would run again.
    autocmd FileType markdown if !exists('b:did_vimrc_markdown_textwidth_autocmd') | setlocal expandtab shiftwidth=2 tabstop=2 textwidth=0 | let b:did_vimrc_markdown_textwidth_autocmd = 1 | endif
    " Prevent overzealous autoindent in align environment
    autocmd FileType tex setlocal indentexpr=
    autocmd FileType tex let b:surround_{char2nr('m')} = "\\(\r\\)"
    autocmd FileType tex let b:surround_{char2nr('M')} = "\\[\n\r\n\\]"
    " More aggressively check spelling in LaTeX; see
    " http://stackoverflow.com/questions/5860154/vim-spell-checking-comments-only-in-latex-files
    autocmd FileType tex syntax spell toplevel
    autocmd FileType vim setlocal keywordprg=:help
  augroup END
endif

" Fix common typos where one character is stuck to the beginning of the next
" word or the end of the last word.
inoremap <C-G>h <C-G>u<Esc>BxgEpgi
inoremap <C-G>l <C-G>u<Esc>gExpgi

if has('digraphs')
  digraph el 8230
  digraph ./ 8230
  digraph ^\| 8593
  digraph \\ 8726
  digraph \- 8726
  digraph -\ 8726
  digraph \|> 8614
  digraph v\| 8595
  " Run under exe so that syntax highlighting isn't messed up
  exe 'digraph (/ 8713'
  exe 'digraph (\ 8713'
  exe 'digraph (< 10216'
  exe 'digraph >) 10217'
endif

iabbrev ADd Add

let g:tex_flavor = 'latex'
let g:sql_type_default = 'mysql'
let g:surround_{char2nr('q')} = "“\r”"
let g:surround_{char2nr('Q')} = "‘\r’"
let g:dualist_color_listchars = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:vim_markdown_folding_disabled = 1

nmap <silent> ]w <Plug>(ale_next)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> [W <Plug>(ale_first)
nmap <silent> ]W <Plug>(ale_last)
nnoremap [s [s<Space><BS>
nnoremap ]s ]s<BS><Space>

highlight Visual ctermfg=White ctermbg=Gray
highlight Folded ctermfg=DarkGray ctermbg=LightGray cterm=bold,underline
highlight SpellBad ctermfg=White ctermbg=Red

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
