CREATE DATABASE school2

USE school2

CREATE TABLE students
	(sno VARCHAR(3) PRIMARY KEY,
	 sname VARCHAR(20),
	 syear INT CHECK (1960 <= syear AND syear <= YEAR(GETDATE())),
	 city VARCHAR(20));

CREATE TABLE courses
	(cno VARCHAR(3) PRIMARY KEY,
	 cname VARCHAR(20),
	 studyear INT CHECK (0 < studyear AND studyear < 10));


CREATE TABLE teachers
	(tno VARCHAR(3) PRIMARY KEY,
	 tname VARCHAR(20),
	 title VARCHAR(20),
	 city VARCHAR(20),
	 supno VARCHAR(3) REFERENCES teachers);


CREATE TABLE TSC
	(tno VARCHAR(3) REFERENCES teachers,
	 sno VARCHAR(3) REFERENCES students,
	 cno VARCHAR(3) REFERENCES courses,
	 hours INT,
	 grade FLOAT,
	 PRIMARY KEY(tno,sno,cno));