--1/3--
--1--Calculate the count of all grades in the system
SELECT COUNT(Grade) as AllGrades
FROM dbo.[Grade]

--2--Calculate the count of all grades per Teacher in the system
SELECT TeacherID, COUNT(Grade) as AllGradesT
FROM dbo.[Grade]
GROUP BY TeacherID 
ORDER BY TeacherID asc

--3--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT TeacherID, COUNT(Grade) as AllGrades
FROM dbo.[Grade]
WHERE StudentID < 100
GROUP BY TeacherID
ORDER BY TeacherID asc

--4--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT StudentID, MAX(Grade) as MaxGrade, AVG(Grade) as Average
FROM dbo.[Grade]
GROUP BY StudentID


--2/3--
--1--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT TeacherID, COUNT(Grade) as AllGrade
FROM dbo.[Grade]
GROUP BY TeacherID
HAVING COUNT(Grade) > 200

--2--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
SELECT TeacherID, COUNT(Grade) as AllGrade
FROM dbo.[Grade]
WHERE StudentID < 100
GROUP BY TeacherID
HAVING COUNT(Grade) > 50

--3--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
--Filter only records where Maximal Grade is equal to Average Grade
SELECT StudentID, Max(Grade) as MaxGrade, AVG(Grade) as Average
FROM dbo.[Grade]
GROUP BY StudentID
HAVING  Max(Grade) = AVG(Grade)

--4--List Student First Name and Last Name next to the other details from previous query
SELECT StudentID, s.FirstName, s.LastName, Max(Grade) as MaxGrade, AVG(Grade) as Average
FROM dbo.[Grade] as g
INNER JOIN dbo.Student as s on s.id = g.StudentID
GROUP BY StudentID, s.FirstName, s.LastName
HAVING  Max(Grade) = AVG(Grade)

--3/3--
--1--Create new view (vv_StudentGrades) that will List all StudentIdsand count of Grades per student
CREATE VIEW vv_StudentGrades
AS
SELECT StudentID,COUNT (Grade) as Grade
FROM dbo.[Grade] o
GROUP BY StudentID

--2--Change the view to show Student First and Last Names instead of StudentID
ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName + N' '+ s.LastName as StudentFullName, COUNT (Grade) as Grade
FROM dbo.[Grade] g
INNER JOIN dbo.Student s on g.StudentID = s.Id
GROUP BY s.FirstName, s.LastName

--3--List all rows from view ordered by biggest Grade Count
SELECT * FROM vv_StudentGrades
ORDER BY Grade desc

--4--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName)
--and Count the courses he passed through the exam(Ispit)
CREATE VIEW vv_StudentGradeDetails
AS
SELECT s.FirstName, s.LastName, COUNT(Name) as Exams
FROM dbo.Grade g
INNER JOIN dbo.Student s on s.ID = g.StudentID
INNER JOIN dbo.Course c on c.ID = g.CourseID
GROUP BY s.FirstName, s.LastName

SELECT * FROM vv_StudentGradeDetails