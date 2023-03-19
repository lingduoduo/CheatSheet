The Bash shell is a programming environment that combines commands and control structures. Bash scripts typically end with a .sh extension, and to make them executable, you need to use the chmod command and set the user execute permission with u+x, like this: chmod u+x myscript.sh.

The first line of the script must specify the location of the Bash interpreter, which is #! /bin/bash. Here is an example Bash script:

```bash
\#!/bin/bash
echo "Listing of current directory"
ls
echo "Listing of root directory"
cd /
ls
```
To run this script, save it to a file with the .sh extension (e.g. myscript.sh), make it executable using chmod u+x myscript.sh, and then run it with ./myscript.sh. This will execute the commands in the script and display the output.

### Pipes
In Bash, pipes are used to connect the standard output (stdout) of one command to the standard input (stdin) of another command using the vertical bar symbol "|". This allows you to create powerful command pipelines that can process and transform data in a variety of ways.

For example, you can use the sort command and the uniq command together to filter out duplicate lines from a text file. Here is an example command pipeline:
```bash
command 1 | sort | uniq
```
In this pipeline, the output of command 1 is passed to the sort command, which sorts the lines in alphabetical order. Then, the sorted output is passed to the uniq command, which removes any duplicate lines.

By chaining commands together using pipes, you can create complex data processing pipelines that can accomplish a wide range of tasks.

### Redirection
In Bash, you can use the redirect operator ">" to redirect the standard output (stdout) of a command to a file instead of the terminal. This allows you to save the output of a command to a file for later use or to share it with others.

For example, you can use the ">" operator to redirect the output of a command to a text file. Here is an example command:

```bash
Command > file.txt
```
In this command, "Command" is the command whose output you want to redirect, and "file.txt" is the name of the file where you want to save the output.

Here's an example of how you can use the redirect operator to save the output of a shell script to a text file:
```bash
#!/bin/bash
sort fruits.txt | uniq | nl > uniquefruits.txt
```
In this shell script, the output of the command pipeline (sort fruits.txt | uniq | nl) is redirected to a file called "uniquefruits.txt" using the ">" operator. This saves the numbered list of unique fruits to the file for later use or analysis.

Using the redirect operator, you can easily capture and save the output of commands and shell scripts to files for further processing.

### Command Line Arguments
In Bash, you can pass command line arguments to a script or a command using the "$1", "$2", "$3", etc. variables. These variables represent the first, second, third, and so on command line arguments that were passed to the script or command.

For example, you can use the "$1" variable to access the value of the first command line parameter, and the "$2" variable to access the value of the second command line parameter. The "$0" variable represents the name of the command itself.

Here is an example of how you can use command line arguments in a shell script to sort a file of fruits and output a numbered list of unique fruits to a file:
```bash
$1 has value of first command line parameter
$2 the second command line parameter
$0 the command name itself
 sort “$1” | uniq | nl > uniquefruits.txt

#!/bin/bash
sort "$1" | uniq | nl > uniquefruits.txt
```

In this script, the "$1" variable is used to represent the first command line argument, which should be the filename of the file to sort. The "sort" command sorts the contents of the file, and the "uniq" command removes any duplicate lines. The "nl" command adds line numbers to the output, and the final output is redirected to a file called "uniquefruits.txt" using the ">" operator.

Using command line arguments, you can make your shell scripts more flexible and reusable, allowing you to process different files or input data using the same script or command.

### Exit Status
In Bash, the exit status of a command is represented by an integer value that indicates whether the command succeeded or failed. A success status is represented by 0, while a non-zero status indicates failure.

The grep command is a powerful text search tool that can search for patterns in one or more files. The basic syntax of the grep command is:
```bash
grep [OPTIONS] PATTERN [FILE…]
```

For example, you can use the grep command to search for all lines in a file that contain the word "apple":
```
grep apple fruits.txt
```

By default, the grep command matches any line that contains the word "apple", including lines that contain the word as a substring. To match only the exact word, you can use the "-w" option:

