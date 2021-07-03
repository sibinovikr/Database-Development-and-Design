/*Create multi-statement table value function that for specific 
Teacher and Course will return list of students (FirstName, LastName) 
who passed the exam, together with Grade and CreatedDate*/

CREATE FUNCTION dbo.fn_StudentPassed (@TeacherId int, @CourseId int)
RETURNS @Result TABLE 
(FirstName nvarchar (50), LastName nvarchar (50), Grade tinyint, CreatedDate nvarchar(10), CourseName nvarchar(50), TeacherName nvarchar(50))

AS
BEGIN

    INSERT INTO @Result
    select s.FirstName, s.LastName, g.Grade,convert(nvarchar(10), g.CreatedDate, 102), c.Name, CONCAT(t.FirstName,' ',t.LastName)
    from dbo.Student as s
    inner join dbo.Grade as g on g.StudentID = s.ID
    inner join dbo.Teacher as t on t.ID = g.TeacherID
    inner join dbo.Course as c on c.ID = g.CourseID
    where g.TeacherID = @TeacherId and g.CourseID = @CourseId
    
RETURN
END

declare @TeacherId int = 2
declare @CourseId int = 2
SELECT * 
FROM dbo.fn_StudentPassed  (@TeacherId, @CourseId)
ORDER BY Grade

