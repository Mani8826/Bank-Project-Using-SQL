Create database MSBank

USE  MSBank
go

create table UserLogins----------------------table 1
(
UserLoginID smallint not null primary key,
UserLogin char (15),
UserPassword varchar (20)
)
Insert into UserLogins Values (11,'macrayat','macrayat123'),------table 1
                              (12,'Zein','Zein123'),
							  (13,'Frank','Frank123'),
							  (14,'Humera','Humera123'),
							  (15,'Leticia','Leticia123')
go

delete UserLogins

go

select* from UserLogins

go

create table UserSecurityQuestions------------table 2
(
UserSecurityQuestionID tinyint not null primary key,
UserSecurityQuestion varchar(50)
)

go
Insert into UserSecurityQuestions values (21,'What Is your favorite book'),------table 2
                                         (22,'What is your mothers maiden name'),
							             (23,'Where did you go to high school/college'),
							             (24,'What is your favorite food'),
							             (25,'What city were you born in')
										
go

delete UserSecurityQuestions

go									
select *from UserSecurityQuestions

go
create table AccountType-----------------------table 3
(
AccountTypeID tinyint not null primary key,
AccountTypeDescription varchar(30)
)

go

insert into AccountType values(31,'Checking Account'),-------table 3
                              (32,'Saving Account'),
							  (33,'Tax Free Saving Account'),
							  (34,'RRSP Account'),
							  (35,'Money market Account')
go

delete AccountType 

go

Select *from AccountType
go

drop table AccountStatusType

go

create table AccountStatusType-----------------table 4
(
AccountStatusTypeID tinyint not null primary key,
AccountTypeDescription varchar (3000)
)

go

Insert into AccountStatusType values( 41,'Deposit Checks, Pay Bills, and make Withdrawals'),---table 4
                                    (42,'Depositing Money and Maintaining a Balance in the Account'),
									(43,'Interest Earned, Dividends, and Capital Gains are not Taxed'),
									(44,' Vehicle For Employees and the Self-Employed '),
									(45,'Connection to the Stock Market ')
go
Alter table AccountStatusType
alter column AccountTypeDescription varchar (3000)

go

select *from AccountStatusType

go

create table SavingsInterestRates------------table 5
(
InterestSavingsRatesID tinyint not null primary key,
InterestRateValue numeric(4,2),
InterestRateDescription varchar (20)
)
go
Insert into SavingsInterestRates values (51,2.15,'Prime rate'),
                                        (52,2.17,'Annual Rate'),
                                        (53,5.24,'Varriable Rate'),
                                        (54,3.13,'Fixed Rate'),
                                        (55,5.43,'Compound Rate')
go
Alter table SavingsInterestRates
alter column InterestRateValue numeric(4,2) -- 1234.99

Select *from SavingsInterestRates


create table LoginErrorLog--------------------table 6
(
ErrorLoginID int not null primary key,
ErrorTime datetime ,
FailedTransactionXML xml
)
Insert into LoginErrorLog values (61,CONVERT(datetime, '2020-07-05', 120),'Double Check the Credit card Information you Have Entered'),
                                 (62,CONVERT(datetime, '2020-06-20', 120),'Check whether Your credit card has not expired'), 
								 (63,CONVERT(datetime, '2020-05-27', 120),'Exceed Credit card Limit'),
								 (64,CONVERT(datetime, '2020-04-15', 120),'Cross-Border or overseas transactions'),
								 (65,CONVERT(datetime, '2020-03-13', 120),'Cross-Border or overseas transactions')
go
Update LoginErrorLog 
set Errortime =CONVERT(datetime, '2020-08-16', 120) where ErrorLoginID=65
Select * from LoginErrorLog

go

create table FailedTransactionErrorType----------table 7
(
FailedTransactionErrorTypeID tinyint not null primary key,
FailedTransactionDescription varchar (50)
)

go

Insert into FailedTransactionErrorType values (71,'Expiry date of Card'),------table 7
                                              (72,'Maximum limits' ),
											  (73,'Bank Server Down'),
											  (74,'Information Mismatch'),
											  (75,'Overseas transaction')

 go

 Select * from FailedTransactionErrorType
 go

create table FailedTransactionLog------------table 8
(
FailedTransactionID int not null primary key,
FailedTransactionErrorTypeID tinyint foreign key references FailedTransactionErrorType(FailedTransactionErrorTypeID),
FailedTransactionErrorTime datetime,
FailedTransactionXML xml
)
go

