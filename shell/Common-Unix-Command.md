### Common Unix Command

-Basics

```
echo 'hello world';
$ echo $SHELL
/usr/local/bin/bash
```

-Change directory

```
pwd ( print current working directory)
cd . (working directory)
cd .. ( parent of the current working directory)
cd -  返回上次所在的目录
```

-Who am I

```
whoami
cd ~
```

-Explore commands

```
apropos banner
whatis banner
banner -w 20 'Hello World!'
```

-List File

```
ls (list directory)
ls -a (short option - all files including hidden files)
ls -all (long option - all files including hidden files)
ls -a -l (all files and details)
ls -al
ls -alh
```

-Edit with Vim

```
touch fruit.txt
vi fruits.txt
```

In command mode

```
‘h’ -> left
‘j’ -> down
‘k’ -> up
‘l’ -> right
‘b’ -> go back one word
‘w’ -> go forward one word
```

In insert mode, literal text can be inserted

```
:w in command mode
:q quit vim in command mode
:q! in command mode after discarding change
```

-Concatenate short files

```
cat file1.txt
cat -n file1.txt
cat file1.txt file2.txt

```

-Show long files

```
less -N file1.txt
less -M file1.txt

```

-Sample files: the first or the last records

```
head -10 raw_data.txt > first_10_records.txt
head $testfile -n 50000 > sample.csv
head bankstatement.txt (show first 10 lines)
head -n 15 bankstatement.txt
tail -10 rwa-data.txt > last-10_records.txt
tail bankstatement.txt (show last 10 lines)
tail -n 15 bankstatement.txt
tail -f /var/log/apache2/error_log (trace all new lines from tail of files)

```

-Create Directory

```
mkdir newdir 
mkdir -p newdir/newsubdir/newsubsubdir (create all parent directory if needed)
mkdir -vp newdir/test1/test2 (create directory with feedbacks) 

```

-Copy File

```
cp source destination
cp filename1 filename2
cp -nv overwrite1.txt overwrite2.txt (not overwriting)
cp -fv overwrite1.txt overwrite2.txt (overwriting)
cp -i overwrite1.txt overwrite2.txt (interactive overwriting)
cp -R test1 tet_copy_dir

```

-Move File

```
mv oldname newname
mv dir1 dir2
mv newfile.txt ../newfile.txt
mv newfile.txt ..
mv -nv overwrite1.txt overwrite2.txt (not overwriting)
mv -fv overwrite1.txt overwrite2.txt (overwriting)
mv -i overwrite1.txt overwrite2.txt (interactive overwriting)

```

-Remove File

```
rm filename
rm filename1
rm -rf filename/dirname
rm -R somedir(delete files and directories recersively)
```

-Finder aliases/links and symbolic links

```
ln fruits.txt hardlink
ln filetolink hardlink 
- reference a hard copy file in a file system)

ln -s fruits.txt symlink 
ln -s filetolink symlink 
- reference a file path of directory path
```

-Search for files and directories
\# (*) is zero or more characters(glob)
\# (?) is any one character
\# ([]) is any character in the brackets

```
find ~/Documents -name 'someimage.jpg' (find path expression)
find ~/Sites -name 'index.html'
find ~/Sites -name 'index.???'
find ~/Sites -name 'index.*'
find ~ -name *.plist
find ~ -name *.plist -and -not -path *QuickTime
find ~ -name *.plist -and -not -paht *QuickTime -and -not *Preference
find /homes/lingh/ -name '*.*'
find / -name file1 从 '/' 开始进入根文件系统搜索文件和目录
find / -user user1 搜索属于用户 'user1' 的文件和目录
find /usr/bin -type f -atime +100 搜索在过去100天内未被使用过的执行文件
find /usr/bin -type f -mtime -10 搜索在10天内被创建或者修改过的文件
whereis halt 显示一个二进制文件、源码或man的位置
which halt 显示一个二进制文件或可执行文件的完整路径
```

-Change ownership

```
group
chown lingh:users fruits.txt
chown -R lingh:users fruits (change all files ownership in a dir)
sudo chown user1:users ownership.txt
```

-Change permissions

