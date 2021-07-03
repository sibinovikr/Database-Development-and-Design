--1a
CREATE OR ALTER PROCEDURE dbo.CreateGrade (@CreatedDate date, @StudentId int, @TeacherId int, @CourseId int, @Grade tinyint)
AS
BEGIN
	
	INSERT INTO dbo.[Grade] (CreatedDate, StudentID, TeacherID, CourseID, Grade)
	VALUES (@CreatedDate, @StudentId, @TeacherId, @CourseId, @Grade)
	
	SELECT count(*) as TotalGrades
	FROM dbo.[Grade] g
	WHERE StudentID = @StudentId

	SELECT max(g.Grade) as MaxGrade
	FROM dbo.[Grade] g
	WHERE StudentID = @StudentId
	and TeacherID = @TeacherId

END

EXEC dbo.CreateGrade @CreatedDate = '2019.05.23', @StudentId = 1, @TeacherId = 5, @CourseId = 4, @Grade = 7

--1b
CREATE OR ALTER PROCEDURE dbo.CreateGradeDetail 
(@AchievementTypeID tinyint, @AchievementPoints tinyint, @AchievementMaxPoints tinyint, @AchievementDate datetime, @GradeId int)

AS
BEGIN

INSERT INTO dbo.GradeDetails ([AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate], [GradeID])
VALUES (@AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate, @GradeId)

SELECT sum(gd.AchievementPoints/gd.AchievementMaxPoints*aty.ParticipationRate) as GradePoints
FROM dbo.[GradeDetails] gd
INNER JOIN dbo.AchievementType aty on aty.id = gd.AchievementTypeID
WHERE gd.AchievementTypeID = @AchievementTypeID	

END

exec dbo.CreateGradeDetail @AchievementTypeID = 4, @AchievementPoints = 3, @AchievementMaxPoints = 5, @AchievementDate = '2021.06.21', @GradeId = 2

