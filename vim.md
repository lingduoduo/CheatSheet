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

* set nu - turn on line numbering
* set nonu - turn off line numbering
* set hls - set highlight search
* set incsearch - set incremental search
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
* ctrl + u - page up
* ctrl + f - page down

vim virtual model 

* v - switch to virtual model for selection

Vim 中的 Verbs，就相当于操作符

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

* :[range]s[ubstitute]/{pattern}/{string}/[flags]
* :% s/char/character/g
* :1,10 s/char/character/g
* :1,10 s/char//n
* :% s/char//c
* :% s/\<char\>/character/g

* / or ? to search forward or backward
* n / N to move forward or backward
* * / # to move forward or backward

* buffer
* :ls - list buffer
* :b n - jump to buffer n
* :bpre:bnext:bfirst:blast
* :b buffer name - jump to buffer with name

* 

1 D - delete from the current position
2 r - replace the current character
3 c$ - change the text fromthe current position
4 save as c$
5 ~ - reverses the case of a character
6 ctrl+r - redo whatever you just did
7 ff yy - copy(yank, cut) the current line into the buffer
* Nyy - copy(yank, cut) the next N lines, including the current line, into the buffer
