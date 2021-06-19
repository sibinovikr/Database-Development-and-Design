--1--
CREATE TABLE [dbo].[BusinessentityDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessentityID] [int] NOT NULL,
	[AccountNumber] [nvarchar] (15) NOT NULL,
	[Address] [nvarchar](250) NOT NULL,
	[Contact] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[Comment] [nvarchar] (max) NULL,
 CONSTRAINT [PK_BusinessentityDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

ALTER TABLE [dbo].[BusinessentityDetails] 
ADD CONSTRAINT [FK_Businessentity_dtailsID] 
FOREIGN KEY ([BusinessEntityId]) 
REFERENCES [dbo].[BusinessEntity]([Id]);


--2--
ALTER TABLE [dbo].[BusinessentityDetails] WITH CHECK
ADD CONSTRAINT UC_Businessentity_Details 
UNIQUE (AccountNumber)

ALTER TABLE [dbo].[BusinessentityDetails] WITH CHECK
ADD CONSTRAINT CHK_BusinessentityDetails_Email
CHECK (Email like '%@%.%')

ALTER TABLE [dbo].[BusinessentityDetails] WITH CHECK
ADD CONSTRAINT CHK_BusinessentityDetails_Contact
CHECK (substring (Contact, 1, 2 ) ='07')

--3--
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(1,'210500222333','Partizanski Odredi 15','070555666','aaa@vitalia.com','Nema zabeleshka')
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(2,'210500222334','XXXX 15','070779523','bbb@vitalia.com',NULL)
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(3,'210500222335','XXXX 16','070779523','ccc@vitalia.com','TEST 1')
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(4,'210500222377','XXXX 17','070779523','ddd@vitalia1.com',NULL)
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(5,'210500222336','XXXX 18','070779544','vvv@vitalia.com','Nema plateno faktura')
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(6,'210500222337','XXXX 19','070779555','ddd@vitalia.com',NULL)
go
insert into dbo.BusinessentityDetails (BusinessentityID,AccountNumber,[Address],Contact,email,comment)
values(6,'210500222338','XXXX 20','070779566','aa@vitalia.com','Nevaliden kontakt')
go


select *
from dbo.BusinessentityDetails

--4--
UPDATE dbo.BusinessentityDetails
set Comment = 'Nema zabeleshka za smetka'

--5--
CREATE FUNCTION dbo.fn_ProductQuantitySold (@ProductId int)RETURNS decimal (18,2)asBEGIN
DECLARE @Result decimal(18,2)
select @Result = sum(od.Quantity)
from dbo.Product p 
inner join dbo.OrderDetails od on p.Id = od.ProductId
WHERE p.Id = @ProductId
RETURN @ResultEND

select dbo.fn_ProductQuantitySold (1)--6--CREATE FUNCTION dbo.fn_ProductPriceSold (@ProductId int)RETURNS decimal (18,2)asBEGIN
DECLARE @Result decimal(18,2)
select @Result = sum(od.Price)
from dbo.Product p 
inner join dbo.OrderDetails od on p.Id = od.ProductId
WHERE p.Id = @ProductId
RETURN @ResultEND

select dbo.fn_ProductPriceSold (1) as ProductPrice--7--/*Create view dbo.vv_report that returns the following columns:
[Регион] – concatenate zipcode and region with – separator
[Број на сметка] – AccountNumber
[Адреса] – replace XXXX with ‘Улица број’
[Име на продукт] – ProductName
[Количина] – Result from function fn_ ProductQuantitySold
[Цена] – Result from function fn_ProductPriceSold*/


CREATE VIEW vv_report
AS 
SELECT concat(be.Zipcode, ' - ', be.Region) as 'Регион', 
bd.AccountNumber as 'Број на сметка',
replace(bd.Address, 'XXXX', 'Улица број') as 'Адреса', 
p.Name as 'Име на продукт', dbo.fn_ProductQuantitySold(ProductId) as 'Количина', 
dbo.fn_ProductPriceSold(ProductId) as 'Цена'

from dbo.[Order] as o
inner join dbo.BusinessEntity as be on be.id = o.BusinessEntityId
inner join dbo.BusinessentityDetails as bd on  bd.BusinessentityID = be.Id
inner join dbo.OrderDetails as od on od.OrderId = o.Id
inner join dbo.Product as p on p.Id = od.ProductId

SELECT *
FROM vv_report