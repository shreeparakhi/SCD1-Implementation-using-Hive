use hadoopProject;
create table if not exists inputDataProd(custid int,username varchar(50),quote_count int,ip varchar(50),entry_time date,hour int,min int,sec int,msec int,http_type varchar(20),purchase_category varchar(100),total_count int,purchase_sub_category varchar(100),http_info varchar(300),status_code varchar(20),day int,month int,year int);
create table if not exists inputDataProd_bkp(custid int,username varchar(50),quote_count int,ip varchar(50),entry_time date,hour int,min int,sec int,msec int,http_type varchar(20),purchase_category varchar(100),total_count int,purchase_sub_category varchar(100),http_info varchar(300),status_code varchar(20),day int,month int,year int);