###  Editing File in vim

vim normal mode 

* :wq - quit and save
* :w - Writes(saves) the file
* :w! - Forces the file to be saved
* :q - Quit
* :q! - Quit without savimng changes
* :wq - Write and quit
* :n - positions the cursor at line n
* :$ - positions the cursor on the last line

* syntax on
* :colorscheme slate
* :set nu - turn on line numbering
* :set nonu - turn off line numbering
* :set hls - set highlight search
* :set incsearch - set incremental search
* :set paste and :set nopaste
* :set autoindent
* :set clipboard = unnamed

* :vs - vertical split
* :sp - split
* :% s/foo/bar/g

change vim to insert mode

* i - insert text before cursor, until Esc hit
* I - insert text at beginning of current line, until Esc hit
* a - append text after cursor, until Esc hit
* A - append text to end of current line, until Esc hit
* o - open and put text in a new line below current line, until Esc hit
* O - open and put text in a new line above current line, until Esc hit
* gi - jump to insert mode
* ctrl + [ - jump to normal mode 

vim normal mode (Esc)

* h - Left one character
* l - Right one character
* j - Down one line
* k - Up one line

* w/W - Right one word
* e/E - End one word
* b/B - Back one word
* f{char} + ,/; - Move to char and forward/backward
* t{char} - Move to until char
* F - backward move  

* 0 - one line start
* $ - one line end
* () - one sentence
* {} - one paragraph

* gg - file start
* G - file end
* H/M/L - Head/Middle/Lower of screen
* ctrl + u - page upward
* ctrl + f - page forward

vim virtual mode 

* v - switch to virtual model for selection
* V - start selection from the current line

vim operator

* u - undo
* ctrl + r - redo undo
* x - delete a char
* 2x - delete 2 chars
* dw - delete a word
* daw - delete around a word
* diw - delete a word
* dd - delete a line
* 4dd - delete four lines
* dt"char" - delete until char
* d$ - delete to the end of the current line
* d0 - delete to the start of the current line

* r - replace
* c - change
* s - substitute
* r"char" - replact to char 
* R - continuouly replace chars
* cw - change a word and change to insert model
* ct"char" - delete the chars util char and change to insert mode

* :[range]s[substitute]/{pattern}/{string}/[flags]
* :% s/char/character/g
* :1,10 s/char/character/g
* :1,10 s/char//n
* :% s/char//c
* :% s/\<char\>/character/g

* / or ? to search forward or backward
* n / N to move forward or backward
* * / # to move forward or backward

buffer

* :ls - list buffer
* :b n - jump to buffer n
* :bpre:bnext:bfirst:blast
* :b buffer name - jump to buffer with name


window

* ctrl + w - jump to window
* :sp vim.md - open vim in a split window
* :vs vim.md - open vim in a split window

text object

* [number]<command>[text object]
* command - d(delete), c(change), y(yank), v(visual)
* text object - w(word), s(sentence), p(paragraph)
* iw - inner word
* aw - around word
* vi(,) - i<,> - i{,} - i" - i' - select inner the symbol  
* va(,) - a<,> - a{,} - a" - a' - select around the symbol
* ci(,) - i<,> - i{,} - i" - i' - change inner the symbol  
* ca(,) - a<,> - a{,} - a" - a' - change around the symbol

copy/paste in normal mode

* y (yank) - copy
* p (put)
* d (copy and delete)
* v to select and p to paste
* yiw - copy a word
* yy - copy a line

copy/paste in insert mode

* cmd +v to paste
* "0 to copy to memory 0
* "+ p to paste from system clipboard
* "% current file name
* ". previous file name

macro

* q - record
* q{register} - save commands
* q - quit
* qa -> @a or virtual select rows, then :'<,'>normal @

auto-complete
* ctrl + n / ctrl + p  - general keyword next and previous selection
* ctrl + xf - file name
* ctrl + o - omni

map

* nmap/vmap/imap to map in normal/visual/insert mode
* nnoremap/vnoremap/inoremap in non-recursive mode
* :vmap \ U - convert word to uppercase 
* :imap <c-d> <Esc>ddi

vim plugin

* Install Vim-Plug, according to its instructions.
* nerdtree - :NERDTreeToggle
* ctrlp
* easymotion ss + 'char'
* vim-surround :ds(delete a surrounding, e.g. ds '), :cs(change a surrounding, e.g., cs " '), :ys(you add a surrounding, ysiw ")
* fzf.vim :Ag[patter] for char, Files[PATH] for directory, need to 'brew install the_silver_searcher'
* far.vim ':Far foo bar **/ * .py ' and Fardo
* vim-go 
* python-mode :PymodeLintAuto
* vim-commentary :gc
* vim-fugitive :Gedit, Gdiff, Gblame, Gcommit

Add the following text to your ~/.vimrc.
```
set nu
set hlsearch
set foldmethod=indent
set pastetoggle=<F2>
syntax on

let mapleader=','
let g:mapleader=','

inoremap jj <Esc>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

com! FormatJSON %!python4 -m json.tool 

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Yggdroot/indentLine'
Plug 'w0ng/vim-hybrid'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

call plug#end()

set background=dark
colorscheme hybrid

let g:ctrlp_map = '<c-p>'

nmap ss <Plug>(easymotion-s2)

let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymodel_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_options_max_line_length = 120

```

Restart Vim, and run the :PlugInstall statement to install your plugins.

**Insert mode**
-   使用a/i/o进入插入模式；
-   ctrl+h 删除上一个字符
-   ctrl+w 删除上一个单词
-   ctrl+u 删除 当前行
-   使用 ctrl+c代替Esc（但是可能会中断某些插件），所以推荐使用 ctrl+[
-   gi 快速跳转到最后一次编辑的地方并进入插入模式

Normal 移动的快捷方式：
-   w/W: 移动到下一个word/WORD 开头
-   e/E: 移动到下一个 word/WORD 结尾
-   b/B: 移动到上一个 word/WORD 开头  (backword)
  
行间搜索移动
-   f{char}: 当前光标往行后搜索字符, 分号(;)下一个找到的字符，逗号(,)上一个找到的字符
-   F{char}: 当前光标往前搜索字符
-   0: 移动到行首第一个字符
-   ^: 移动到第一个非空白字符
-   $: 移动到行尾
-   g_: 移动到行尾非空白字符

页面移动
-   gg: 文件开头
-   G: 文件结尾
-   H: 屏幕的开头(Head)
-   M: 屏幕的中间(Middle)
-   L: 屏幕的结尾(Lower)
-   crtl+u: 上翻页（upword）
-   ctrl+f: 下翻页（forword）
-   zz: 屏幕置为中间

增加字符
-   a/i/o A/I/O

vim快速删除
-   x快速删除一个字符
-   d可以配合文本对象快速删除一个单词
-   dw删除整个单词包括空格
-   daw删除整个单词包括空格
-   diw不包括空格
-   dd删除一行
-   dt) 删除直到)的内容
-   di)可以删除整个括号内的内容
-   数字加命令表示多次执行
    
