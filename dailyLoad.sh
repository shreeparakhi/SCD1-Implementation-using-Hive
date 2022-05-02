#!/bin/bash
source /home/saif/LFS/cohort_c9/hadoopProject/prod/env/profile.prm
log_dir=/home/saif/LFS/cohort_c9/hadoopProject/prod/logs/
basefile=`basename ${0}`
curr_dt=`date +%Y%m%d_%H%M%S`
log_file=${log_dir}${basefile}_${curr_dt}.log

################################################
#load data in mysql dump table and backup table#
################################################
if [ -f ${SQLDAILY} ]
then
        echo -e "`date +%d/%m/%Y_%H:%M:%S`\tQuery file exists!! continuing with execution" >> ${log_file}
else
        echo -e "`date +%d/%m/%Y_%H:%M:%S`\tQuery file not exists" >> ${log_file}
        exit 1
fi
mysql --local-infile=1 -u ${USER} -p${PASSWORD} -h ${HOST} < /home/saif/LFS/cohort_c9/hadoopProject/prod/env/sqlDailyqueries.sql

###################
#Execute sqoop job#
###################
sqoop job --exec imp_LFS_2_HFS_Prod

if [ $? -ne 0 ]
then
	echo -e "`date +%d/%m/%Y_%H:%M:%S`\tSqoop job failed!!!!  Please reachout to developer."
	exit 1
else
	echo -e "`date +%d/%m/%Y_%H:%M:%S`\tSqoop job completed. Data loaded in HDFS."
fi

##############################################
#load data in hive tables and impelement SCD1#
##############################################
nohup hive --service metastore &
hive -f /home/saif/LFS/cohort_c9/hadoopProject/prod/env/hiveDailyqueries.hql
######################################################
#export data from hiveSCD1 table to edgenode in csv file#
######################################################
hive -e 'set hive.support.concurrency=true;set hive.enforce.bucketing=true;set hive.exec.dynamic.partition.mode=nonstrict;set hive.compactor.initiator.on=true;set hive.compactor.worker.threads=1;set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;set hive.auto.convert.join=false;select * from hadoopproject.hive_ext_inputdata' | sed 's/[\t]/,/g'  > /home/saif/LFS/cohort_c9/hadoopProject/dev/exportData.csv

#############################################
#load data in export table and perform recon#
#############################################
mysql --local-infile=1 -u ${USER} -p${PASSWORD} -h ${HOST} < /home/saif/LFS/cohort_c9/hadoopProject/prod/env/lfstosqlexport.sql

if [ $? -eq 0 ]
then
	echo -e "`date +%d/%m/%Y_%H:%M:%S`\tPlease check recon value^^Data loaded succesfully!!"
else
	echo -e "`date +%d/%m/%Y_%H:%M:%S`\tSomething went wrong. Please investigate!!"
fi

