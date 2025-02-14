1.查找文件

```
find / -name filename.txt
```

根据名称查找/目录下的filename.txt文件。

2.查看一个程序是否运行

```
ps –ef|grep tomcat
```

查看所有有关tomcat的进程

3.终止线程

```
kill -9 19979
```

终止线程号位19979的线程

4.查看文件，包含隐藏文件

```
ls -al
```

5.当前工作目录

```
pwd
```

6.复制文件包括其子文件到自定目录

```
cp -r sourceFolder targetFolder
```

7.创建目录

```
mkdir newfolder
```

8.删除目录（此目录是空目录）

```
rmdir deleteEmptyFolder
```

9.删除文件包括其子文件

```
rm -rf deleteFile
```

10.移动文件

```
mv /temp/movefile /targetFolder
```

扩展重命名 mv oldNameFile newNameFile

11.切换用户

```
su -username
```

12.修改文件权限

```
chmod 777 file.java
//file.java的权限-rwxrwxrwx，r表示读、w表示写、x表示可执行
```

13.压缩文件

```
tar -czf test.tar.gz /test1 /test2
```

14.列出压缩文件列表

```
tar -tzf test.tar.gz
```

15.解压文件

```
tar -xvzf test.tar.gz
```

16.查看文件头10行

```
head -n 10 example.txt
```

17.查看文件尾10行

```
tail -n 10 example.txt
```

18.查看日志文件

```
tail -f exmaple.log
//这个命令会自动显示新增内容，屏幕只显示10行内容的（可设置）。
```

19.启动Vi编辑器

```
vi
```

20.查看系统当前时间

```
date
```

命令会输出 周几 几月 几日 时间 和 时间显示格式 和年份

Sat Jan 20 04:39:49 CST 2018

```
date +"%Y-%m-%d"
```

显示如下：

```
root@ming xxx]# date +"%Y-%m-%d" 2018-01-20
```

21.解压zip 文件

```
unzip -oq
```

22.查看线程个数（方便查看程序是否有误）

```
ps -Lf 端口号|wc -l
```

### 收藏 40 个命令

**1 删除0字节文件**

```
find -type f -size 0 -exec rm -rf {} \;
```

**2 查看进程**

按内存从大到小排列

```
PS -e -o "%C : %p : %z : %a"|sort -k5 -nr
```

**3 按 CPU 利用率从大到小排列**

```
ps -e -o "%C : %p : %z : %a"|sort -nr
```

**4 打印 cache 里的URL**

```
grep -r -a jpg /data/cache/* | strings | grep "http:" | awk -F'http:' '{print "http:"$2;}'
```

**5 查看 http 的并发请求数及其 TCP 连接状态：**

```
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
```

6 `sed -i '/Root/s/no/yes/' /etc/ssh/sshd_config` sed 在这个文里 Root 的一行，匹配 Root 一行，将 no 替换成 yes。

**7 如何杀掉 MySQL 进程**

```
ps aux |grep mysql |grep -v grep  |awk '{print $2}' |xargs kill -9 (从中了解到awk的用途)
killall -TERM mysqld
kill -9 `cat /usr/local/apache2/logs/httpd.pid`   试试查杀进程PID
```

**8 显示运行 3 级别开启的服务:**

```
ls /etc/rc3.d/S* |cut -c 15-   (从中了解到cut的用途，截取数据)
```

**9 如何在编写 SHELL 显示多个信息，用 EOF**

```
cat << EOF+--------------------------------------------------------------+|       === Welcome to Tunoff services ===                |+--------------------------------------------------------------+EOF
```

**10 for 的巧用（如给 MySQL 建软链接）**

```
cd /usr/local/mysql/binfor i in *do ln /usr/local/mysql/bin/$i /usr/bin/$idone
```

**11 取 IP 地址**

```
ifconfig eth0 |grep "inet addr:" |awk '{print $2}'| cut -c 6-  
或者
ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'

ipconfig getifaddr en0
curl ifconfig.me
```

**12** 内存的大小:

