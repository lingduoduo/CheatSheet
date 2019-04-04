
1 Introduction
---------------------------------
```
login4 09:43:28 ~ $ echo 'hello world';
hello world

login4 09:49:29 ~ $ echo -n 'hello world';
hello worldlogin4 09:53:31 ~ $

login4 09:54:58 ~ $ ls -lah
total 144
drwxr-xr-x     3 lingh  users   4.0K Sep 22 12:02 .
drwxr-xr-x  1887 root   wheel    80K Mar 11 05:09 ..
-rw-r--r--     1 lingh  users   235B Jul 11  2013 .bash_profile
-rw-r--r--     1 lingh  users   526B Jul 11  2013 .bashrc
-rw-------     1 lingh  users   4.9K Jul 11  2013 .fetchmailrc
drwxr-xr-x     2 lingh  users   4.0K Jul 11  2013 .ssh
-rw-------     1 lingh  users   470B Jul 11  2013 .xinitrc
-rw-------     1 lingh  users   177B Jul 11  2013 .xsession

ls              (显示当前目录下文件)
ls 目录名        (显示指定目录下文件)
ls -l           (长格式显示目录文件)
ls -l 文件名     (长格式显示指定文件)
ls -a           (显示所有文件(包含隐藏文件))
ls -al          (长格式显示当前目录下所有文件)
ls -h           (文件大小显示为常见大小单位 B KB MB ...)
ls -d           (显示目录本身，而不是里面的子文件)

login4 09:57:34 ~ $ cat -n apple.txt
     1  fruits.txt:apple
     2  fruits.txt:pipeapple
     3  fruits.txt:apple
     4  uniquefruits.txt:     1 apple
     5  uniquefruits.txt:     5 pipeapple
     
login4 09:57:41 ~ $ banner -w 20 'Hello World!'
/homes/lingh/.bashrc: 15 lines, 526 characters.

login3 09:39:38 ~ $ echo $SHELL
/usr/local/bin/bash
login3 09:39:49 ~ $ csh
%echo $0
csh
%bash

login3 09:47:25 ~ $ apropos banner
banner(6)                - print large banner on printer
login3 09:48:07 ~ $ apropos ban
banner(6)                - print large banner on printer
dummynet(4)              - traffic shaper, bandwidth manager and delay emulator
iicbb(4)                 - I2C generic bit-banging driver
lpbb(4)                  - parallel port I2C bit-banging interface
thread_exit(9)           - abandon current thread context

login3 09:48:20 ~ $ whatis banner
banner(6)                - print large banner on printer
```

2 File System Basics
---------------------------------

```
/ - root  根目录
/bin - Binaries, programs
/sbin - System binaries, sytem program
/dev - Devices: hard drives, keyboard, mouse, etc.  设备文件保存目录
/etc - system configurations  配置文件保存目录
/home - user home directories 普通用户的家目录
/lib - libraries of code 系统库保存目录
/tmp - temporary files 临时目录
/var - various, mostly files the system uses 系统相关文档内容
/var/log/         系统日志位置
/var/spool/mail/  系统默认邮箱位置
/var/lib/         默认安装的库文件目录
/usr - user programs, tools and libraries (not files) 系统软件资源目录
/usr/bin 命令保存目录（普通用户就可以读取的命令）
/usr/bin/         系统命令（普通用户）
/usr/sbin/        系统命令（超级用户）
/boot             启动目录，启动相关文件
/mnt              系统挂载目录
/media            挂载目录
/root             超级用户的家目录
/sbin             命令保存目录（超级用户才能使用的目录）
/proc             直接写入内存的
/sys              将内核的一些信息映射，可供应用程序所用

login3 10:42:38 ~ $ pwd
/homes/lingh

# parent's parent's directory
cd ../..
cd ..               进入上一级目录
# user directory
cd ~                进入当前用户的家目录
# toggle directory
cd -
cd -                进入上次目录
cd /usr/local/src   切换到指定路径(使用绝对路径方式)
cd .                进入当前目录
绝对路径：cd ../usr/local 参照当前所在目录，进行查找。一定要先确定当前所在目录。 相对路径：cd /usr/local 从根目录开始指定，一级一级递归查找。在任何目录下，都能进入指定位置。
```