Insert into FailedTransactionLog values       (8002,71,CONVERT(datetime, '2020-07-05', 120),'Expiry date of Card'),
                                              (8003,72,CONVERT(datetime, '2020-06-20', 120),'Maximum limits' ),
	                                          (8004,73,CONVERT(datetime, '2020-05-27', 120),'Bank Server Down'),
	                                          (8005,74,CONVERT(datetime, '2020-04-15', 120),'Information Mismatch'),
	                                          (8006,75,CONVERT(datetime, '2020-03-13', 120),'Overseas transaction')

go
select * from FailedTransactionLog


create table TransactionType-----------------table 9
(
TransactionTypeID tinyint not null primary key,
TransactionTypeName char(10),
TransactionTypeDescription varchar (50),
TransactionTypeFreeAmount smallmoney
)
Insert into TransactionType values (90,'Withdrawal','withdraw funds by paper cheque',$500),--Table 9
                                   (91, 'deposit', 'deposit cash',$1000),
								   (92, 'ATM','withdraw funds by ATM',$700),
								   (93,'E-transfer','transfer funds to another account',$900),
								   (94,'Interac',' electronic transfer of funds',$1200)
Go
Select * from TransactionType

INSERT INTO TestMoney VALUES (1, $123.45)-----example

INSERT INTO table_name (bit_column)
VALUES (0);
--You can also use TRUE and FALSE as the inputs for the BIT columns, SQL Server will automatically convert them as follow:

--TRUE will be converted to 1
--FALSE will be converted to 0
go
Create table Employee-----------table 10
(
EmployeeID int not null primary key,
EmployeeFirstName varchar(25),
EmployeeMiddleInitial char (1),
EmployeeLastName varchar(25),
EmployeeIsManager bit
)
go
Insert into Employee values (101,'Hamid','R','Professor',1),--Table 10
                            (102,'Harbir','K','wife',1),
							(103,'Rupinder','G','friend',1),
							(104,'sumit','G','friend',0),
							(105,'satwinder','K','mom',1)
go
select* from Employee
go



create table TransactionLog----------table 11
(
TransactionID int not null primary key,
TransactionDate datetime,
TransactionTypeID tinyint foreign key references TransactionType(TransactionTypeID),
TransactionAmount money,
NewBalance money,
AccountID int foreign key references Account(AccountID),
CustomerID int  foreign key references Customer(CustomerID) ,
EmployeeID int foreign key references Employee(EmployeeID),
UserLoginID smallint foreign key references UserLogins (UserLoginID)
)
go
Insert into TransactionLog values(1101,CONVERT(datetime, '2020-07-05', 120),90,100,2500,1201,115,101,11),
                                 (1102,CONVERT(datetime, '2020-08-05', 120),91,150,2400,1202,116,102,12),
								 (1103,CONVERT(datetime, '2020-09-05', 120),92,300,2000,1203,117,103,13),
								 (1104,CONVERT(datetime, '2020-10-05', 120),93,200,5000,1204,118,104,14),
								 (1105,CONVERT(datetime, '2020-11-05', 120),94,390,7000,1205,119,105,15)
go
 Select * from TransactionLog 


create table Account----------table12
(
AccountID int not null primary key,
CurrentBalance int,
AccountTypeID tinyint foreign key references AccountType(AccountTypeID),
AccountStatusTypeID tinyint foreign key references AccountStatusType(AccountStatusTypeID),
InterestSavingsRateID tinyint 
)
alter table Account Add foreign key (InterestSavingsRateID) references SavingsInterestRates(InterestSavingsRatesID)

Insert into Account values (1201,10000,31,41,51),
                           (1202,20000,32,42,52),
						   (1203,30000,33,43,53),
						   (1204,$40000,34,44,54),
				           (1205,$50000,35,45,55)
go
Select * from Account

create table OverDraftLog------table13
(
AccountID int not null primary key foreign key references Account(AccountID),
OverDraftDate datetime,
OverDraftAmount money,
OverDraftTransactionXML XML
)
go
insert into OverDraftLog values(1201,CONVERT(datetime, '2020-07-05', 120),$10000,'cheque'),
                               (1202,CONVERT(datetime, '2020-08-05', 120),$5000,'ATM'),
							   (1203,CONVERT(datetime, '2020-09-05', 120),$2500,'transfer'),
							   (1204,CONVERT(datetime, '2020-10-05', 120),$1000,'POS'),
							   (1205,CONVERT(datetime, '2020-11-05', 120),$1500,'cheque')
