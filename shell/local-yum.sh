# 通过 rsync 的方式同步 yum，通过 nginx 只做 http yum 站点；
#!/bin/bash
# 更新yum镜像


RsyncCommand="rsync -rvutH -P --delete --delete-after --delay-updates --bwlimit=1000"
DIR="/app/yumData"
LogDir="$DIR/logs"
Centos6Base="$DIR/Centos6/x86_64/Base"
Centos7Base="$DIR/Centos7/x86_64/Base"
Centos6Epel="$DIR/Centos6/x86_64/Epel"
Centos7Epel="$DIR/Centos7/x86_64/Epel"
Centos6Salt="$DIR/Centos6/x86_64/Salt"
Centos7Salt="$DIR/Centos7/x86_64/Salt"
Centos6Update="$DIR/Centos6/x86_64/Update"
Centos7Update="$DIR/Centos7/x86_64/Update"
Centos6Docker="$DIR/Centos6/x86_64/Docker"
Centos7Docker="$DIR/Centos7/x86_64/Docker"
Centos6Mysql5_7="$DIR/Centos6/x86_64/Mysql/Mysql5.7"
Centos7Mysql5_7="$DIR/Centos7/x86_64/Mysql/Mysql5.7"
Centos6Mysql8_0="$DIR/Centos6/x86_64/Mysql/Mysql8.0"
Centos7Mysql8_0="$DIR/Centos7/x86_64/Mysql/Mysql8.0"
MirrorDomain="rsync://rsync.mirrors.ustc.edu.cn"

# 目录不存在就创建
check_dir(){
    for dir in $*
    do
        test -d $dir || mkdir -p $dir
    done
}

# 检查rsync同步结果
check_rsync_status(){
    if [ $? -eq 0 ];then
        echo "rsync success" >> $1
    else
        echo "rsync fail" >> $1
    fi
}


check_dir $DIR $LogDir $Centos6Base $Centos7Base $Centos6Epel $Centos7Epel $Centos6Salt $Centos7Salt $Centos6Update $Centos7Update $Centos6Docker $Centos7Docker $Centos6Mysql5_7 $Centos7Mysql5_7 $Centos6Mysql8_0 $Centos7Mysql8_0


# Base yumrepo
#$RsyncCommand "$MirrorDomain"/repo/centos/6/os/x86_64/ $Centos6Base >> "$LogDir/centos6Base.log" 2>&1
# check_rsync_status "$LogDir/centos6Base.log"
$RsyncCommand "$MirrorDomain"/repo/centos/7/os/x86_64/ $Centos7Base >> "$LogDir/centos7Base.log" 2>&1
check_rsync_status "$LogDir/centos7Base.log"

# Epel yumrepo
# $RsyncCommand "$MirrorDomain"/repo/epel/6/x86_64/ $Centos6Epel >> "$LogDir/centos6Epel.log" 2>&1
# check_rsync_status "$LogDir/centos6Epel.log"
$RsyncCommand "$MirrorDomain"/repo/epel/7/x86_64/ $Centos7Epel >> "$LogDir/centos7Epel.log" 2>&1
check_rsync_status "$LogDir/centos7Epel.log"

# SaltStack yumrepo
# $RsyncCommand "$MirrorDomain"/repo/salt/yum/redhat/6/x86_64/ $Centos6Salt >> "$LogDir/centos6Salt.log" 2>&1
# ln -s $Centos6Salt/archive/$(ls $Centos6Salt/archive | tail -1) $Centos6Salt/latest
# check_rsync_status "$LogDir/centos6Salt.log"
$RsyncComman "$MirrorDomain"/repo/salt/yum/redhat/7/x86_64/ $Centos7Salt >> "$LogDir/centos7Salt.log" 2>&1
check_rsync_status "$LogDir/centos7Salt.log"
# ln -s $Centos7Salt/archive/$(ls $Centos7Salt/archive | tail -1) $Centos7Salt/latest

# Docker yumrepo
$RsyncCommand "$MirrorDomain"/repo/docker-ce/linux/centos/7/x86_64/stable/ $Centos7Docker >> "$LogDir/centos7Docker.log" 2>&1
check_rsync_status "$LogDir/centos7Docker.log"

# centos update yumrepo
# $RsyncCommand "$MirrorDomain"/repo/centos/6/updates/x86_64/ $Centos6Update >> "$LogDir/centos6Update.log" 2>&1
# check_rsync_status "$LogDir/centos6Update.log"
$RsyncCommand "$MirrorDomain"/repo/centos/7/updates/x86_64/ $Centos7Update >> "$LogDir/centos7Update.log" 2>&1
check_rsync_status "$LogDir/centos7Update.log"

# mysql 5.7 yumrepo
# $RsyncCommand "$MirrorDomain"/repo/mysql-repo/yum/mysql-5.7-community/el/6/x86_64/ "$Centos6Mysql5_7" >> "$LogDir/centos6Mysql5.7.log" 2>&1
# check_rsync_status "$LogDir/centos6Mysql5.7.log"
$RsyncCommand "$MirrorDomain"/repo/mysql-repo/yum/mysql-5.7-community/el/7/x86_64/ "$Centos7Mysql5_7" >> "$LogDir/centos7Mysql5.7.log" 2>&1
check_rsync_status "$LogDir/centos7Mysql5.7.log"

# mysql 8.0 yumrepo
# $RsyncCommand "$MirrorDomain"/repo/mysql-repo/yum/mysql-8.0-community/el/6/x86_64/ "$Centos6Mysql8_0" >> "$LogDir/centos6Mysql8.0.log" 2>&1
# check_rsync_status "$LogDir/centos6Mysql8.0.log"
$RsyncCommand "$MirrorDomain"/repo/mysql-repo/yum/mysql-8.0-community/el/7/x86_64/ "$Centos7Mysql8_0" >> "$LogDir/centos7Mysql8.0.log" 2>&1
check_rsync_status "$LogDir/centos7Mysql8.0.log"