```
free -m |grep "Mem" | awk '{print $2}'
```

**13**

```
netstat -an -t | grep ":80" | grep ESTABLISHED | awk '{printf "%s %s\n",$5,$6}' | sort
```

**14** 查看 Apache 的并发请求数及其 TCP 连接状态：

```
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
```

**15** 因为同事要统计一下服务器下面所有的 jpg 的文件的大小，写了个 SHELL 给他来统计。原来用 xargs 实现，但他一次处理一部分。搞的有多个总和……，下面的命令就能解决。

```
find / -name *.jpg -exec wc -c {} \;|awk '{print $1}'|awk '{a+=$1}END{print a}'
```

CPU 的数量（多核算多个CPU，`cat /proc/cpuinfo |grep -c processor`）越多，系统负载越低，每秒能处理的请求数也越多。

16 CPU负载

```
cat /proc/loadavg
```

检查前三个输出值是否超过了系统逻辑 CPU 的4倍。

17 CPU负载

```
mpstat 1 1
```

检查 %idle 是否过低（比如小于5%）。

18 内存空间

```
free
```

检查 free 值是否过低，也可以用 `# cat /proc/meminfo`

19 SWAP 空间  

```
free
```

检查 swap used 值是否过高，如果 swap used 值过高，进一步检查 swap 动作是否频繁：

```
vmstat 1 5
```

观察 si 和 so 值是否较大

20 磁盘空间  

```
df -h
```

检查是否有分区使用率（Use%）过高（比如超过90%）如发现某个分区空间接近用尽，可以进入该分区的挂载点，用以下命令找出占用空间最多的文件或目录：

```
du -cks * | sort -rn | head -n 10
```

21 磁盘 I/O 负载

```
iostat -x 1 2
```

检查I/O使用率（%util）是否超过 100%

22 网络负载

```
sar -n DEV
```

检查网络流量（rxbyt/s, txbyt/s）是否过高

23 网络错误

```
netstat -i
```

检查是否有网络错误（drop fifo colls carrier），也可以用命令：# cat /proc/net/dev

24 网络连接数目

```
netstat -an | grep -E “^(tcp)” | cut -c 68- | sort | uniq -c | sort -n
```

25 进程总数  

```
ps aux | wc -l
```

检查进程个数是否正常 (比如超过250)

26 可运行进程数目  

```
vmwtat 1 5
```

列给出的是可运行进程的数目，检查其是否超过系统逻辑 CPU 的 4 倍

27 进程  

```
top -id 1
```

观察是否有异常进程出现。

28 网络状态，检查DNS，网关等是否可以正常连通

29 用户

```
who | wc -l
```

检查登录用户是否过多 (比如超过50个)  也可以用命令：# uptime。

30 系统日志

```
# cat /var/log/rflogview/*errors
```

检查是否有异常错误记录  也可以搜寻一些异常关键字，例如：

```
grep -i error /var/log/messagesgrep -i fail /var/log/messages
```

31 核心日志  

```
dmesg
```

检查是否有异常错误记录。

32 系统时间  

```
date
```

检查系统时间是否正确。

33 打开文件数目  

```
lsof | wc -l
```

检查打开文件总数是否过多。

34 日志 

```
# logwatch –print
```

配置 /etc/log.d/logwatch.conf，将 Mailto 设置为自己的 email 地址，启动 mail 服务(sendmail或者postfix)，这样就可以每天收到日志报告了。

缺省 logwatch 只报告昨天的日志，可以用 # logwatch –print –range all 获得所有的日志分析结果。

可以用 # logwatch –print –detail high 获得更具体的日志分析结果(而不仅仅是出错日志)。

35 杀掉80端口相关的进程

```
lsof -i :80|grep -v “ID”|awk ‘{print “kill -9”,$2}’|sh
```

36 清除僵死进程

```
ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
```

37 tcpdump 抓包，用来防止80端口被人攻击时可以分析数据

```
tcpdump -c 10000 -i eth0 -n dst port 80 > /root/pkts
```