```bash
#!/bin/bash
if grep "/bin/bash" "$1" > /dev/null
then
  echo "File is a shell script"
elif grep "/bin/python" "$1" > /dev/null
then
  echo "File is a Python script"
else
  echo "File is not a shell or Python script"
fi
```
In this script, the grep command is used to search for the presence of the "/bin/bash" or "/bin/python" string in the specified file. The output of the grep command is redirected to /dev/null to suppress any output. The exit status of the grep command is used in an if-else statement to determine the type of script. If the string is found, the appropriate message is printed, otherwise a message indicating that the file is not a shell or Python script is printed.

### Conditions
In Bash, you can use the test command or the "[" command to examine conditions. The "=" operator is used to test for string equality, while the "!=" operator and "<" and ">" operators are used for lexicographic comparisons. To compare numerical values, you can use the "-eq", "-ne", "-gt", and "-lt" operators.

You can combine conditions using the "&&" and "||" operators. To test if a file or directory exists, you can use the "-e" operator. For example:
```bash
if [ -e "$1" ]
then
  echo "File exists"
fi
```

To test if a file or directory does not exist, you can use the "!" operator:
```
if [ ! -e "$1" ]
then
  echo "File does not exist"
fi
```

To test if no argument was passed, you can check if the variable is empty:
```bash
if [ "$1" = "" ]
then
  echo "No argument was passed"
fi
```
Here's an example of combining conditions:
```
a=1
b=1
if [ $a -eq 1 ] && [ $b -eq 1 ]
then
  echo "Both variables are equal to 1"
else
  echo "One of the variables is not equal to 1"
fi
```
In this example, the "&&" operator is used to combine two conditions. The first condition checks if the value of "a" is equal to 1, while the second condition checks if the value of "b" is equal to 1. If both conditions are true, the script prints a message indicating that both variables are equal to 1. Otherwise, it prints a message indicating that one of the variables is not equal to 1.

### Looping: while
Shift command can shift values of all command line argument variables left.
```bash

login3 08:04:16 ~ $ cat uniquefruits.sh
\#!/bin/bash
while [ -n "$1" ] #checking $1 is non-zero or not; -z checking for zero
do
 sort "$1" | uniq
 shift
done
```

### Looping: for
```bash
$@ expands to all command line arguments
{} can use for command substitution
 login3 08:23:30 ~ $ cat uniquefruits.sh
\#!/bin/bash

for filename in "$@"
do
 sort "$filename" | uniq > "${filename}.output1"
done
while [ -n "$1" ]
do
 sort "$1" | uniq > "${1}.output2"
 shift
done
```

### Global Expressions
```bash
\* ?  [] are meta-characters.
\* match any characters. ? match one character. [] match any character in the list.
\* txt match any characters containing txt
r??l match one character
r[!0-9]l match character in the list without numbers 0-9

**Command Substitution**
Command substitution - $(command), $(seq 10)
Arithmetic expansion - $((Expression)), ivar=10, echo $((ivar+10)).
grep subroutine *.f > subs.txt
grep apple *.txt > apple.txt
\- read build-in to reads a single line from stdin and assigns to variable.
read iword
two words
echo $iword
-tr command
Translate or delete characters
login3 10:39:46 ~ $ echo $iword
one two three
login3 10:39:58 ~ $ echo "Unix is simple" | tr "i" "a"
Unax as sample
login3 10:42:52 ~ $ echo "Unix is simple" | tr "is" "aT"
Unax aT Tample
login3 10:43:05 ~ $ echo "Unix is simple" | tr "a-z" "A-Z"
UNIX IS SIMPLE
login3 10:43:24 ~ $ echo "Unix is simple" | tr -d "i"
Unx s smple
login3 10:43:38 ~ $ echo "Unix is simple" | tr -d "is" #remove i and s
Unx mple
```