```
\# group categories (user, group, other)
\# permission read(r-4), write(w-2), execute(x-1)
\# user(rwx), group(rw-), other(r--)
\#change mode filename - chmod mode filename
\#alpha notation
chmod g+w
chmod u+x file.sh (change permissions of the file for users adding executable)
chmod go-rwx file.txt
chmod o+w file.txt
chmod ugo=rwx filename
chmod u=rwx,g=rw,o=r filename
chmod ug+w filename
chmod o-w filename
chmod ugo+rw filename
chmod a+rw filename
chmod -R g+w testdir
\#octal notationchmod 777 filename (all permissions)
chmod 764 filename (rwx+rw+r)
chmod 755 filename (rwx+rx+rx)
chmod 700 filename (rwx+ + )
chmod 000 filename (no permission)
```

-root user and sudo

```
sudo ls -la
sudo chown lingh file.txt
```

-System command
\#show command path

```
whereis echo
which echo
whatis echo
echo $PATH
```

\#computer system set up

```
date
uptime
\#dedupe nodedupe login users
users (dedupe user different logins)
who (nodedupe user different logins)
```

\#system running on info

```
uname
uname -mnrsvp
hostname
domainname
```

-Disk Information
\#disk free space

```
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
```

-Process control command
\#viewing processes

```
ps (process status)

用于将某个时间点的进程运行情况选取下来并输出，process之意：
-A ：所有的进程均显示出来
-a ：不与terminal有关的所有进程
-u ：有效用户的相关进程
-x ：一般与a参数一起使用，可列出较完整的信息
-l ：较长，较详细地将PID的信息列出

ps aux # 查看系统所有的进程数据
ps ax # 查看不与terminal有关的所有进程
ps -lA # 查看系统所有的进程数据
ps axjf # 查看连同一部分进程树状态

ps -a
ps aux (a: all processes, u: column showing th eprocess user, x show the background processes)
ps aux | grep lingh

top
top -n 10 (top 10 processes)
top -n 10 -o cpu -s 3 -U lingh (top 10 processes of lingh, sorted by CPU, refress every 3 seconds)

jps(Java Virtual Machine Process Status Tool)是JDK 1.5提供的一个显示当前所有java进程pid的命令，简单实用，非常适合在linux/unix平台上简单察看当前java进程的一些简单情况。

netstat -tunlp|grep 端口号
```

\#Stopping processes

```
kill pid
kill -9 pid (force to kill the process id)
kill %2 (terminate a background job 2)

kill -9 pid  （-9表示强制关闭）
killall -9 程序的名字
pkill 程序的名字
```

-Text File Helpers

```
wc (word count)
wc fruits.txt
   25    22   156 fruits.txt (25 lines, 22 words per line, total 156 words)
wc -l myfile.txt (count lines)

sort (sort lines)
sort fruits.txt
sort -f fruits.txt (mix upper case letters and lowercase letters)
sort -r fruits.txt (reverse sort)
sort -u fruits.txt (sorted and unique)
sort file1 file2 排序两个文件的内容
sort file1 file2 | uniq 取出两个文件的并集(重复的行只保留一份)
sort file1 file2 | uniq -u 删除交集，留下其他的行
sort file1 file2 | uniq -d 取出两个文件的交集(只留下同时存在于两个文件中的文件)

unique (filter in/out repeated lines)
uniq fruits.txt
uniq -d fruits.txt (duplicate lines)
uniq -u fruits.txt (unduplicate lines)

paste file1 file2 合并两个文件或两栏的内容
paste -d '+' file1 file2 合并两个文件或两栏的内容，中间用"+"区分

comm -1 file1 file2 比较两个文件的内容只删除 'file1' 所包含的内容
comm -2 file1 file2 比较两个文件的内容只删除 'file2' 所包含的内容
comm -3 file1 file2 比较两个文件的内容只删除两个文件共有的部分
```

-Utility programs
\#cal/ncal (calendar)

```
cal
cal 12 20013
cal -y 2014
\#bc (bench calculator)
scale =100
q00/9
quit
echo "(3+4)*9" | bc
\#expr (expression evaluator)
expr 1 + 1
expr 1122 \* 3344
\#units (unit conversion)
units
586 units, 56 prefixes
You have: 1 foot
You want: meters
    \* 0.3048
    / 3.2808399

```

 -Show all commands run before 

 ```
cat .bash_history
history (shows all commands run before)
history -a
history -n (read all history lines not already read)
history -d 10 (delete the 10th line of history)
history -c (clean all history)


 ```

-Command history

```
\#!3 - references history command #3
\#!-2 - references command withich was 2 commands-back
\#!cat - references most recent command beginning with "cat"
\#!! - references previous command
\#!$ - references previous command's arguements
!1 (run 1st line of command in the history)
!-5 (run a command that was five commands ago)
!expr (most recent command that began with expr)
!! (edit lines and re-execute)
chown lingh fruit.txt
sudo !! (that is, sudo chown lingh fruit.txt)
cat fruits.txt
less !$ (run the command with the arguments fromt the previous command)


```