3 Working with Files and Directories
---------------------------------
```
cd "Application Support"
cd Application\ Support

touch fruits.txt
vi fruits.txt

#small files
Cat fruits.txt
cat 文件名      查看文件内容内容
cat -n 文件名   查看文件内容，并列出行号

#large files
less -N fruits.txt
less -M fruits.txt

#large files
more 文件名    分屏显示文件内容
向上翻页  空格键
向下翻页  b键
退出查看  q键

#sample lines from files
head -1 fruits.txt
head 文件名           显示文件头几行(默认显示10行)
head -n 20 文件名     显示文件前20行
head -n -20 文件名    显示文件最后20行
ctrl + c             强制终止查看模式
ctrl + l             清屏

tail -1 fruits.txt
tail -f /var/log/apache2/error_log

#create directory
mkdir -p testdir/test1/test2 递归创建
mkdir -vp testdir/test1/test3

# ln - link
功能描述：链接文件,等同于Windows中的快捷方式
新建的链接，占用不同的硬盘位置
修改一个文件，两边都会改变
删除源文件，软连接文件打不开
ln -s 源文件 目标文件 创建链接文件(文件名都必须写绝对路径)

# remove empty directories
rmdir

#move files and directory
mv newfile.txt ../newfile.txt
mv newfile.txt ..
mv -nv overwrite1.txt overwrite2.txt (not overwriting)
mv -fv overwriete1.txt overwrite2.txt (overwriting)
mv -i overwrite1.txt overwrite2.txt (interactive overwriting)

#copy files and directories
cp newfile.txt newerfile.txt
cp -nv newfile.txt newerfile.txt (not overwriting)
cp -fv newfile.txt newerfile.txt (overwriting)
cp -i newfile.txt newerfile.txt (interactive overwriting)
cp -R test1 test1_copy_dir

#delete files and directories
rm 文件名 删除文件
rm somefile.txt
rmdir somedir
rm -r 目录名 递归删除文件和目录
rm -R somedir (delete files and directories recursively)
rm -f 文件名 强制删除
rm -rf 目录名 强制删除目录和文件

#finder aliases/links and symbolic links
ln fruits.txt hardlink (ln filetolink hardlink - reference a hard copy file in a file system)
ln -s fruits.txt symlink (ln -s filetolink symlink - reference a file path of directory path)

#search for files and directories
# (*) is zero or more characters(glob)
# (?) is any one character
# ([]) is any character in the brackets
find ~/Documents -name 'someimage.jpg' (find path expression)
find ~/Sites -name 'index.html'
find ~/Sites -name 'index.???'
find ~/Sites -name 'index.*'
find ~ -name *.plist
find ~ -name *.plist -and -not -path *QuickTime
find ~ -name *.plist -and -not -paht *QuickTime -and -not *Preference
find /homes/lingh/ -name '*.*'
-name 文件名      按照文件名查找
-user 用户名      按照属主用户名查找文件
-group 组名       按照属组组名查找文件
-nouser          找没有属主的文件 (除了这三个文件：/proc、/sys、/mnt/cdrom)
-size            按照文件大小k M  如：find / -size +50k
-type            按照文件类型查找(f=普通  d=目录  l=链接)
-perm            按照权限查找  如：find /root -perm 644
-iname           按照文件名查找，不区分大小写
```