### 1 Bash shell example
```bash
login3 11:30:38 ~ $ cat myscript.sh
\#!/bin/bash
searchword=$1
searchword="$( echo $searchword | tr "A-Z" "a-z" )"
count=0
while read inputline
do
 inputline="$( echo $inputline | tr -d ".,()'\"" )"
 inputline="$( echo $inputline | tr "A-Z" "a-z" )"
 for word in $inputline
 do
   if [ $word = $searchword ]
   then
     count=$(($count + 1))
   fi
 done
done
echo $count
login3 11:30:52 ~ $ cat fruits.txt | ./myscript.sh Apple
16
5
```

### 2 File System basic
```bash
\# / - root
\# /bin - Binaries, programs
\# /sbin - System binaries, sytem program
\# /dev - Devices: hard drives, keyboard, mouse, etc.
\# /etc - system configurations
\# /home - user home directories
\# /lib - libraries of code
\# /tmp - temporary files
\# /var - various, mostly files the system uses
\# /usr - user programs, tools and libraries (not files)
\# /usr/bin
\# /usr/etc
\# /usr/lib
\# /usr/local

login3 10:42:38 ~ $ pwd
/homes/lingh

\# parent's parent's directory
cd ../..

\# user directory
cd ~

\# toggle directory

cd -
```

### 3 Working with Files and Dictionaries
```bash
cd "Application Support"
cd Application\ Support

touch fruits.txt
vi fruits.txt

\#small files
Cat fruits.txt

\#large files
less -N fruits.txt
less -M fruits.txt

\#sample lines from files
head -1 fruits.txt
tail -1 fruits.txt
tail -f /var/log/apache2/error_log

\#create directory
mkdir -p testdir/test1/test2
mkdir -vp testdir/test1/test3

\#move files and directory
mv newfile.txt ../newfile.txt
mv newfile.txt ..
mv -nv overwrite1.txt overwrite2.txt (not overwriting)
mv -fv overwriete1.txt overwrite2.txt (overwriting)
mv -i overwrite1.txt overwrite2.txt (interactive overwriting)

\#copy files and directories
cp newfile.txt newerfile.txt
cp -nv newfile.txt newerfile.txt (not overwriting)
cp -fv newfile.txt newerfile.txt (overwriting)
cp -i newfile.txt newerfile.txt (interactive overwriting)
cp -R test1 test1_copy_dir

\#delete files and directories
rm somefile.txt
rmdir somedir
rm -R somedir (delete files and directories recursively)

\#finder aliases/links and symbolic links
ln fruits.txt hardlink (ln filetolink hardlink - reference a hard copy file in a file system)
ln -s fruits.txt symlink (ln -s filetolink symlink - reference a file path of directory path)

\#search for files and directories
\# (*) is zero or more characters(glob)
\# (?) is any one character
\# ([]) is any character in the brackets
find ~/Documents -name 'someimage.jpg' (find path expression)
find ~/Sites -name 'index.html'
find ~/Sites -name 'index.???'
find ~/Sites -name 'index.*'
find ~ -name *.plist
find ~ -name *.plist -and -not -path *QuickTime
find ~ -name *.plist -and -not -paht *QuickTime -and -not *Preference
find /homes/lingh/ -name '*.*'
```

### 4 Ownership and Permissions

```bash
\#who am I
whoami
cd ~

\#Unix group
group
chown lingh:users fruits.txt
chown -R lingh:users fruits (change all files ownership in a dir)
sudo chown user1:users ownership.txt

\# group categories (user, group, other)
\# permission read(r-4), write(w-2), execute(x-1)
\# user(rwx), group(rw-), other(r--)
chmod mode filename
chmod ugo=rwx filename
chmod u=rwx,g=rw,o=r filename
chmod ug+w filename
chmod o-w filename
chmod ugo+rw filename
chmod a+rw filename
chmod -R g+w testdir

chmod 777 filename (all permissions)
chmod 764 filename (rwx+rw+r)
chmod 755 filename (rwx+rx+rx)
chmod 700 filename (rwx+ + )
chmod 000 filename (no permission)

\# root user
sudo ls -lla
sudo chown lingh file.txt
```

### 5 Commands and Programs

