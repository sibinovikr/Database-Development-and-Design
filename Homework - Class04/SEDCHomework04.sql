--1/2--
--1--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students  having FirstName  same as the variable

DECLARE @FirstName nvarchar(50)
SET @FirstName = 'Antonio'

SELECT * 
FROM dbo.Student
WHERE FirstName = @FirstName

--2--Declare table variable that will contain StudentId, StudentNameand DateOfBirth
--Fill the  table variable with all Female  students
DECLARE @Student TABLE 
(StudentID int, FirstName nvarchar(50), DateOfBirth date);

INSERT INTO @Student
SELECT Id, FirstName, DateOfBirth
FROM dbo.Student
WHERE Gender = 'F'

SELECT * FROM @Student

--3--Declare temp table that will contain LastNameand EnrolledDatecolumns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve  the students  from the  table which last name  is with 7 characters
CREATE TABLE #StudentNew
(LastName nvarchar(50), EnrolledDate date);

INSERT INTO #StudentNew
SELECT LastName, EnrolledDate
FROM dbo.Student
WHERE FirstName like 'A%'

SELECT * 
FROM #StudentNew
WHERE Len(LastName) = 7

--4--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName  and LastName are the same
SELECT *
FROM dbo.Teacher
WHERE Len(FirstName) < 5 and substring (FirstName, 1, 3) like substring (LastName, 1, 3)


--2/2--
--1--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentIdin the following format:
--StudentCardNumberwithout “sc-”
--“ – “
--First character  of student  FirstName
--“.”
--Student LastName
CREATE FUNCTION fn_FormatStudentName (@StudentID int)RETURNS nvarchar (500)asBEGIN      DECLARE @FormatStudentName  nvarchar(500)	   SELECT @FormatStudentName = replace(StudentCardNumber,'sc-', '') +' - '+ substring (FirstName, 1, 1) +'.'+ dbo.Student.LastName	   FROM dbo.Student	   WHERE ID = @StudentID	   RETURN @FormatStudentNameENDselect dbo.fn_FormatStudentName (1) as 'FunctionOutput'select *, dbo.fn_FormatStudentName (Id) as 'FunctionOutput'from dbo.Student