38 然后检查IP的重复数并从小到大排序 注意 “-t\ +0”  中间是两个空格

```
# less pkts | awk {'printf $3"\n"'} | cut -d. -f 1-4 | sort | uniq -c | awk {'printf $1" "$2"\n"'} | sort -n -t\ +0
```

39 查看有多少个活动的 php-cgi 进程

```
netstat -anp | grep php-cgi | grep ^tcp | wc -l
```

40 查看系统自启动的服务

```
chkconfig --list | awk '{if ($5=="3:on") print $1}'
```

41 kudzu 查看网卡型号

```
kudzu --probe --class=network
```

## Linux命令分类

*这里存放Linux 命令大全并不全，你可以通过linux-command来搜索，它是把 command 目录里面搜集的命令，生成了静态HTML并提供预览以及索引搜索。*

### 文件传输

bye、ftp、ftpcount、ftpshut、ftpwho、ncftp、tftp、uucico、uucp、uupick、uuto、scp

### 备份压缩

ar、bunzip2、bzip2、bzip2recover、compress、cpio、dump、gunzip、gzexe、gzip、lha、restore、tar、unarj、unzip、zip、zipinfo

### 文件管理

diff、diffstat、file、find、git、gitview、ln、locate、lsattr、mattrib、mc、mcopy、mdel、mdir、mktemp、mmove、mread、mren、mshowfat、mtools、mtoolstest、mv、od、paste、patch、rcp、rhmask、rm、slocate、split、tee、tmpwatch、touch、umask、whereis、which、cat、chattr、chgrp、chmod、chown、cksum、cmp、cp、cut、indent

### 磁盘管理

cd、df、dirs、du、edquota、eject、lndir、ls、mcd、mdeltree、mdu、mkdir、mlabel、mmd、mmount、mrd、mzip、pwd、quota、quotacheck、quotaoff、quotaon、repquota、rmdir、rmt、stat、tree、umount

### 磁盘维护

badblocks、cfdisk、dd、e2fsck、ext2ed、fdisk、fsck.ext2、fsck、fsck.minix、fsconf、hdparm、losetup、mbadblocks、mformat、mkbootdisk、mkdosfs、mke2fs、mkfs.ext2、mkfs、mkfs.minix、mkfs.msdos、mkinitrd、mkisofs、mkswap、mpartition、sfdisk、swapoff、swapon、symlinks、sync

### 系统设置

alias、apmd、aumix、bind、chkconfig、chroot、clock、crontab、declare、depmod、dircolors、dmesg、enable、eval、export、fbset、grpconv、grpunconv、hwclock、insmod、kbdconfig、lilo、liloconfig、lsmod、minfo、mkkickstart、modinfo、modprobe、mouseconfig、ntsysv、passwd、pwconv、pwunconv、rdate、resize、rmmod、rpm、set、setconsole、setenv、setup、sndconfig、SVGAText Mode、timeconfig、ulimit、unalias、unset

### 系统管理

adduser、chfn、chsh、date、exit、finger、free、fwhois、gitps、groupdel、groupmod、halt、id、kill、last、lastb、login、logname、logout、logrotate、newgrp、nice、procinfo、ps、pstree、reboot、renice、rlogin、rsh、rwho、screen、shutdown、sliplogin、su、sudo、suspend、swatch、tload、top、uname、useradd、userconf、userdel、usermod、vlock、w、who、whoami、whois

### 文本处理

awk、col、colrm、comm、csplit、ed、egrep、ex、fgrep、fmt、fold、grep、ispell、jed、joe、join、look、mtype、pico、rgrep、sed、sort、spell、tr、uniq、vi、wc

### 网络通讯

dip、getty、mingetty、ppp-off、smbd(samba daemon)、telnet、uulog、uustat、uux、cu、dnsconf、efax、httpd、ifconfig、mesg、minicom、nc、netconf、netconfig、netstat、ping、pppstats、samba、setserial、shapecfg(shaper configuration)、smbd(samba daemon)、statserial(status ofserial port)、talk、tcpdump、testparm(test parameter)、traceroute、tty(teletypewriter)、uuname、wall(write all)、write、ytalk、arpwatch、apachectl、smbclient(samba client)、pppsetup

