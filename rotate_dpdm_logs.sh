#!/bin/sh
cd /data1/ms/comos/logs
##trigger rotate uwsgi log
touch uwsgi-dpdm-logrotate

##bak log files
subdir="`date +%Y`_`cat /etc/salt/minion_id | tr -d '\r\n'`"
mkdir -p "$subdir"
for f in uwsgi-dpdm.log.[0-9]* dpdm.access dpdm.error dpdm_backdata.log
do
	gzip $f
	mv $f.gz "$subdir/"
done
for gz in "$subdir/"*
do
    echo gz
	rsync -R $gz baklt.pub.sina.com.cn::comos_uwsgi_log_bak
	r1=$?
	rsync -R $gz bakdx.pub.sina.com.cn::comos_uwsgi_log_bak
	r2=$?
	if [ $r1 -eq 0 -o $r2 -eq 0 ]
	then
		rm -f $gz
	fi
done

##restart dpdm daemon processes to reopen log file
while read cmd
do
    kill -sigusr1 $cmd
done << EOF
`ps -ef | grep "/usr/bin/python /data1/ms/comos/dpdm/dpdm/dpdm.py" | grep -v grep | awk '{print $2}'`
EOF
