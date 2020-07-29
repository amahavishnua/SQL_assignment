
/*
Consider a table E(sid int, cid int)

Here SID is student and CID is the course student is taking.

for each student, list the student and the number of courses the student is taking.

for each course, list the number of students taking that course.

find the students who are taking the most number of classes.

find the courses with most number of students.

*/
select SID, count(SID) from E group by SID;
select CID, Count(CID) from E group by CID;
select CID from E group by CID
having count(CID) = (
  select max(A.C) 
  from (
    select count(CID) aS C from E group by CID) as A);
select SID from E group by SID
having count(SID) = (
  select max(A.C1) from (
    select count(SID) as C1 from E group by SID) as A);
/*
Use E(SID,CID) for these challenges.

1. List all pairs of students who are taking atleast one course together

2. List all pairs of students who are taking all courses together

3. List all pairs of students who are NOT taking any course together.

(think in terms of sets to solve these problems)

*/

select distinct A.SID, B.SID from E as A, E as B
where A.SID < B.SID
and A.CID = B.CID order by A.SID, B.SID;

select A1.SID, B1.SID from E as A1, E as B1 where A1.SID < B1.SID;

select distinct A2.SID, B2.SID from E as A2, E as B2
where A2.SID < B2.SID
having (A2.SID, B2.SID) not in (
    select A3.SID, B3.SID from E as A3, E as B3
    WHERE A3.SID < B3.SID AND A3.CID = B3.CID)
ORDER BY A2.SID, B2.SID;