### 设备管理

dumpkeys、loadkeys、MAKEDEV、rdev、setleds

### 电子邮件与新闻组

archive、ctlinnd、elm、getlist、inncheck、mail、mailconf、mailq、messages、metamail、mutt、nntpget、pine、slrn、X WINDOWS SYSTEM、reconfig、startx(start X Window)、Xconfigurator、XF86Setup、xlsatoms、xlsclients、xlsfonts

### 其他命令

```
# Navigate to location
alias home='cd /Users/ling'
alias gitdir='cd /Users/ling/Desktop/Git'

# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/ling/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/ling/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ling/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/ling/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
```

yes

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
cat service.log | wc -l
cat -n 文件名   查看文件内容，并列出行号
cat -n service.log | grep 13888888888
sed -n "29496,29516p" service.log：从29496行开始检索，到29516行结束
cat -n service.log | tail -n +29496 | head -n 20:从29496行开始检索，往前推20条


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
ps -ef |grep java
netstat -lntup 查端口也是一个很常见的操作
lsof -i:4000 查看某个端口详细的信息

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

9 Shotdown and Reboot
---------------------------------------------
```
shutdown -h now    没有特殊情况，使用此命令
root 关机/重启挂载
mount 挂载 linux所有存储设备都必须挂载使用，包括硬盘
 /dev/sda1      第一个scsi硬盘的第一分区
    /dev/cdrom     光盘
    /dev/hdc       IDE硬盘   centos 5.5
    /dev/sr0       光盘      centos 6.x
mount -t 文件系统 设备描述文件 挂载点（已经存在空目录）
mount -t iso9660 /dev/cdrom /mnt/cdrom
umount /dev/cdrom
umount /mnt/cdrom      注意：退出挂载目录，才能卸载
fdisk -l 查看设备名
mount -t vfat /dev/sdb1 /mnt/usb
```

10 Network
---------------------------------------------
```
ping
功能描述：测试网络畅通性
ping -c 次数 ip    探测网络通畅

ifconfig
功能描述：查询本机网络信息
```

11 pgrep
---------------------------------------------

pgrep名字前有个p，我们可以猜到这和进程相关，又是grep，当然这是进程相关的grep命令。不过，这个命令主要是用来列举进程ID的。如：

```
$ pgrep -u hchen2244122444
```

这个命令相当于：

```
ps -ef | egrep '^hchen' | awk '{print $2}'
```

12 pstree
---------------------------------------------

这个命令可以以树形的方式列出进程。如下所示：

```
[hchen@RHELSVR5 ~]$ pstree
init-+-acpid
     |-auditd-+-python
     |        `-{auditd}
     |-automount---4*[{automount}]
     |-backup.sh---sleep
     |-dbus-daemon
     |-events/0
     |-events/1
     |-hald---hald-runner---hald-addon-acpi
     |-httpd---10*[httpd]
     |-irqbalance
     |-khelper
     |-klogd
     |-ksoftirqd/0
     |-ksoftirqd/1
     |-kthread-+-aio/0
     |         |-aio/1
     |         |-ata/0
     |         |-ata/1
     |         |-ata_aux
     |         |-cqueue/0
     |         |-cqueue/1
     |         |-kacpid
     |         |-kauditd
     |         |-kblockd/0
     |         |-kblockd/1
     |         |-kedac
     |         |-khubd
     |         |-6*[kjournald]
     |         |-kmirrord
     |         |-kpsmoused
     |         |-kseriod
     |         |-kswapd0
     |         |-2*[pdflush]
     |         |-scsi_eh_0
     |         |-scsi_eh_1
     |         |-xenbus
     |         `-xenwatch
     |-migration/0
     |-migration/1
     |-6*[mingetty]
     |-3*[multilog]
     |-mysqld_safe---mysqld---9*[{mysqld}]
     |-smartd
     |-sshd---sshd---sshd---bash---pstree
     |-svscanboot---svscan-+-3*[supervise---run]
     |                     |-supervise---qmail-send-+-qmail-clean
     |                     |                        |-qmail-lspawn
     |                     |                        `-qmail-rspawn
     |                     `-2*[supervise---tcpserver]
     |-syslogd
     |-udevd
     |-watchdog/0
     |-watchdog/1
     -xinetd
```

