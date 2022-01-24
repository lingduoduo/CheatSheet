####  Editing File in vim

vim normal mode (:)

* :wq - quit and save
* :w - Writes(saves) the file
* :w! - Forces the file to be saved
* :q - Quit
* :q! - Quit without savimng changes
* :wq - Write and quit
* :n - positions the cursor at line n
* :$ - positions the cursor on the last line

* set nu - turn on line numbering
* set nonu - turn off line numbering
* :vs - vertical split
* :sp - split
* :% s/foo/bar/g

vim insert mode

* i - insert text before cursor, until Esc hit
* I - insert text at beginning of current line, until Esc hit
* a - append text after cursor, until Esc hit
* A - append text to end of current line, until Esc hit
* o - open and put text in a new line below current line, until Esc hit
* O - open and put text in a new line above current line, until Esc hit
* gi - jump to insert mode
* ctrl + [ - jump to normal mode 

vim command mode (Esc)

* j - Down one line
* h - Left one character
* l - Right one character 
* w - Right one word
* ^ - Go to the beginning of the line
* $ - Got to the end of the line
* } - 跳到下一个段
* W：移动到下一个单词的开头处
* E：移动到下一个单词的结尾处
* B：移动到前一个单词的开头处
* gE：移动到前一个单词的结尾处

* 0：移动到当前行的第一个字符处
* ^：移动到当前行第一个非空字符处
* g_：移动到当前行最后一个非空字符处
* $：移动到当前行最后一个字符处
* n|：移动到当前行的第n列


Vim 中的 Verbs，就相当于操作符
* ctrl + h : delete one character
* ctrl + w : delete one word
* ctrl + u : delete one line
* d：删除文本，保存到register
* c：删除文本，保存到register，并开始「插入」模式
* u: delete whole line

* dw - delete a word
* dd - delete a line
* cw - change the current word
* cc - change the current line


Verbs+Nouns

y$：把当前所有的东西，从当前位置拖拽至行末
dw：从当前位置删除到下一个单词的开头
c}：将当前位置更改为此段末尾
y2h：向左拉2个字符
d2w：删除接下来的2个单词
c2j：改变接下来的2行内容
dd: 删除整行内容
cc: 更改整行内容


column terminal 命令
!}column -t -s “|”

Id   Name    Cuteness
01  Puppy    Very
02  Kitten    Ok
03  Bunny   Ok


!}column -t -s “|” | awk ‘NR > 1 && /Ok/ {print $0}’

02  Kitten  Ok
03  Bunny  Ok
```

* b - Left one word
* x - Delete a character
* D - delete from the current position
* r - replace the current character
* c$ - change the text fromthe current position
* C - save as c$
* ~ - reverses the case of a character
* * u - undo whatever you just did
* ctrl+r - redo whatever you just did
* yy - copy(yank, cut) the current line into the buffer
* Nyy - copy(yank, cut) the next N lines, including the current line, into the buffer
* p - put(paste) the line(s) in the buffer into the text after the current line 

* /<pattern> start a forward search, type n to next match , type N to previmous match
* ?<pattern> start a reverse search, type n to next match , type N to previmous match

6. 移動到第 43 列，向右移動 59 個字元，請問你看到的小括號內是哪個文字？
43G -> 59l

7. 移動到第一列，並且向下搜尋一下『 gzip 』這個字串，請問他在第幾列？
gg 或 1G -> /gzip -> 在第 93 列

8. 接著下來，我要將 29 到 41 列之間的『小寫 man 字串』改為『大寫 MAN 字串』，並且一個一個挑選是否需要修改，如何下達指令？如果在挑選過程中一直按『y』， 結果會在最後一列出現改變了幾個 man 呢？
输入命令 [:29,41s/man/MAN/gc] -> 然后一直点击 y ，总共需要替换 13 个4g24:24G

9. 修改完之後，突然反悔了，要全部復原，有哪些方法？
一直按 u 键即可复原；更加简单粗暴的就是强制退出，也就是输入 :q!

10. 我要複製 66 到 71 這 6 列的內容(含有MANDB_MAP)，並且貼到最後一列之後；
66G 跳到 66 行 -> 6yy 复制 6 行内容(输入后，屏幕最后一行会显示 6 lines yanked) -> G 跳到最后一行，输入 p 复制到最后一行的后面

11. 113 到 128 列之間的開頭為 # 符號的註解資料我不要了，要如何刪除？
113G 跳到 113 行 -> 总共需要删除 16 行内容，所以输入 16dd

12. 將這個檔案另存成一個 man.test.config 的檔名；
输入 [:w man.test.config] 实现保存操作，接着可以输入 [:! ls -l]，即显示查看当前文件夹内文件内容的命令 ls -l 显示的内容在 vimm 内，再次按下回车键即回到 vimm 命令模式

13. 去到第 25 列，並且刪除 15 個字元，結果出現的第一個單字是什麼？
输入 25G 到 25 行 -> 15x 删除 15 个字符，然后显示的是 tree

14. 在第一列新增一列，該列內容輸入『I am a student...』；
gg / 1G 到 第一行 -> O 在上方新增一行，然后输入 『I am a student…』-> Esc 键返回命令模式

15. 儲存後離開吧！
[:wq] 或者 ZZ 保存离开文件

https://github.com/iggredible/Learn-Vim
