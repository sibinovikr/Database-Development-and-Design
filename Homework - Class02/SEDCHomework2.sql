--1/6--
--1--Find all Students with FirstName= Antonio
SELECT * 
FROM Student
WHERE FirstName = 'Antonio'

--2--Find all Students with DateOfBirth greater than ‘01.01.1999’
SELECT * 
FROM Student
WHERE DateOfBirth > '1999-01-01'

--3--Find all Male students
SELECT * 
FROM Student
WHERE Gender = 'M'

--4--Find all Students with LastName starting With ‘T’
SELECT * 
FROM Student
WHERE LastName like 'T%'

--5--Find all Students Enrolled in January/1998
SELECT * 
FROM Student
WHERE EnrolledDate >='1998-01-01' and EnrolledDate < '1998-02-01'

--6--Find all Students with LastNamestarting With ‘J’ enrolled in January/1998
SELECT * 
FROM Student
WHERE EnrolledDate >='1998-01-01' and EnrolledDate < '1998-02-01'
and LastName like 'J%'


--2/6--
--1--Find all Students with FirstName = Antonio ordered by Last Name
SELECT * 
FROM Student
WHERE FirstName = 'Antonio'
ORDER BY LastName asc

--2--List all Students ordered by FirstName
SELECT * 
FROM Student
ORDER BY FirstName asc

--3--Find all Male students ordered by EnrolledDate, starting from the last enrolled
SELECT * 
FROM Student
WHERE Gender = 'M'
ORDER BY EnrolledDate desc

--3/6--
--1--List all Teacher First Names and Student First Names in single result set with duplicates
SELECT FirstName
FROM dbo.Teacher
UNION ALL
SELECT FirstName
FROM dbo.Student

--2--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
SELECT LastName
FROM dbo.Teacher
UNION
SELECT LastName
FROM dbo.Student

--3--List all common First Names for Teachers and Students
SELECT FirstName
FROM dbo.Teacher
INTERSECT
SELECT FirstName
FROM dbo.Student


--4/6--
--1--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
ALTER TABLE GradeDetails
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints
DEFAULT 100 FOR [AchievementMaxPoints]

--2--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
ALTER TABLE GradeDetails
ADD CONSTRAINT CHK_GradeDetails_APoints 
CHECK (AchievementPoints <= AchievementMaxPoints);

--3--Change AchievementTypetable to guarantee unique names across the Achievement types
ALTER TABLE [dbo].[AchievementType] WITH CHECK
ADD CONSTRAINT UCP_AchievementType_Name UNIQUE (Name)


--5/6--
--Create Foreign key constraints from diagram or with script
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_GradeDetails_Grade] FOREIGN KEY ([GradeId]) REFERENCES [dbo].[Grade]([Id]);
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Student] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student]([Id]);
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Teacher] FOREIGN KEY ([TeacherId]) REFERENCES [dbo].[Teacher]([Id]);
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Course] FOREIGN KEY ([CourseId]) REFERENCES [dbo].[Course]([Id]);
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_GradeDetails_AchievementType] FOREIGN KEY ([AchievementTypeId]) REFERENCES [dbo].[AchievementType]([Id]);



--6/6--
--1--List all possible combinations of Courses names and AchievementType names that can be passed by student
select c.Name, at.Name
from dbo.Course c
cross join dbo.AchievementType as at

--2--List all Teachers that has any exam Grade
select distinct t.*, g.Grade  
from dbo.Teacher as t
inner join dbo.[Grade] as g on t.id = g.TeacherId

--3--List all Teachers without exam Grade
select t. *
from dbo.Teacher as t
left join dbo.[Grade] as g on t.id = g.TeacherID
where g.TeacherID is null

--4--List all Students without exam Grade (using Right Join)
select s.*
from dbo.Grade as g
right join dbo.[Student] as s on s.id = g.StudentID
where g.StudentID is null