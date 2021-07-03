/*Create multi-statement table value function that for specific 
Teacher and Course will return list of students (FirstName, LastName) 
who passed the exam, together with Grade and CreatedDate*/

CREATE FUNCTION dbo.fn_StudentPassed (@TeacherId int, @CourseId int)
RETURNS @Result TABLE 
(FirstName nvarchar (50), LastName nvarchar (50), Grade tinyint, CreatedDate nvarchar(10), CourseName nvarchar(50), TeacherName nvarchar(50))

AS
BEGIN

    INSERT INTO @Result
    SELECT s.FirstName, s.LastName, g.Grade,convert(nvarchar(10), g.CreatedDate, 102), c.Name, CONCAT(t.FirstName,' ',t.LastName)
    FROM dbo.Student as s
    INNER JOIN dbo.Grade as g on g.StudentID = s.ID
    INNER JOIN dbo.Teacher as t on t.ID = g.TeacherID
    INNER JOIN dbo.Course as c on c.ID = g.CourseID
    WHERE g.TeacherID = @TeacherId and g.CourseID = @CourseId
    
RETURN
END

DECLARE @TeacherId int = 2
DECLARE @CourseId int = 2
SELECT * 
FROM dbo.fn_StudentPassed  (@TeacherId, @CourseId)
ORDER BY Grade