go
select * from OverDraftLog





create table [Login-Account]-----------table 14
(
UserLoginID Smallint foreign key references UserLogins(UserLoginID),
AccountID int foreign key references Account(AccountID)
)
go
insert into [Login-Account] values(11,1201),
                                  (12,1202),
								  (13,1203),
								  (14,1204),
								  (15,1205)
go
select * from [Login-Account]
select * from Customer

Create table Customer------------------table 15
(
CustomerID int not null primary key,
AccountID int foreign key references Account(AccountID),
CustomerAddress1 varchar(30),
CustomerAddress2 varchar(30),
CustomerFirstName varchar(30),
CustomerMiddleIntial char(1),
CustomerLastName varchar(30),
City Varchar(20),
State char(2),
Zipcode char (10),
EmailAddress varchar (40),
HomePhone char(10),
CellPhone char(10),
WorkPhone char(10),
SSN char(9),
UserLoginID smallint foreign key references UserLogins(UserLoginId)
)
go
insert into Customer values(115,1201,'eight','marycroft','mac','s','rayat','brampton','ON','abcd','abcd@gmail.com',123456789,78945612,456789,789456,11),
                           (116,1202,'eighty','kingscross','harry','k','rayat','London','ON','hssy','ksxushxj@gmail.com',846254266,7662426255,5754656,25451234,12),
						   (117,1203,'nine','knb','joe','r','keith','Toronto','ON','hsiy',' sasmk@gmail.com',123456789,78945612,456789,789456,13),
						   (118,1204,'six','jingle','jack','b','rabba','Oshawa','ON','isid','smaxjsjxn@gmail.com',123456789,78945612,456789,789456,14),
						   (119,1205,'five','zia','levy','s','sharma','Kitchener','ON','bxhg','sanjkxn@gmail.com',123456789,78945612,456789,789456,15)

go
Select * from Customer

Create table [Customer-Account] -------table16
(
AccountID int not null  foreign  key references Account (AccountID),
CustomerID int not null  foreign key references Customer(CustomerID)
)
go
insert into [Customer-Account] values(1201,115),
                                     (1202,116),
									 (1203,117),
									 (1204,118),
									 (1205,119)
go
select * from [Customer-Account]


create table TransactionLog----------table17
(
TransactionID int not null primary key,
TransactionDate datetime,
TransactionTypeID tinyint foreign key references TransactionType(TransactionTypeID),
TransactionAmount money,
NewBalance money,
AccountID int foreign key references Account(AccountID),
CustomerID int foreign key references Customer(CustomerID),
EmployeeID int foreign key references Employee(EmployeeID),
UserLoginID smallint foreign key references UserLogins(UserLoginID)
)
go
insert into TransactionLog values (1000, CONVERT(datetime, '2020-07-05', 120),90,$1000,$15000,1201,115,101,11),
                                  (1001, CONVERT(datetime, '2020-08-05', 120),91,$5000,$2000,1202,116,102,12),
								  (1002, CONVERT(datetime, '2020-09-05', 120),92,$500,$1500,1203,117,103,13),
								  (1003, CONVERT(datetime, '2020-10-05', 120),93,$200,$1000,1204,118,104,14),
								  (1004, CONVERT(datetime, '2020-11-05', 120),94,$300,$8000,1205,119,105,15)
go
select * from TransactionLog

create table UserSecurityAnswer--------table 18
(
UserloginID smallint not null primary key foreign key references UserLogins (UserloginID),
UserSecurityAnswer varchar(25),
UserSecurityQuestionID tinyint foreign key references UserSecurityQuestions(UserSecurityQuestionID)
)
go
insert into UserSecurityAnswer values (11,'database science',21),
                                      (12,'satwinder',22),
									  (13,'india',23),
									  (14,'burger',24),
									  (15,'chandigarh',25)
go
select * from UserSecurityAnswer
----------------------------------------------------------------------------------------------
go
Question:  1.Create a view to get all customers with checking account from ON province?

Answer:1

Create view CustomerMS-----------------with checking  Account from ON Province
as
select C.CustomerID,c.CustomerFirstName+' '+c.CustomerLastName [Customer Name],c.state,at.AccountTypeDescription
from Customer c 
  join [Customer-Account] ca 
   on C.CustomerID=ca.CustomerID
   join Account a
   on ca.AccountID=a.AccountID
   join AccountType at
   on a.AccountTypeID=at.AccountTypeID
