--1. Show ids of teachers that did not have classes on the 1st year of study.
SELECT DISTINCT tno
	FROM TSC
	WHERE tno NOT IN
		(SELECT DISTINCT tno
			FROM TSC, courses
			WHERE TSC.cno = courses.cno AND courses.studyear = 1)



--2. On which year of study there was the greatest average grade?
SELECT TOP 1 studyear
	FROM TSC, courses
	WHERE TSC.cno = courses.cno
	GROUP BY studyear
	ORDER BY AVG(grade) DESC



--3. How many teachers did not have any classes?
SELECT COUNT(*) AS 'number of teachers, who didnt counducted any classes'
	FROM teachers
	WHERE teachers.tno NOT IN
		(SELECT DISTINCT tno 
			FROM TSC)



--4. Which teachers (ids, names) conducted more than 3 courses and how many courses they 
--conducted?

SELECT TSC.tno, tname, COUNT(cno) AS 'number of counducted courses'
	FROM TSC, teachers
	WHERE TSC.tno = teachers.tno
	GROUP BY TSC.tno, tname
	HAVING COUNT(cno) > 3;



--5. Create a view that contains all the data from TSC extended by names of students, titles and 
--names of teachers and names of courses.

CREATE VIEW widened --(poszerzony)
	AS SELECT TSC.*, sname, tname, title, cname
		FROM TSC, teachers, courses, students
		WHERE TSC.cno = courses.cno AND TSC.sno = students.sno AND TSC.tno = teachers.tno

--SELECT * FROM widened



--6. For each city, give the total numer of students and teachers that come from this city.

--DROP VIEW cities;

CREATE VIEW cities
	AS SELECT city
		FROM teachers
	UNION ALL
	SELECT city
		FROM students

--SELECT * FROM cities

SELECT city, COUNT(*) AS 'number of cities'
	FROM cities
	GROUP BY city;



--7. Create an archive for table TSC. The archive should contain ids and names of students and 
--teachers, ids and names of courses and grades. Next insert to this archive all the data from 
--TSC and clear TSC.

--DROP TABLE TSC1

CREATE TABLE TSC1
	(sno VARCHAR(3), --REFERENCES students,
	 cno VARCHAR(3), --REFERENCES courses,
	 tno VARCHAR(3), --REFERENCES teachers,
	 hours INT,
	 grade FLOAT,
	 sname VARCHAR(20),
	 tname VARCHAR(20),
	 cname VARCHAR(20),
	 PRIMARY KEY(tno,sno,cno));

INSERT INTO TSC1
	SELECT TSC.*, students.sname, teachers.tname, courses.cname
		FROM TSC, students, teachers, courses
		WHERE TSC.cno = courses.cno AND TSC.sno = students.sno AND TSC.tno = teachers.tno;

SELECT * FROM TSC1;