vim快速修改
-   r(replace)替换一个字符
-   s(substitute)替换并进入插入模式
-   c(change)和d的用法差不多  

vim查询
- 进行前向或者反向搜索
- 使用n/N跳转到下一个或者上一个匹配
- 使用*或者#进行当前单词的前向和后向匹配
  
vim 替换命令
- :[range]s[ubsititute]/{pattern}/{string}/[flags]
- range 范围 10,20代表10-20行， %全部
	- flags有几个常用的标志
	- g（global）表示全局范围内执行
	- c（confirm）表示确认，可以确认或者拒绝
	- n（number)报告匹配到的次数而不替换，可以用来查询匹配次数

vim多文件操作
- Buffer，Window，Tab
	- Buffer是指打开的一个文件的内存缓冲区
	- 窗口是Buffer可视化的分割区域
	- Tab可以组织窗口位一个工作区
- Buffer
	- Buffer-什么是缓冲区？
	- vim打开一个文件后会加载文件内容到缓冲区
	- 之后的修改都是针对内存着的缓冲区，并不会直接保存到文件
	- 直到我们执行:w（write）的时候才会把修改内容写入到文件里
- Buffer切换  
	- 使用:ls会列举当前缓冲区，然后使用:b n跳的第n个缓冲区
	- :bpre :bnext :bfirst :blast  
	- 或者用:b buffer_name加上tab补全来跳转

- Window窗口  
	- 窗口是可视化的分割区域  
	- 一个缓冲区可以分割成多个窗口，每个窗口也可以打开不同缓冲区  
	- <Ctrl+w>s水平分割，<Ctrl+w>v垂直分割。或者:sp和:vs
	- 每个窗口可以继续无限分割

	| 命令 | 用途 |
	| --- | --- |
	| <Ctrl-w>w|在窗口键来回切换 |
	| h | 切换到左边窗口 |
	| j | 切换到下边窗口 |
	| k | 切换到上边窗口 |
	| l | 切换到右边窗口 |
	
	大写时可以移动窗口  

- Tab（标签页）将窗口分组
	- Tab是可以容纳一系列窗口的容器（:h tabpage)
	- vim 的Tab和其他编辑器不太一样，可以想象成Linux的虚拟桌面
	- 比如一个Tab全用来编辑Python文件，一个Tab全是HTML文件
	- 相比窗口，Tab一般用的比较少，Tab太多，管理起来也太麻烦