13 bc
---------------------------------------------

这个命令主要是做一个精度比较高的数学运算的。比如开平方根等。下面是一个我们利用bc命令写的一个脚本（文件名：sqrt）

```
#!/bin/bashif [ $# -ne 1 ]then    echo 'Usage: sqrt number'    exit 1else    echo -e "sqrt($1)\nquit\n" | bc -q -ifi
```

于是，我们可以这样使用这个脚本进行平方根运算：

```
[hchen@RHELSVR5]$ ./sqrt 366[hchen@RHELSVR5]$ ./sqrt 2.00001.4142[hchen@RHELSVR5]$ ./sqrt 10.00003.1622
```

14 split
---------------------------------------------

如果你有一个很大的文件，你想把其分割成一些小的文件，那么这个命令就是干这件事的了。

```
[hchen@RHELSVR5 applebak]# ls -l largefile.tar.gz-rw-r--r-- 1 hchen hchen 436774774 04-17 02:00 largefile.tar.gz
[hchen@RHELSVR5 applebak]# split -b 50m largefile.tar.gz LF_
[hchen@RHELSVR5]# ls -l LF_*-rw-r--r-- 1 hchen hchen 52428800 05-10 18:34 LF_aa-rw-r--r-- 1 hchen hchen 52428800 05-10 18:34 LF_ab-rw-r--r-- 1 hchen hchen 52428800 05-10 18:34 LF_ac-rw-r--r-- 1 hchen hchen 52428800 05-10 18:34 LF_ad-rw-r--r-- 1 hchen hchen 52428800 05-10 18:34 LF_ae-rw-r--r-- 1 hchen hchen 52428800 05-10 18:35 LF_af-rw-r--r-- 1 hchen hchen 52428800 05-10 18:35 LF_ag-rw-r--r-- 1 hchen hchen 52428800 05-10 18:35 LF_ah-rw-r--r-- 1 hchen hchen 17344374 05-10 18:35 LF_ai
文件合并只需要使用简单的合并就行了，如：
```

```
[hchen@RHELSVR5]#  cat LF_* >largefile.tar.gz
```
15 nl
---------------------------------------------

`nl`命令其它和`cat`命令很像，只不过它会打上行号。如下所示：

```
[hchen@RHELSVR5 include]# nl stdio.h | head -n 10     1  /* Define ISO C stdio on top of C++ iostreams.          2     Copyright (C) 1991,1994-2004,2005,2006 Free Software Foundation, Inc.          3     This file is part of the GNU C Library.          4     The GNU C Library is free software; you can redistribute it and/or          5     modify it under the terms of the GNU Lesser General Public          6     License as published by the Free Software Foundation; either          7     version 2.1 of the License, or (at your option) any later version.          8     The GNU C Library is distributed in the hope that it will be useful,
```

16 mkfifo
---------------------------------------------

熟悉Unix的人都应该知道这个是一个创建有名管道的系统调用或命令。

平时，我们在命令行上使用竖线“|”把命令串起来是使用无命管道。

而我们使用mkfifo则使用的是有名管道。下面是示例：

下面是创建一个有名管道：

```
[hchen@RHELSVR5 ~]# mkfifo /tmp/hchenpipe
[hchen@RHELSVR5 ~]# ls -l /tmpprw-rw-r-- 1 hchen  hchen  0 05-10 18:58 hchenpipe

```


然后，我们在一个shell中运行如下命令，这个命令不会返回，除非有人从这个有名管道中把信息读走。

```
[hchen@RHELSVR5 ~]# ls -al > /tmp/hchenpipe

```

