/* bbclean.csv data CSV form:

Maha Vishnu [ Maha.mra503@myhunter.cuny.edu], CS453-01

*/
-- Q01 to Q03
create table nSec (s Varchar(255), c Varchar(255));
Load data local infile '/home/data/sql.challenges/roster/bbclean.csv' 
into table nSec
fields terminated by ','
(s, c);
/*creating second table  with 3 columns*/
create table GoodTable (n Varchar(255), m Varchar(255), c Varchar(255));

insert into GoodTable (n, m, c)
select substr(s,1,instr(s,'[')-1),substr(s,instr(s,'['),instr(s,']')+1), c
from nSec;

update GoodTable
set m = replace(m,'[','');

update GoodTable
set m = replace(m,']', '');
/*
use the table you created in pq1.txt
List the number of students in each class
producing ouput like class,#of students.

*/
select c, count(n) from GoodTable group by c;

/*
Use the table you created in pq1.txt
List the class which has the most number of students

*/

select c from GoodTable
group by c
having count(n) = (
  select max(A1.m) 
  from (select count(n) as m from GoodTable group by c) as A1
  )

