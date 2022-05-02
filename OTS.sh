#!/bin/bash
source /home/saif/LFS/cohort_c9/hadoopProject/prod/env/profile.prm
log_dir=/home/saif/LFS/cohort_c9/hadoopProject/prod/logs/
basefile=`basename ${0}`
curr_dt=`date +%Y%m%d_%H%m%S`
log_file=${log_dir}${basefile}_${curr_dt}.log

###################################
#creating sql tables if not exists#
###################################
mysql -u ${USER} -p${PASSWORD} -h ${HOST} < /home/saif/LFS/cohort_c9/hadoopProject/prod/env/sqlOTSqueries.sql

###############################################
#staring hadoop service and creating sqoop job#
###############################################
start-all.sh
sqoop job --create imp_LFS_2_HFS_Prod -- import \
--connect jdbc:mysql://localhost:3306/hadoopProject?useSSL=False \
--username root --password-file file:///home/saif/LFS/cohort_c9/env/sqoop.pwd \
--delete-target-dir --target-dir /user/saif/inputDataProd/ \
--query "select custid,username,quote_count,ip,entry_time,hour,min,sec,msec,http_type,purchase_category,total_count,purchase_sub_category,http_info,status_code,day,month,year from inputDataProd where \$CONDITIONS" \
-m 1

######################
#starting hive prompt#
######################
nohup hive --service metastore &
hive -f /home/saif/LFS/cohort_c9/hadoopProject/prod/env/hiveOTSqueries.hql

echo "OTS Script completed succesfully!!!!"
