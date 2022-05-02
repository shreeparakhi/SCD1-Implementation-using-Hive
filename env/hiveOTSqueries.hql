use hadoopProject;
create table if not exists hive_inputDataProd(custid int,
username varchar(50),quote_count int,ip varchar(50),
entry_time date,hour int,min int,sec int,msec int,
http_type varchar(20),purchase_category varchar(100),total_count int,
purchase_sub_category varchar(100),http_info varchar(300),status_code varchar(20),day int,month int,year int)
row format delimited fields terminated by ','
collection items terminated by '\n'
stored as textfile;
set hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=1000;
SET hive.exec.max.dynamic.partitions.pernode=1000;
set hive.support.concurrency=true;
set hive.compactor.initiator.on=true;
set hive.compactor.worker.threads=1;
set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
set hive.auto.convert.join=false;
create external table if not exists hive_ext_stg_inputDataProd(custid int,
username varchar(50),quote_count int,ip varchar(50),
entry_time date,hour int,min int,sec int,msec int,
http_type varchar(20),purchase_category varchar(100),total_count int,
purchase_sub_category varchar(100),http_info varchar(300),status_code varchar(20))
partitioned by(year int,month int,day int)
row format delimited fields terminated by ','
collection items terminated by '\n'
stored as textfile;
create table if not exists hive_ext_inputDataProd(custid int,
username varchar(50),quote_count int,ip varchar(50),
entry_time date,hour int,min int,sec int,msec int,
http_type varchar(20),purchase_category varchar(100),total_count int,
purchase_sub_category varchar(100),http_info varchar(300),status_code varchar(20))
partitioned by(year int,month int,day int)
row format delimited fields terminated by ','
collection items terminated by '\n'
stored as orc
tblproperties("transactional"="true");