```bash
\#show command path
whereis echo
which echo
whatis echo
echo $PATH

\#computer system set up
date
uptime
\#dedupe nodedupe login users
users
who
\#system running on info
uname
uname -mnrsvp
hostname
domainname

\#disk free space
df
df -h
df -H
\#disk usage - allocation of hard disk
du
du ~
du -h ~/ (only directory)
du -ah ~/ (all files and directories)
du -hd 1 ~/ (go to directory with one deep)
du -hd 0 ~/ (only current directory)

\#viewing processes
ps (process status)
ps -a
ps aux (a: all processes, u: column showing th eprocess user, x show the background processes)
ps aux | grep lingh
top
top -n 10 (top 10 processes)
top -n 10 -o cpu -s 3 -U lingh (top 10 processes of lingh, sorted by CPU, refress every 3 seconds)

\#Stopping processes
kill pid
kill -9 pid (force to kill the process id)

\#Text File Helpers
wc (word count)
login3 13:13:28 ~ $ wc fruits.txt
   25    22   156 fruits.txt (25 lines, 22 words per line, total 156 words)
sort (sort lines)
sort fruits.txt
sort -f fruits.txt (mix upper case letters and lowercase letters)
sort -r fruits.txt (reverse sort)
sort -u fruits.txt (sorted and unique)
unique (filter in/out repeated lines)
uniq fruits.txt
uniq -d fruits.txt (duplicate lines)
uniq -u fruits.txt (unduplicate lines)

\#Utility programs
cal/ncal (calendar)
cal
cal 12 20013
cal -y 2014
bc (bench calculator)
scale =100
q00/9
quit
expr (expression evaluator)
expr 1 + 1
expr 1122 \* 3344
units (unit conversion)
login3 13:32:19 ~ $ units
586 units, 56 prefixes
You have: 1 foot
You want: meters
    \* 0.3048
    / 3.2808399

\#Command history
\#!3 - references history command #3
\#!-2 - references command withich was 2 commands-back
\#!cat - references most recent command beginning with "cat"
\#!! - references previous command
\#!$ - references previous command's arguements
cat .bash_history
history
!1 (run 1st line of command in the history)
!-5 (run a command that was five commands ago)
!expr (most recent command that began with expr)
!! (edit lines and re-execute)
chown lingh fruit.txt
sudo !! (that is, sudo chown lingh fruit.txt)
cat fruits.txt
less !$ (run the command with the arguments fromt the previous command)
history -d 10 (delete the 10th line of history)
history -c (clean all history)
```

### 6 Directing Input and Output

```bash
\#Standard input -stdin, keyboard, /dev/stdin
\#standard output -stdout, text terminal /dev/stdout
sort fruits.txt > sortedfruits.txt
unique sortedfruits.txt > uniquefruits.txt
cat apple.txt apple2.txt > applecat.txt
echo 'fruits.txt' >> apple.txt (appended to the file)
\#Directing input form a file
sort < fruits.txt
sort < fruits.txt > sortedfruits.txt
\#Piping output to input
echo "HELLO WORLD" | wc
echo "(3+4)*9" | bc
cat fruits.txt | sort
cat fruits.txt | sort | uniq
sort < fruits.txt | uniq  > uniquefruits.txt
ps aux | less
\#Suppressing output
\#/dev/null - 'null device', 'bit bucket', 'black hold'
\#similar to special files /dev/stdin and /dev/stdout, unix discards any data sent there
ls -lah > /dev/null
```

### 7 Configuring Your Working Environment

When you login (type username and password) via Terminal, either sitting at the machine, or remotely via ssh, .bash_profile is executed to configure your shell before the initial command prompt.

If you've already logged into your machine and open a new terminal window (xterm) inside a client other than Mac OSX Terminal, then .bashrc is executed before the window command prompt.