- Directing Input and Output
  \#Standard input -stdin, keyboard, /dev/stdin
  \#standard output -stdout, text terminal /dev/stdout

```
sort fruits.txt > sortedfruits.txt
unique sortedfruits.txt > uniquefruits.txt
cat apple.txt apple2.txt > applecat.txt
echo 'fruits.txt' >> apple.txt (appended to the file)


```

\#Directing input from a file

```
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

-Configuring Your Working Environment

- When you login (type username and password) via Terminal, either sitting at the machine, or remotely via ssh, .bash_profile is executed to configure your shell before the initial command prompt.

- If you’ve already logged into your machine and open a new terminal window (xterm) inside a client other than Mac OSX Terminal, then .bashrc is executed before the window command prompt.
  \#Upon login to a bash shell - This only runs on user login

- /etc/profile - system configurations with master default commands

\#~/.bash_profile, ~/.bash_login, ~/.profile, ~/.login

  Add to ~/.bash_profile and then put all shell configuration in ~/.bashrc

```
if [ -f ~/.bashrc ]; then
source ~/.bashrc
fi
\#Upon starting a new bash subshell - This loads in the configuration .bashrc, put all configuration there.
\#~/.bashrc (typein shell and open sub-shell using other resources)
\#Upon logging out of bash shell
\#~/.bash_logout
echo 'see ya later'
```

-Setting command aliases 

```
alias
alias lah='ls -lah' (define a new aliase)
unalias lah (delete an aliase)
```

-Setting environment variables

```
echo USER=username (define a variable in bash)
expot echo (every time Unix launches a program, it'll make the variable available)

-Setting PATH variables
\#PATH is a colon delimited list of file paths that Unix uses when it's trying to locate a command that you want it to run.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export testfile=myfile.csv


\#Configurign history with variables
export HISTSIZE=1000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%b %d %I:%M %p    '
export HISTCONTROL=ignoreboth (ignore dups and ignore space)
export HISTIGNORE="history:pwd:ls -lah:exit" (ignore commands in the history)
```

\#Customizing the command prompt with format codes

```#\u - username
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

-Finding Text Strings
\# grep stands for global regular expression print

```
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

grep Aug /var/log/messages  在文件 '/var/log/messages'中查找关键词"Aug"
grep ^Aug /var/log/messages 在文件 '/var/log/messages'中查找以"Aug"开始的词汇
grep [0-9] /var/log/messages 选择 '/var/log/messages' 文件中所有包含数字的行
grep Aug -R /var/log/* 在目录 '/var/log' 及随后的目录中搜索字符串"Aug"
sed 's/stringa1/stringa2/g' example.txt 将example.txt文件中的 "string1" 替换成 "string2"
sed '/^$/d' example.txt 从example.txt文件中删除所有空白行（搜索公众号Java知音，回复“2021”，送你一份Java面试题宝典）
```

\#regular expression basics

```
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

\#Translate characters

```
echo 'a,b,c' | tr ',' '-' (translate , to -)
echo '1435478956780' | tr '123456789' 'ABCDEFGHI' (position matched)
echo 'This is ROT-13 encrpted.' | tr 'A-Za-z' 'N-ZA-Mn-zaa-m'
echo 'Guve ve EBG-13 rapdbfrq.' | tr 'N-ZA-Mn-zaa-m' 'A-Za-z'
echo 'already daytime' | tr 'day' 'night'
tr 'A-Z' 'a-z' < fruits.txt (change from uppercase to lowercase)
tr '[:upper:]' '[:lower:]' < fruits.txt
tr ' ' '\t' < fruits.txt

```

- tr: deleting and squeezing characters
  - -d delete characters in listed set
  - -s squeeze repeats in listed set
  - -c user complementatry set
  - -dc delete characters not in listed set
  - -sc squeeze characters not in listed set

```
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

\#sed - Stream Editor

```
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

\#cut: Cutting select text portions
\#(-c characters, -b bytes, -f fields)

```
ls -lah | cut -c 2-10 (grab characters from 2 to 10)
echo '   4 lingh  users  '|wc
ls -lah | cut -c 2-10,32-37,53
history | grep 'fruit' | cut -c 10-
ps aux | grep 'lingh' | cut -c 66-
ps aux | grep 'lingh' | cut -f 1 (grab field 1)
cut -f 2,6 -d "," us_presidents.csv (grab fields 2, 6 by changing the delimiter as ,)
```

\#diff: Comparing files
diff fruits.txt.output1 fruits.txt.output2 (original txt file typically first, c indicates change, a indicates append)

- -i (case insensitive)
- -b (ignore changes to blank characters)
- -w (ignore all whitespace)
- -B (ignore blank lines)
- -r (recursively compare directories)
- -s (show identical files)
- -c (copied context)
- -u (unified context)
- -y (side-by-side)
- -q (only whether files differ)

```
diff -c fruits.txt.output1 fruits.txt (show context difference, + added, ! changed, - deleted)
diff -y fruits.txt.output1 fruits.txt (side by side)
diff -u fruits.txt.output1 fruits.txt (unified comparison)
diff -q fruits.txt.output1 fruits.txt
diff -q fruits.txt.output1 fruits.txt  | mate
```

\#xargs: passing argument lists to commands

```
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

-Zip and Unzip Files

```
gzip bigfile.dat (zip file)
gunzip bigfile.data.gz (unzip file)
```

-Create and Extract tar files

```
tar -cvf homebackup.tar /home/user
tar -czvf homebackup.tar.gz /home/user
tar -xvf homebackup.tar
tar -xzvf homebackup.tar.gz

对文件进行打包，默认情况并不会压缩，如果指定了相应的参数，它还会调用相应的压缩程序（如gzip和bzip等）进行压缩和解压：
-c ：新建打包文件
-t ：查看打包文件的内容含有哪些文件名
-x ：解打包或解压缩的功能，可以搭配-C（大写）指定解压的目录，注意-c,-t,-x不能同时出现在同一条命令中
-j ：通过bzip2的支持进行压缩/解压缩
-z ：通过gzip的支持进行压缩/解压缩
-v ：在压缩/解压缩过程中，将正在处理的文件名显示出来
-f filename ：filename为要处理的文件
-C dir ：指定压缩/解压缩的目录dir
压缩：tar -jcv -f filename.tar.bz2 要被处理的文件或目录名称
查询：tar -jtv -f filename.tar.bz2
解压：tar -jxv -f filename.tar.bz2 -C 欲解压缩的目录

bunzip2 file1.bz2 解压一个叫做 'file1.bz2'的文件
bzip2 file1 压缩一个叫做 'file1' 的文件
gunzip file1.gz 解压一个叫做 'file1.gz'的文件
gzip file1 压缩一个叫做 'file1'的文件
gzip -9 file1 最大程度压缩
rar a file1.rar test_file 创建一个叫做 'file1.rar' 的包
rar a file1.rar file1 file2 dir1 同时压缩 'file1', 'file2' 以及目录 'dir1'
rar x file1.rar 解压rar包
zip file1.zip file1 创建一个zip格式的压缩包
unzip file1.zip 解压一个zip格式压缩包
zip -r file1.zip file1 file2 dir1 将几个文件和目录同时压缩成一个zip格式的压缩包
```

\- Job Contrl
ctrl + c (terminate a running command)
command & (run a command in the background)
jobs (list all running jobs)

```
fg %2 (bring second job background job to foreground)
ctrl+z (suspend a foreground running command)
bg %2 (resume job 2 suspended the background)
```

-Screen

```
screen -list
screen -r
screen -S XXX -X quit
Ctrl-a c   Create new window (shell)
Ctrl-a k   Kill the current window
Ctrl-a w   List all windows (the current window is marked with "*")
Ctrl-a 0-9   Go to a window numbered 0-9
Ctrl-a n   Go to the next window
Ctrl-a Ctrl-a   Toggle between the current and previous window
Ctrl-a [   Start copy mode
Ctrl-a ]   Paste copied text
Ctrl-a ?   Help (display a list of commands)
Ctrl-a Ctrl-\   Quit screen
Ctrl-a D (Shift-d)   Power detach and logout
Ctrl-a d   Detach but keep shell window open
```

-Examples

```
file image01.jpg
locate workreport.doc
exit (exit the console) 
exit 1 (exit with states)
info coreutils
ctrl + r (incremental search in history)
env (print env variables)
```

-Shutdoen

```
shutdown -h now 关闭系统(1)
init 0 关闭系统(2)
telinit 0 关闭系统(3)
shutdown -h hours:minutes & 按预定时间关闭系统
shutdown -c 取消按预定时间关闭系统
shutdown -r now 重启(1)
reboot 重启(2)
logout 注销
time 测算一个命令（即程序）的执行时间
```