where at.AccountTypeDescription='Checking account' and c.State='ON';

go

Select * from CustomerMS

go
select* from Customer 
select* from Account
select* from AccountType
select* from [dbo].[Customer-Account]



go
------------------------------------------------------------------------------------------------------------------------------------
Question:2	Create a view to get all customers with total account balance (including interest rate) greater than 5000?
Answser: 2
Create view customer_account_greater_5000_with_interest 
as 
select c.customerid, A. CurrentBalance,sir.InterestSavingsRatesID
from 
customer c Join [customer-account] ca on c.customerId = ca.customerId
Join Account a on ca.accountid = a.accountid
Join savingsInterestRates sir on a.InterestSavingsRateID = sir.InterestSavingsRatesID
where a.currentbalance > 5000
go

select * from customer_account_greater_5000_with_interest 
as 
drop view t_gt_5000_with_interest
go
----------------------------------------------------------------------------------------------------
Quetion:3 Create a view to get counts of checking and savings accounts by customer ?
Answer: 3
create view CountscheckingsavingsbyCustomersinformation
as
select ATD.AccountTypeDescription, count (C.CustomerID)[COUNTS BY Customer]
From Customer C inner join [Customer-Account] CA ON C.CustomerID=CA.CustomerID
     inner Join Account A ON CA.AccountID= A.AccountID 
	 inner join AccountType ATD ON A.AccountTypeID=ATD.AccountTypeID
Group by ATD.AccountTypeDescription
Having ATD.AccountTypeDescription in( 'Checking Account','Saving Account')

go

select * from  CountscheckingsavingsbyCustomersinformation
go

select * from Customer
select * from [Customer-Account]
select * from Account
select * from AccountType

--------------------------------------------------------------------------------------------
Question: 4 Create a view to get any particular user’s login and password using AccountId?
Answer:4

use [Sqlexam]

go
select *
from UserAccountS
where EmailAddress is not null


select *from UserAccountS
where lastName like '%ith';

select *
from UserAccountS






















select *
from UserAccountS
where Age >= 50 and Age <= 80;


Alter Table UserAccountS
ADD AccountType nvarchar(30);
select * from UserAccountS



Alter Table UserAccountS
Drop Column AccountType;

select * from UserAccountS


Delete UserAccountS
where lastName = 'Weber-Williams'

select * from UserAccountS
go

Update UserAccountS
Set Age = (Age+1)
Where FirstName='Dirk' and lastName= 'Smith';

select * from UserAccountS

Delete UserAccountS

select * from UserAccountS



Drop table UserAccountS

Select * from UserAccountS

go

create table Employee
(
firstname varchar(30),
lastname varchar (30),
Id int,
Age numeric (20),
city char (20),
state char (20)
)
Select* from Employee