- vim的文本对象(text object)
	- vim里文本也有对象的概念，比如一个单词，一段句子，一个段落
	- 很多其他编辑器经常只能操作单个字符来修改文本，比较低效
	- 通过操作文本对象来修改要比只操作单字符高效
		- [number]<command>[text object]  
		- number表示次数，command是命令, d(elete), c(hange), y(ank)  
		- text object是要操作的文本对象, 比如单词w，句子s，段落p  
		- 主要使用的有iw, inner word, 如果使用viw,那么v进入选择模式，iw选择当前单词  
		- aw 表示around word，不但会选中当前单词，还会包含当前单词之后的空格。
	
- vim复制粘贴与寄存器的使用
	- vim在Normal模式复制粘贴
		- Normal模式下复制粘贴分别使用y（yank）和p（put），剪切d和p
		- 可以使用v（visual）命令选中所要复制的地方，然后顺遂p粘贴
		- 配合文本对象：比如顺遂yiw复制一个单词，yy复制一行
	- Insert模式下的复制粘贴
		- 和其他文本编辑器差不多，但粘贴代码有个坑
		- 在vimrc中设置了autoindent，粘贴Python代码缩进错乱
		- 这个时候需要使用`:set paste`和`:setnopaste`解决
	- 什么是vim的寄存器  
		- vim里操作的是寄存器而不是系统剪切版，这和其他编辑器不同
		- 默认使用d删除或者y复制的内容都放到了“无名寄存器”
		- 用x删除一个字符放到无名寄存器，然后p粘贴，可以调换俩字符
	- 深入寄存器（register）
		- 通过 "{register} 前缀可以指定寄存器，不指定默认无名寄存器
		- 比如使用`"ayiw`复制一个单词到寄存器a中，`"bdd`删除当前行到寄存器b中
		- :reg a查看寄存器a中的内容
		- "a p粘贴a寄存器中的内容
 		其他常见寄存器  
			除了有名的寄存器a-z，vim中还有一些其他常见寄存器
			- 复制专用寄存器`"0`使用y复制的文本同时会被考呗到复制寄存器0
			- 系统剪切版`"+`可以复制到系统剪切版
			- 其他寄存器，比如`"%`当前文件名，`".`上次插入的文本
			- :set clipboard=unnamed可以让你直接复制粘贴系统剪切版内容
- vim宏（macro）
	- 从需求说起  
		- 批量处理文本  
	- 什么是vim宏（macro）
		- 宏可以看成是一系列命令的集合  
		- 我们可以使用宏【录制】一系列操作，然后用于回放
		- 宏可以方便的把一下列命令用在多行文本上
	- 如何使用宏
		- vim使用q来录制，同时也也是q结束录制
		- 使用q{register}选择要保存的寄存器，把录制的命令保存其中  
		- 使用@{register}回放寄存器中保存的一系列命令
	- 用宏解决刚才的问题  
		- 献给一行加上双引号，让后在回放到其他行  
		- 我们先使用q开始录制，给一行加上双引号，之后使用q退出
		- V选择一行，使用G全选剩下的，然后在命令行模式下：normal 就是使用normal模式下的命令， :normal @a 就可以将剩下的全部执行记录下的宏。
	
- vim补全大法
	- 什么是补全
		- 补全是根据当前环境上下文有编辑器【猜】你想输入的东西
		- 比如补全一个单词、文件名、或者代码中的函数名、变量名
		- vim中提供了多种补全功能，还有由插件拓展功能实现代码补全
	- vim中有很多种补全方式
	
		| 命令   | 补全类型   |
		| ------ | ---------- |
		| \<C-n> | 补全关键字 |
		|\<C-x>\<C-n>|当前缓冲区关键字|
		|\<C-x>\<C-i>|包含文件关键字|
		|\<C-x>\<C-j>|标签关键字|
		|\<C-x>\<C-k>|字典查找|
		|\<C-x>\<C-l>|整行补全|
		|\<C-x><C-0>|全能（Omin）补全|
	- 常见的三种补全类型
		- 使用Ctrl+n和Ctrl+p补全单词, ctrl + n 往下， ctrl + p 往上
		- 使用Ctrl+x，Ctrl+f补全文件名, : r! echo %:p   当前文件路径
		- 使用Ctrl+x，Ctrl+o补全代码，需要开启文件类型检查，安装插件

- 给vimhr个配色  
	- vim更换配色  
	- 使用:colorscheme显示当前主题配色，默认是default
	- 用:colorscheme <ctrl+d>可以显示所有配色
	- 中意的配色后，用:colorscheme 配色名就可以修改配色