```bash
\#Upon login to a bash shell - This only runs on user login
\#/etc/profile - system configurations with master default commands
\#~/.bash_profile, ~/.bash_login, ~/.profile, ~/.login
\#Add to ~/.bash_profile and then put all shell configuration in ~/.bashrc
if [ -f ~/.bashrc ]; then
source ~/.bashrc
fi

\#Upon starting a new bash subshell - This loads in the configuration .bashrc, put all configuration there.
\#~/.bashrc (typein shell and open sub-shell using other resources)
source .bashrc (run .bashrc file)

\#Upon logging out of bash shell
\#~/.bash_logout

\#Setting command aliases
alias
alias lah='ls -lah' (define a new aliase)
unalias lah (delete an aliase)

\#Setting environment variables
echo USER=lingh (define a variable in bash)
expot echo (every time Unix launches a program, it'll make the variable available)

\#Setting PATH variables
\#PATH is a colon delimited list of file paths that Unix uses when it's trying to locate a command that you want it to run.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
```

### Configurign history with variables
```bash
export HISTSIZE=1000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%b %d %I:%M %p    '
export HISTCONTROL=ignoreboth (ignore dups and ignore space)
export HISTIGNORE="history:pwd:ls -lah:exit" (ignore commands in the history)
```

### Customizing the command prompt with format codes
```bash
\#\u - username
\#\s - current shell
\#\w - current working directory
\#\W - basename of current working directory
\#\d - date in 'weekday month date' format
\#\D{format} - date in strftime format {"%Y-%m-%d"}
\#\A time in 24-hour HH:MM format
\#\t time in 24-hour HH:MM:SS format
\#\@ time in 12-hour HH:MM am/pm format
\#\T time in 12-hour HH:MM:SS format
\#\H hostname
\#\h hostname up to first "."
\#|! history number of this command
\#\$ when UID is 0 (root), a "#", otherwise a "$"
\#\\ a literal backslash
PS1='--> ' (change the main command prompt)
PS1="\h:\W\u$'
```

### 8 Unix Power Tools

### grep - global regular expression print
```bash
grep apple fruit.txt (return the line containing apple in fruit.txt)
grep -i apple fruit.txt (case insensitive)
grep -w apple fruit.txt (find only word apple)
grep -v apple fruit.txt (reverse match, that is, find lines don't matched)
grep -n apple fruit.txt (find the matched lines with line numbers)
grep -c apple fruit.txt (find counts of the matched lines)
grep -R apple . (find word apple in all files under the current directory)
grep -Rn apple . (find word apple in all files with line number under the current directory)
grep -Rl apple . (find word apple in all files with only file under the current directory)
grep -RL apple . (find word apple in all files with only file didn't match under the current directory)
grep apple fruits.* (find word apple in selected files)
ps aux | grep lingh
history | grep ls
history | grep pig | less
grep --color apple fruit.txt
export GREP_COLOR="34;47"
export GREP_OPTIONS="--color=auto"
grep --color=auto apple fruit.txt
```

### regular expression - basics
```bash
.  (wild card, any one character except line breaks, gre.t)
[] (character set, any one character listed inside [], gr[ea]y)
[^] (negative character set, any one character not listed inside [], [^aeiou])
\- (range indicator, when inside a character set, [A-Za-z0-9])
\* (Preceding element can occur zero or more times, files_*name)
\+ (Preceding element can occur one or more times, gro+ve)
? (Preceding element can occur zero or one time, colou?r)
| (Alernation, OR operator, jpg|gif|png)
^ (start of line anchor, ^Hello)
$ (End of line anchor, World$)
\ (Escape the next character (\+ is literal, + character), image\.jpg)
\d (any digit, 20\d\d-06-09)
\D (Anything not a digit ^\D+)
\w (any word character, alphanumeric + underscore, \w+_export\.sql)
\W (anything not a word character, \w+\W\w+)
\s (Whitespace, space, tab, line break, \w+\s\w+)
\S (Anything not whitespace, \S+\s\S+)
\#regular expression character classes
[:alpha:] (alphabetic characters)
[:digit:] (numeric characters)
[:alnum:] (alphanumeric characters)
[:lower:] (lower-case alphabetic characters)
[:upper:] (upper-case alphabetic characters)
[:punct:] (punctuation characters)
[:space:] (space characters, spce, tab, new line)
[:blank:] (whitespace character)
[:print:] (printable characters, including space)
[:graph:] (printabel characters, not including space)
[:cntrl:] (control characters, not printing)
[:xdigit:] (Hexadecimal characters 0-9, A-F, a-f)
grep 'apple' fruits.txt
grep 'a..le' fruits.txt (. is wildcard character for regular expression)
grep '.a.a' fruits.txt (return word by any character followed by 'a' and then any character followed by 'a')
grep 'ea[cp]' fruits.txt (return word by any character contain ea and followed by c or p)
grep '^a' fruits.txt (return word start of a)
grep 'le$' fruits.txt (return word end of le)
echo 'berry bush berry' | grep --color 'berry$'
echo 'ABcDdefg' | grep --color [:upper:]
echo 'ABcDdefg' | grep --color [[:upper:]] (look up character set make up of character class)
echo 'AB,Dd:fg' | grep --color [[:punct:]] (look up character set make up of punctuateion class)
grep 'ap*le' fruits.txt (two asterisks have different meanings)
grep 'ap+le' fruits.txt (literal + sign)
grep -e 'ap+le' fruits.txt (extended set)
```