drop table Employee
(
insert into Employee values
('john','jones',99980,45,'payson','arizona'),
('mary','jones',99982,25,'payson','arizona'),
('eric','edwards',88232,32,'san diego','california'),
('mary ann','edwards',88233,32,'phoenix','arizona'),
('ginger','howell',98002,42,'cottonwood','arizona'),
('sebastian','smith',92001,23,'gila bend','arizona'),
('gus','gray',22322,35,'bagdad','arizona'),
('mary ann','may',32326,52,'tucson','arizona'),
('erica','williams',32327,60,'show low','arizona'),
('leroy','brown',32380,22,'pinetop','arizona'),
('elroy','cleaver',32382,22,'globe','arizona')

Select First, last, City
from Employee
where city not like 'P%




Create view loginPassword
as
select  A.AccountID,U.UserLogin, U.UserPassword
from  UserLogins U join[Login-Account] LA ON U.UserLoginID=LA.UserloginID 
  join Account A ON LA.AccountID=A.AccountID

  go

Select * from loginPassword  
go
select * from [dbo].[UserLogins]
 select * from [Login-Account]
 select * from Account 

 go
 --------------------------------------------------------------------------------------------
Question :5 Create a view to get all customers’ overdraft amount ?
Answer:5
create view customeroverdrafftamount 
as
select C.CustomerFirstName+' '+c.CustomerLastName [Customer Name],OD.OverDraftAmount
from OverDraftLog OD join Customer C ON OD.AccountID =C.AccountID
     join [Customer-Account] CA ON C.AccountID=CA.AccountID
	 join Account A ON CA.AccountID=A.AccountID

Select * from customeroverdrafftamount 

go
select* from[dbo].[OverDraftLog]
select * from Account
Select* from [dbo].[Customer-Account]
select * from Customer
go
-------------------------------------------------------------------------------------------------
Question:6 Create a stored procedure to add “User_” as a prefix to everyone’s login (username)?
Answer :6
create proc prefixusername
as
select UserLogin username,'User_'+UserLogin User_username from UserLogins
exec prefixusername

go
-----------------------------------------------------------------------------------------------------
Question: 7 Create a stored procedure that accepts AccountId as a parameter and returns customer’s full name?
Answer:7
create proc  UdateFullName @AccountID int, @Fullname nvarchar(100) output
as
  if (@AccountID in (select AccountID from Customer))
	   select @Fullname=c.customerFirstName+' '+c.[CustomerMiddleIntial]+' '+c.customerLastName
	   from customer C
  else
    print 'None'

Declare @FullName nvarchar(100)
exec   UdateFullName 1205, @FullName out
select @FullName FullName

Declare @FullName nvarchar(100)
exec   UdateFullName 400522, @FullName out
select @FullName FullName

drop proc UdateFullName
select * from [dbo].[Customer]
exec UdateFullName
 ------------------------------------------------------------------------------------------------
Question: 8 Create a stored procedure that returns error logs inserted in the last 24 hours? 
Answer:8
create proc Errorlog
as
select * from LoginErrorLog where ErrorTime > dateadd(hour,-24,getdate())

exec Errorlog

go
-------------------------------------------------------------------------------------------------------------------
Question :9 Create a stored procedure that takes a deposit as a parameter and updates CurrentBalance value for that particular account?
Answer:9
create proc TDdepoist @T money,@M int out,@AMT money out,@MOUT varchar(30) out,@OT money out, @MO money out,@MV money out
as
  select @M=A.AccountID,@AMT=A.CurrentBalance,@MOUT=TT.TransactionTypeName,@OT=@T,@MO=A.CurrentBalance+@T
    from Account A join TransactionLog MA on A.AccountID=MA.AccountID
                   join TransactionType TT on MA.TransactionTypeID=TT.TransactionTypeID
    where TransactionTypeName='deposit'
  select @M=a.AccountID,@MV=a.CurrentBalance+@T
    from Account A join TransactionLog MA on A.AccountID=MA.AccountID
    where A.AccountID=@M
  update Account set CurrentBalance=@MO where AccountID=@M

declare @MN int,@AMTN money,@MOUTN varchar(30),@OTN money, @MON money,@MVN money
exec TDdepoist 500,@MN out,@AMTN out,@MOUTN out,@OTN out, @MON out,@MVN out
select @MN AccountID,@AMTN CurrentBalance,@MOUTN TransactionType,@OTN TransactionAmount,@MON NewBalance
select @MN AccountID,@MVN CurrentBalance

go
---------------------------------------------------------------------------------------------------------------------
Question :10 Create a stored procedure that takes a withdrawal amount as a parameter and updates CurrentBalance value for that particular account. [Advanced]

Answer: 10
create proc TDwithdrawal @T money,@M int out,@AMT money out,@MOUT varchar(30) out,@OT money out, @MO money out,@MV money out
as
  select @M=A.AccountID,@AMT=A.CurrentBalance,@MOUT=TT.TransactionTypeName,@OT=@T,@MO=A.CurrentBalance-@T
    from Account A join TransactionLog MA on A.AccountID=MA.AccountID
                   join TransactionType TT on MA.TransactionTypeID=TT.TransactionTypeID
    where TransactionTypeName='withdrawal'
  select @M=a.AccountID,@MV=a.CurrentBalance-@T
    from Account A join TransactionLog MA on A.AccountID=MA.AccountID
    where a.AccountID=@M
  update Account set CurrentBalance=@MO where AccountID=@M

declare @MN int,@AMTN money,@MOUTN varchar(30),@OTN money, @MON money,@MVN money
exec TDwithdrawal 1000,@MN out,@AMTN out,@MOUTN out,@OTN out, @MON out,@MVN out
select @MN AccountID,@AMTN CurrentBalance,@MOUTN TransactionType,@OTN TransactionAmount,@MON NewBalance
select @MN AccountID,@MVN CurrentBalance


go

-----------------------------------BANK PROJECT AUGUST/16/2020-----------------------------------------------------------------