4 Ownership and Permissions
---------------------------------
```
#who am I
whoami
cd ~

#Unix group
group
chown lingh:users fruits.txt
chown -R lingh:users fruits (change all files ownership in a dir)
sudo chown user1:users ownership.txt

# group categories (user, group, other)
# permission read(r-4), write(w-2), execute(x-1)
# user(rwx), group(rw-), other(r--)
权限位是十位
    第一位：代表文件类型
    -   普通文件
    d   目录文件
    l   链接文件
    其他九位：代表各用户的权限
    (前三位=属主权限u  中间三位=属组权限g  其他人权限o)
    r   读   4 , 读取文件内容 如：cat、more、head、tail; 可以查询目录下文件名 如：ls
    w   写   2 , 编辑、新增、修改文件内容 如：vi、echo 但是不包含删除文件; 具有修改目录结构的权限 如：touch、rm、mv、cp
    x   执行  1, 可执行  /tmp/11/22/abc; 可以进入目录 如：cd
chmod mode filename
chmod ugo=rwx filename
chmod u=rwx,g=rw,o=r filename
chmod ug+w filename
chmod o-w filename
chmod ugo+rw filename
chmod a+rw filename
chmod -R g+w testdir
chmod u+x aa      aa文件的属主加上执行权限
chmod u-x aa      aa文件的属主减去执行权限
chmod g+w,o+w aa  aa文件的属组和其他人加上写权限
chmod u=rwx aa    aa文件的用户权限改为所有权限(读+写+执行)

chmod 777 filename (all permissions)
chmod 764 filename (rwx+rw+r)
chmod 755 filename (rwx+rx+rx)
chmod 700 filename (rwx+ + )
chmod 000 filename (no permission)
chmod 755 aa      aa文件的属主权限是rwx，属组和其他人是rx
chmod 644 aa      aa文件的属主权限是rw，属组和其他人是r

# root user
sudo ls -lla
sudo chown lingh file.txt
chown 用户名 文件名      改变文件属主
chown user1 aa         user1必须存在
chown user1:user1 aa   改变属主同时改变属组
```

5 Commands and Programs
---------------------------------
```
#show command path
whereis echo
which echo
whatis echo
echo $PATH

#computer system set up
date
uptime
#dedupe nodedupe login users
users
who
#system running on info
uname
uname -mnrsvp
hostname
domainname

#disk free space
df
df -h
df -H
#disk usage - allocation of hard disk
du
du ~
du -h ~/ (only directory)
du -ah ~/ (all files and directories)
du -hd 1 ~/ (go to directory with one deep)
du -hd 0 ~/ (only current directory)

#viewing processes
ps (process status)
ps -a
ps aux (a: all processes, u: column showing th eprocess user, x show the background processes)
ps aux | grep lingh
top
top -n 10 (top 10 processes)
top -n 10 -o cpu -s 3 -U lingh (top 10 processes of lingh, sorted by CPU, refress every 3 seconds)

#Stopping processes
kill pid
kill -9 pid (force to kill the process id)

#Text File Helpers
wc (word count)
login3 13:13:28 ~ $ wc fruits.txt
      25      22     156 fruits.txt (25 lines, 22 words per line, total 156 words)
sort (sort lines)
sort fruits.txt
sort -f fruits.txt (mix upper case letters and lowercase letters)
sort -r fruits.txt (reverse sort)
sort -u fruits.txt (sorted and unique)
unique (filter in/out repeated lines)
uniq fruits.txt
uniq -d fruits.txt (duplicate lines)
uniq -u fruits.txt (unduplicate lines)

#Utility programs
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
        * 0.3048
        / 3.2808399
        
#Command history
#!3 - references history command #3
#!-2 - references command withich was 2 commands-back
#!cat - references most recent command beginning with "cat"
#!! - references previous command
#!$ - references previous command's arguements
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

6 Directing Input and Output
---------------------------------
```
#Standard input -stdin, keyboard, /dev/stdin
#standard output -stdout, text terminal /dev/stdout
sort fruits.txt > sortedfruits.txt
unique sortedfruits.txt > uniquefruits.txt
cat apple.txt apple2.txt > applecat.txt
echo 'fruits.txt' >> apple.txt (appended to the file)
#Directing input form a file
sort < fruits.txt
sort < fruits.txt > sortedfruits.txt
#Piping output to input
echo "HELLO WORLD" | wc
echo "(3+4)*9" | bc
cat fruits.txt | sort 
cat fruits.txt | sort | uniq
sort < fruits.txt | uniq  > uniquefruits.txt
ps aux | less
#Suppressing output
#/dev/null - 'null device', 'bit bucket', 'black hold'
#similar to special files /dev/stdin and /dev/stdout, unix discards any data sent there
ls -lah > /dev/null
```

7 Configuring Your Working Environment
---------------------------------
When you login (type username and password) via Terminal, either sitting at the machine, or remotely via ssh,
.bash_profile is executed to configure your shell before the initial command prompt.

If you've already logged into your machine and open a new terminal window (xterm) inside a client other than Mac OSX Terminal, then .bashrc is executed before the window command prompt.
```
#Upon login to a bash shell - This only runs on user login
#/etc/profile - system configurations with master default commands
#~/.bash_profile, ~/.bash_login, ~/.profile, ~/.login
#Add to ~/.bash_profile and then put all shell configuration in ~/.bashrc
if [ -f ~/.bashrc ]; then
source ~/.bashrc
fi