### tr - translate characters
```bash
echo 'a,b,c' | tr ',' '-' (translate , to -)
echo '1435478956780' | tr '123456789' 'ABCDEFGHI' (position matched)
echo 'This is ROT-13 encrpted.' | tr 'A-Za-z' 'N-ZA-Mn-zaa-m'
echo 'Guve ve EBG-13 rapdbfrq.' | tr 'N-ZA-Mn-zaa-m' 'A-Za-z'
echo 'already daytime' | tr 'day' 'night'
tr 'A-Z' 'a-z' < fruits.txt (change from uppercase to lowercase)
tr '[:upper:]' '[:lower:]' < fruits.txt
tr ' ' '\t' < fruits.txt
\#tr: deleting and squeezing characters
\# -d delete characters in listed set
\# -s squeeze repeats in listed set
\# -c user complementatry set
\# -dc delete characters not in listed set
\# -sc squeeze characters not in listed set
echo 'abc123deee567f' | tr -d [:digit:] (delete digits)
echo 'abc123deee567f' | tr -dc [:digit:] (delete everythings except for digits)
echo 'abc12333333deee567f' | tr -s [:digit:] (squeeze digits)
echo 'abc123deee567f' | tr -sc [:digit:] (squeeze everything not digits)
echo 'abc123deee567f' | tr -ds [:digit:] [:alpha:] (delete digits and then squeeze letters)
echo 'abc123deee567f' | tr -dsc [:digit:] [:digit:] (-c only apply to delete -d)
tr -dc [:print:] < file1 > file2 (remove non-printable characters from file 1)
tr -d  '\015\031' < windows_file > unix_file (remove surplus carriage return and end of file character)
tr -s ' ' < file1 > file2 (remove double spaces from file1)
```

### sed - Stream Editor
```bash
sed 's/a/b/' - s:substitution, a:search string, b:replacement string
echo 'upstream' | sed 's/up/down/' (replace up with down)
echo 'upstream and upward' | sed 's/up/down/' (replace once)
echo 'upstream and upward' | sed 's/up/down/g' (replace globally)
echo 'upstream and upward' | sed 's|up|down|g' (delimiter can be / or | or :)
echo 'Mac OS X/Unix: awesome.' | sed 's|Mac OS X/Unix:|sed is |' (use backslash to escape forward slash)
sed 's/apple/mango/' fruits.txt (replace apple with mango first one each line, each line was treated as stream)
sed 's/apple/mango/g' fruits.txt (replace apple with mango globally)
echo 'During daytime we have sunlight.' | sed 's/day/night/'
echo 'During daytime we have sunlight.' | sed -e 's/day/night/' -e 's/sun/moon/' (add second command by -e, e stands for edits)
echo 'who needs vowels?' |sed 's/[aeiou]/_/g' (substitute aeiou using _)
echo 'who needs vowels?' |sed -E 's/[aeiou]+/_/g' (use extended features)
sed 's/^a/  A/g' fruits.txt (indent apple)
sed 's/^/>  /g' fruits.txt (indent everything)
sed 's/^/>(ctrl+v+Tab)/g' fruits.txt (indent using Tab)
sed -E 's/<[^<>]+>//g' homepage.html (take out html tags)
echo 'daytime' | sed 's/\(...)time/daylight/' (change ...time to daylight)
echo 'daytime' | sed -E 's/(...)time/\1daylight/' (extended replace and reused the matched word)
echo 'Dan Stevens' | sed -E 's/([A-Za-z]+) ([A-Za-z]+)/\2, \1/'(change the order of the first and second words)
```

