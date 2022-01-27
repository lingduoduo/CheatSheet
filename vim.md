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
* ctrl + u - page up
* ctrl + f - page down

vim virtual model 

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
* qa -> @a or virtual select rows, then :'<,'>normal @a
