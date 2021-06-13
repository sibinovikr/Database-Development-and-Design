create database SEDCHome

--Student
CREATE TABLE dbo.Student
(
   ID int identity(1,1) NOT NULL,
   FirstName nvarchar (50) NOT NULL,
   LastName nvarchar (50) NOT NULL,
   DateOfBirth date NOT NULL,
   EnrolledDate date NOT NULL,
   Gender nchar (1) NOT NULL,
   NationalIDNumber bigint NOT NULL,
   StudentCardNumber int NOT NULL
   CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.Student


--Teacher
CREATE TABLE dbo.Teacher
(
   ID smallint identity(1,1) NOT NULL,
   FirstName nvarchar (50) NOT NULL,
   LastName nvarchar (50) NOT NULL,
   DateOfBirth date NOT NULL,
   AcademicRank nvarchar (50) NOT NULL,
   HireDate date NOT NULL
   CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.Teacher


--Grade
CREATE TABLE dbo.Grade
(
   ID int identity(1,1) NOT NULL,
   StudentID int NOT NULL,
   CourseID smallint NOT NULL,
   TeacherID smallint NOT NULL,   
   Grade tinyint NOT NULL,
   Comment nvarchar (100) NULL,
   CreatedDate datetime NOT NULL
   CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.Grade


--GradeDetails
CREATE TABLE dbo.GradeDetails
(
   ID int identity(1,1) NOT NULL,
   GradeID int NOT NULL,
   AchievementTypeID smallint NOT NULL,
   AchievementPoints int NOT NULL,
   AchievementMaxPoints int NOT NULL,
   AchievementDate date NOT NULL
   CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.GradeDetails


--Course
CREATE TABLE dbo.Course
(
   ID int identity(1,1) NOT NULL,
   Name nvarchar (100) NOT NULL,
   Credit smallint NOT NULL,
   AcademicYear date NOT NULL,   
   Semester tinyint NOT NULL
   CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.Course


--AchievementType
CREATE TABLE dbo.AchievementType
(
   ID smallint identity(1,1) NOT NULL,
   Name nvarchar (100) NOT NULL,
   Description nvarchar (100) NULL,  
   ParticipationRate decimal (18, 2) NOT NULL
   CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED
   (
   [ID] asc
   )
)
SELECT * FROM dbo.AchievementType
