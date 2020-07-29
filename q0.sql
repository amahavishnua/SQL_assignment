


/* student_roster.csv data CSV form:

S01, PHYSICS, 95

*/


Create table student_c_g (sid varchar(255), c varchar(255), g int);
Load data local infile '/home/data/sql.challenges/roster/student_roster.csv' 
into table student_c_g
fields terminated by ','
(sid, c, g);

/* find all dtudent who take the same course, order by student pair */

select distinct A1.sid, B1.sid 
from student_c_g as A1, student_c_g as B1
where A1.c = B1.c  and A1.sid < B1.sid order by A1.sid;

/* find all students NOT taken cousre together, ORDER BY student pair */

select distinct A2.sid, B2.sid
from student_c_g as A2, student_c_g as B2 where A2.sid < B2.sid
having (A2.sid, B2.sid) not in (
    select C1.sid, D1.sid
    from student_c_g as C1, student_c_g as D1
    where C1.sid < D1.sid  and C1.c = D1.c)
order by A2.sid, B2.sid;

/* find students got highest grade EVERY COURSE and ORDER BY student */
select A3.sid from (
  select sid, count(sid) as Countt 
  from student_c_g group by sid) as A3
  join (
    select sid, count(sid) as Maxi from student_c_g where (c, g) 
    in (select c, max(g) from student_c_g group by c) group by sid) as B3
  on (A3.sid, A3.Countt) = (B3.sid, B3.Maxi);

/* highest grade in atleast one course ORDER BY student */
select distinct sid from student_c_g 
where (c, g) 
in (
  select c, max(g) from student_c_g group by c) 
 order by sid;


