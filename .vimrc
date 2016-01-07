"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 使用Vundle管理插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基本配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sw=4 			    " 自动缩进的宽度。(shitwidth)
set ts=4			    " tab替换的空格数量。(tabstop)
set et				    " 用空格代替tab。(expandtab,反：noexpandtab)
set smarttab			" 在行和段开始出使用tab
set smartindent			" 为C程序提供自动缩进
set lbr				    " 屏幕折行，不会断裂单词。(linebreak)
set fo+=mB			    " 打开断行模块对亚洲语言支持。
				        " m表示允许在两个汉字之间断行,即使汉字之间没有出现空格。
				        " B表示两行合并为一行的时候,汉字与汉字之间不要补空格。

set sm				        " 会在你敲},]或)显示出对应匹配的{,[或(来。(showmatch)
set selection=inclusive		" 选择方式
set wildmenu			    " 增强模式中的命令行自动完成操作
set mousemodel=popup		" 右键菜单
set number                  " 显示行号
set langmenu=zh_CN.UTF-8    " 菜单使用的语言
set helplang=cn             " 首选帮助语言 
set history=500             " 历史记录数
set nocompatible            "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set viminfo+=!              " 保存全局变量
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割
" 自动缩进
set autoindent
set cindent
set backspace=indent,eol,start "插入模式下delete健可删除
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                   " 语法高亮
colorscheme desert 
set cul                     " 高亮光标所在行
set cuc                     " 高亮光标所在列
set shortmess=atI           " 启动的时候不显示那个援助乌干达儿童的提示  
set go=                     " 不要图形按钮
set ruler                   " 显示标尺
set showcmd                 " 输入的命令显示出来，这样看的更清楚些
set scrolloff=3             " 光标移动到buffer的顶部和底部时保持3行距离
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2            " 启动显示状态行(1),总是显示状态行(2)
set hlsearch                " 高亮最近的匹配搜索模式
set incsearch               " 输入搜索模式时同时高亮部分的匹配

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动插入同文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: ") 
		call append(line(".")+2, "	> Mail: ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 键盘命令
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nmap <silent> <F9> <ESC>:Tlist<RETURN>
" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
map <F12> gg=G
map <C-w> <C-w>w
imap <C-k> <C-y>,
imap <C-t> <C-q><TAB>
imap <C-j> <ESC>
" 选中状态下 Ctrl+c 复制
"map <C-v> "*pa
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y
set mouse=v
"set clipboard=unnamed
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"nnoremap <Leader>fu :CtrlPFunky<Cr>
"nnoremap <C-n> :CtrlPFunky<Cr>
"列出当前目录文件  
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
map <C-F3> \be  
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>
func FormartSrc()
     exec "w"
     if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
     elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
     elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
     elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
     elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
     elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
     elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
     else
        exec "normal gg=G"
     endif
     endfunc
" 结束定义FormartSrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 实用设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif
"当打开vim且没有文件时自动打开NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd vimenter * if !argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 设置当文件被改动时自动载入
set autoread
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