#Upon starting a new bash subshell - This loads in the configuration .bashrc, put all configuration there.
#~/.bashrc (typein shell and open sub-shell using other resources)
source .bashrc (run .bashrc file)

#Upon logging out of bash shell
#~/.bash_logout

#Setting command aliases 
alias
alias lah='ls -lah' (define a new aliase)
unalias lah (delete an aliase)

#Setting environment variables
echo USER=lingh (define a variable in bash)
expot echo (every time Unix launches a program, it'll make the variable available)

#Setting PATH variables
#PATH is a colon delimited list of file paths that Unix uses when it's trying to locate a command that you want it to run.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#Configurign history with variables
export HISTSIZE=1000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%b %d %I:%M %p       '
export HISTCONTROL=ignoreboth (ignore dups and ignore space)
export HISTIGNORE="history:pwd:ls -lah:exit" (ignore commands in the history)

#Customizing the command prompt with format codes
#\u - username
#\s - current shell
#\w - current working directory
#\W - basename of current working directory
#\d - date in 'weekday month date' format 
#\D{format} - date in strftime format {"%Y-%m-%d"}
#\A time in 24-hour HH:MM format
#\t time in 24-hour HH:MM:SS format
#\@ time in 12-hour HH:MM am/pm format
#\T time in 12-hour HH:MM:SS format
#\H hostname
#\h hostname up to first "."
#|! history number of this command
#\$ when UID is 0 (root), a "#", otherwise a "$"
#\\ a literal backslash
PS1='--> ' (change the main command prompt)
PS1="\h:\W\u$'
```

8 Unix Power Tools 
---------------------------------------------
```
# grep - global regular expression print
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
grep -i "root" /etc/passwd
    -v       反向选择
    -i       忽略大小写
管道符 |
命令1 | 命令2                 命令1的执行结果，作为命令2的执行条件
cat 文件名 | grep '字串'      提取含有字符串的行
ls -l /etc | more           分屏显示ls内容

# regular expression - basics
.  (wild card, any one character except line breaks, gre.t)
[] (character set, any one character listed inside [], gr[ea]y)
[^] (negative character set, any one character not listed inside [], [^aeiou])
- (range indicator, when inside a character set, [A-Za-z0-9])
* (Preceding element can occur zero or more times, files_*name)
+ (Preceding element can occur one or more times, gro+ve)
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
#regular expression character classes
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

#tr - translate characters
echo 'a,b,c' | tr ',' '-' (translate , to -)
echo '1435478956780' | tr '123456789' 'ABCDEFGHI' (position matched)
echo 'This is ROT-13 encrpted.' | tr 'A-Za-z' 'N-ZA-Mn-zaa-m'
echo 'Guve ve EBG-13 rapdbfrq.' | tr 'N-ZA-Mn-zaa-m' 'A-Za-z'
echo 'already daytime' | tr 'day' 'night'
tr 'A-Z' 'a-z' < fruits.txt (change from uppercase to lowercase)
tr '[:upper:]' '[:lower:]' < fruits.txt
tr ' ' '\t' < fruits.txt
#tr: deleting and squeezing characters
# -d delete characters in listed set
# -s squeeze repeats in listed set
# -c user complementatry set 
# -dc delete characters not in listed set
# -sc squeeze characters not in listed set
echo 'abc123deee567f' | tr -d [:digit:] (delete digits)
echo 'abc123deee567f' | tr -dc [:digit:] (delete everythings except for digits)
echo 'abc12333333deee567f' | tr -s [:digit:] (squeeze digits)
echo 'abc123deee567f' | tr -sc [:digit:] (squeeze everything not digits)
echo 'abc123deee567f' | tr -ds [:digit:] [:alpha:] (delete digits and then squeeze letters)
echo 'abc123deee567f' | tr -dsc [:digit:] [:digit:] (-c only apply to delete -d)
tr -dc [:print:] < file1 > file2 (remove non-printable characters from file 1)
tr -d  '\015\031' < windows_file > unix_file (remove surplus carriage return and end of file character)
tr -s ' ' < file1 > file2 (remove double spaces from file1)

#sed - Stream Editor
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

#cut: Cutting select text portions 
#(-c characters, -b bytes, -f fields)
ls -lah | cut -c 2-10 (grab characters from 2 to 10)
echo '     4 lingh  users   '|wc
ls -lah | cut -c 2-10,32-37,53 
history | grep 'fruit' | cut -c 10-
ps aux | grep 'lingh' | cut -c 66-
ps aux | grep 'lingh' | cut -f 1 (grab field 1)
cut -f 2,6 -d "," us_presidents.csv (grab fields 2, 6 by changing the delimiter as ,)

#diff: Comparing files
diff fruits.txt.output1 fruits.txt.output2 (original txt file typically first, c indicates change, a indicates append)
# -i (case insensitive)
# -b (ignore changes to blank characters)
# -w (ignore all whitespace)
# -B (ignore blank lines)
# -r (recursively compare directories)
# -s (show identical files)
# -c (copied context)
# -u (unified context)
# -y (side-by-side)
# -q (only whether files differ)

diff -c fruits.txt.output1 fruits.txt (show context difference, + added, ! changed, - deleted)
diff -y fruits.txt.output1 fruits.txt (side by side)
diff -u fruits.txt.output1 fruits.txt (unified comparison)
diff -q fruits.txt.output1 fruits.txt 
diff -q fruits.txt.output1 fruits.txt  | 

#xargs: passing argument lists to commands
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

```
# Creating an archive using tar command
tar cvf archive_name.tar dirname/
tar cvfj archive_name.tar.bz2 dirname/
tar -zcvf 压缩文件名 源文件
tar -zcvf aa.tar.gz aa
    -z       识别.gz格式 filter the archive through gzip
    -c       压缩
    -v       显示压缩过程
    -f       指定压缩包名
    -j       filter the archive through bzip2
tar  -zxvf  压缩文件名   解压缩同时解打包
tar -jcvf 压缩文件名 源文件      压缩同时打包
tar -jcvf aa.tar.bz2 aa  
tar -jxvf aa.tar.bz2          解打包同时解压缩

# Extracting (untar) an archive using tar command 查看不解包
#Extract a *.tar file using option xvf
tar xvf archive_name.tar
#Extract a gzipped tar archive ( *.tar.gz ) using option xvzf
tar xvfz archive_name.tar.gz
#Extracting a bzipped tar archive ( *.tar.bz2 ) using option xvjf
tar xvfj archive_name.tar.bz2
tar -ztvf aa.tar.gz           查看不解压
tar -jtvf aa.tar.bz2
    -t  只查看，不解压
tar -jxvf root.tar.bz2 -C /tmp/      指定解压缩位置
```
