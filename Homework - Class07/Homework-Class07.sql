--Add error handling on CreateGradeDetailprocedure
--Test the error handling by inserting not-existing values for AchievementTypeID

CREATE OR ALTER PROCEDURE dbo.CreateGradeDetail 
(@AchievementTypeID tinyint, @AchievementPoints tinyint, @AchievementMaxPoints tinyint, @AchievementDate datetime, @GradeId int)

AS
BEGIN

BEGIN TRY
INSERT INTO dbo.GradeDetails ([AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate], [GradeID])
VALUES (@AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate, @GradeId)
END TRY

BEGIN CATCH  
SELECT  
    ERROR_NUMBER() AS ErrorNumber, 
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,  
    ERROR_PROCEDURE() AS ErrorProcedure,  
    ERROR_LINE() AS ErrorLine,  
    ERROR_MESSAGE() AS ErrorMessage  
END CATCH

SELECT sum(gd.AchievementPoints/gd.AchievementMaxPoints*aty.ParticipationRate) as GradePoints
FROM dbo.[GradeDetails] gd
INNER JOIN dbo.AchievementType aty on aty.id = gd.AchievementTypeID
WHERE gd.AchievementTypeID = @AchievementTypeID	

END


exec dbo.CreateGradeDetail @AchievementTypeID = 4, @AchievementPoints = 3, @AchievementMaxPoints = 5, @AchievementDate = '2021.06.21', @GradeId = 2