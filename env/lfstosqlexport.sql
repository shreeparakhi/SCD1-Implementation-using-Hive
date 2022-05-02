use hadoopProject;
SET GLOBAL local_infile=1;
truncate table exportData;
load data local infile '/home/saif/LFS/cohort_c9/hadoopProject/dev/exportData.csv' into table exportData
fields terminated by ','
lines terminated by '\n';
with e as (select count(distinct custid) as cnt from exportData),
d as (select count(distinct custid) as cnt from inputDataProd_bkp)
select abs(e.cnt-d.cnt) as ReconValue
from e,d;
