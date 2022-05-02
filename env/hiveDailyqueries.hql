use hadoopProject;
load data inpath '/user/saif/inputDataProd/part-m-00000' overwrite into table hive_inputDataProd;
set hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=1000;
SET hive.exec.max.dynamic.partitions.pernode=1000;
set hive.support.concurrency=true;
set hive.compactor.initiator.on=true;
set hive.compactor.worker.threads=1;
set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
set hive.auto.convert.join=false;
insert overwrite table hive_ext_stg_inputDataProd partition (year,month,day) select custid,username,quote_count,ip,entry_time,hour,min,sec,msec,http_type,purchase_category,total_count,purchase_sub_category,http_info,status_code,year,month,day from hive_inputDataProd;
merge into
hive_ext_inputDataProd
using
hive_ext_stg_inputDataProd as stg
on
stg.custid = hive_ext_inputDataProd.custid
when matched and (stg.username != hive_ext_inputDataProd.username) then
update set username = stg.username
when not matched then
insert values (stg.custid,stg.username,stg.quote_count,stg.ip,stg.entry_time,stg.hour,stg.min,stg.sec,stg.msec,stg.http_type,stg.purchase_category,stg.total_count,stg.purchase_sub_category,stg.http_info,stg.status_code,stg.year,stg.month,stg.day);