### cut: Cutting select text portions
```bash
\#(-c characters, -b bytes, -f fields)
ls -lah | cut -c 2-10 (grab characters from 2 to 10)
echo '   4 lingh  users  '|wc
ls -lah | cut -c 2-10,32-37,53
history | grep 'fruit' | cut -c 10-
ps aux | grep 'lingh' | cut -c 66-
ps aux | grep 'lingh' | cut -f 1 (grab field 1)
cut -f 2,6 -d "," us_presidents.csv (grab fields 2, 6 by changing the delimiter as ,)
```

### diff: Comparing files
```bash
diff fruits.txt.output1 fruits.txt.output2 (original txt file typically first, c indicates change, a indicates append)
\# -i (case insensitive)
\# -b (ignore changes to blank characters)
\# -w (ignore all whitespace)
\# -B (ignore blank lines)
\# -r (recursively compare directories)
\# -s (show identical files)
\# -c (copied context)
\# -u (unified context)
\# -y (side-by-side)
\# -q (only whether files differ)

diff -c fruits.txt.output1 fruits.txt (show context difference, + added, ! changed, - deleted)
diff -y fruits.txt.output1 fruits.txt (side by side)
diff -u fruits.txt.output1 fruits.txt (unified comparison)
diff -q fruits.txt.output1 fruits.txt
diff -q fruits.txt.output1 fruits.txt  |
```

### xargs: passing argument lists to commands
```bash
wc fruits.txt
echo 'fruits.txt | wc
echo 'fruits.txt' | xargs -t wc (run and show running commands)
echo 'fruits.txt apple.txt' | xargs -t wc (run and show running commands)
echo 'fruits.txt apple.txt' | xargs -t -n1 wc (loop running commands with one arguments each time)
echo 1 2 3 4 | xargs -t -n2
head fruits.txt | xargs -L 2 (every head of two lines returned)
head fruits.txt | xargs -n 2 (every head of two words each line returned)
cat fruits.txt | xargs -I {} echo "buy more: {}" ({} indicates positions)
cat fruits.txt | xargs -I :FRUIT: echo "buy more: :FRUIT:" (define :FRUIT:)
cat fruits.txt | grep 'apple.*' | xargs -0 -n1
cat fruits.txt | sort | uniq | xargs -I {} mkdir ~lingh/{}
ps aux | grep 'lingh' | cut -c 10-15 | xargs kill -9 (kill all processes)
grep -l 'apple' *fruits.txt | xargs wc
grep -l 'apple' *fruits.txt | xargs wc
find ~lingh/ -type f -print0 | xargs -0 chmod 755 (-print0 make sure the null character is used to seperate them, -0 on xargs make sure the xargs uses the null characters)
find ~lingh/ "*fruits.txt" -print0 | xargs -0 -I {} cp {}  ~lingh/{}.backup
find  ~lingh/ -name "*.backup" -print0 | xargs -p -0 -n1 rm
```

### Creating an archive using tar command
```bash
tar cvf archive_name.tar dirname/
tar cvfj archive_name.tar.bz2 dirname/
\# z - filter the archive through gzip
\# j - filter the archive through bzip2
\# Extracting (untar) an archive using tar command
\#Extract a *.tar file using option xvf
tar xvf archive_name.tar
\#Extract a gzipped tar archive ( *.tar.gz ) using option xvzf
tar xvfz archive_name.tar.gz
\#Extracting a bzipped tar archive ( *.tar.bz2 ) using option xvjf
tar xvfj archive_name.tar.bz2
```