我们在另一个命令窗口中读取这个管道中的信息：（其会导致上一个命令返回）

```
[hchen@RHELSVR5 ~]# head /tmp/hchenpipedrwx------ 8 hchen hchen    4096 05-10 18:27 .drwxr-xr-x 7 root  root     4096 03-05 00:06 ..drwxr-xr-x 3 hchen hchen    4096 03-01 18:13 backup-rw------- 1 hchen hchen     721 05-05 22:12 .bash_history-rw-r--r-- 1 hchen hchen      24 02-28 22:20 .bash_logout-rw-r--r-- 1 hchen hchen     176 02-28 22:20 .bash_profile-rw-r--r-- 1 hchen hchen     124 02-28 22:20 .bashrc-rw-r--r-- 1 root  root    14002 03-07 00:29 index.htm-rw-r--r-- 1 hchen hchen   31465 03-01 23:48 index.php

```

17 ldd
---------------------------------------------

这个命令可以知道你的一个可执行文件所使用了动态链接库。如：

```
[hchen@RHELSVR5 ~]# ldd /usr/bin/java        linux-gate.so.1 =>  (0x00cd9000)        libgij.so.7rh => /usr/lib/libgij.so.7rh (0x00ed3000)        libgcj.so.7rh => /usr/lib/libgcj.so.7rh (0x00ed6000)        libpthread.so.0 => /lib/i686/nosegneg/libpthread.so.0 (0x00110000)        librt.so.1 => /lib/i686/nosegneg/librt.so.1 (0x009c8000)        libdl.so.2 => /lib/libdl.so.2 (0x008b5000)        libz.so.1 => /usr/lib/libz.so.1 (0x00bee000)        libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x00aa7000)        libc.so.6 => /lib/i686/nosegneg/libc.so.6 (0x0022f000)        libm.so.6 => /lib/i686/nosegneg/libm.so.6 (0x00127000)        /lib/ld-linux.so.2 (0x00214000)
```

18 col
---------------------------------------------

这个命令可以让你把man文件转成纯文本文件。如下示例：

```
# PAGER=cat# man less | col -b > less.txt
```

19 xmlwf
---------------------------------------------

这个命令可以让你检查一下一个XML文档是否是所有的tag都是正常的。如：

```
[hchen@RHELSVR5 ~]# curl 'https://coolshell.cn/?feed=rss2' > cocre.xml  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current                                 Dload  Upload   Total   Spent    Left  Speed100 64882    0 64882    0     0  86455      0 --:--:-- --:--:-- --:--:-- 2073k[hchen@RHELSVR5 ~]# xmlwf cocre.xml[hchen@RHELSVR5 ~]# perl -i -pe 's@<link>@<br>@g' cocre.xml[hchen@RHELSVR5 ~]# xmlwf cocre.xmlcocre.xml:13:23: mismatched tag
```

20 lsof
---------------------------------------------

可以列出打开了的文件。

```
[root@RHELSVR5 ~]# lsof | grep TCPhttpd       548    apache    4u     IPv6   14300967    TCP *:http (LISTEN)httpd       548    apache    6u     IPv6   14300972    TCP *:https (LISTEN)httpd       561    apache    4u     IPv6   14300967    TCP *:http (LISTEN)httpd       561    apache    6u     IPv6   14300972    TCP *:https (LISTEN)sshd       1764      root    3u     IPv6       4993    TCP *:ssh (LISTEN)tcpserver  8965      root    3u     IPv4  153795500    TCP *:pop3 (LISTEN)mysqld    10202     mysql   10u     IPv4   73819697    TCP *:mysql (LISTEN)sshd      10735      root    3u     IPv6  160731956    TCP 210.51.0.232:ssh->123.117.239.68:31810 (ESTABLISHED)sshd      10767     hchen    3u     IPv6  160731956    TCP 210.51.0.232:ssh->123.117.239.68:31810 (ESTABLISHED)vsftpd    11095      root    3u     IPv4  152157957    TCP *:ftp (LISTEN)
```
