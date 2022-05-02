use hadoopProject;
SET GLOBAL local_infile=1;
truncate table inputDataProd;
load data local infile '/home/saif/LFS/cohort_c9/hadoopProject/prod/landingDir/inputFile.csv' into table inputDataProd
fields terminated by ','
lines terminated by '\n'
ignore 1 rows
(custid,username,@quote_count,ip,@entry_time,hour,min,sec,msec,http_type,purchase_category,total_count,purchase_sub_category,http_info,status_code,@day,@month,@year)
set quote_count=replace(trim(@quote_count),' ',''),
entry_time=str_to_date(date_format(str_to_date(@entry_time,'%d/%b/%Y:%H'),'%d-%m-%Y'),'%d-%m-%Y'),
day=date_format(str_to_date(@entry_time,'%d/%b/%Y'),'%d'),
month=date_format(str_to_date(@entry_time,'%d/%b/%Y'),'%m'),
year=date_format(str_to_date(@entry_time,'%d/%b/%Y'),'%Y');
insert into inputDataProd_bkp select * from inputDataProd;
