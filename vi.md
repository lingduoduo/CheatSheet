####  Editing File in vi

vi command mode (Esc)

* k - Up one line
* j - Down one line
* h - Left one character
* l - Right one character 
* w - Right one word
* b - Left one word
* ^ - Go to the beginning of the line
* $ - Got to the end of the line
* x - Delete a character
* dw - delete a word
* dd - delete a line
* D - delete from the current position
* r - replace the current character
* cw - change the current word
* cc - change the current line
* c$ - change the text fromthe current position
* C - save as c$
* ~ - reverses the case of a character
* * u - undo whatever you just did
* ctrl+r - redo whatever you just did
* yy - copy(yank, cut) the current line into the buffer
* Nyy - copy(yank, cut) the next N lines, including the current line, into the buffer
* p - put(paste) the line(s) in the buffer into the text after the current line 

* /<pattern> start a forward search, type n to next match , type N to previous match
* ?<pattern> start a reverse search, type n to next match , type N to previous match

vi line mode (:)

* :w - Writes(saves) the file
* :w! - Forces the file to be saved
* :q - Quit
* :q! - Quit without saving changes
* :wq! - Write and quit
* :x - Same as :wq
* :n - positions the cursor at line n
* :$ - positions the cursor on the last line
* set nu - turn on line numbering
* set nonu - turn off line numbering

vi insert mode(ilaA)

* i - insert text before cursor, until Esc hit
* I - insert text at beginning of current line, until Esc hit
* a - append text after cursor, until Esc hit
* A - append text to end of current line, until Esc hit
* o - open and put text in a new line below current line, until Esc hit
* O - open and put text in a new line above current line, until Esc hit
