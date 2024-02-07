CREATE TABLE Customer 
   ( 
   Customer_ID VARCHAR(10) NOT NULL, 
   CustomerName VARCHAR(30) NOT NULL, 

Street VARCHAR(40) NOT NULL, 

City VARCHAR(20) NOT NULL, 

State VARCHAR(20) NOT NULL, 

Zipcode CHAR(5) NOT NULL, 

PhoneNumber VARCHAR(10) NOT NULL, 

Email VARCHAR(35) NOT NULL, 

CONSTRAINT Customer_PK PRIMARY KEY (Customer_ID) 

); 

 
 
CREATE TABLE Logininfo 

	( 

              LoginID VARCHAR(10) NOT NULL, 

Customer_ID VARCHAR(10) NOT NULL, 

Passwords VARCHAR(10) NOT NULL, 

CONSTRAINT Loginfo_PK PRIMARY KEY ( LoginID),

CONSTRAINT Customer_FK FOREIGN KEY (Customer_ID)

 REFERENCES Customer(Customer_ID)
 ); 

 
 
  

  

CREATE TABLE Account ( 

    Account_ID VARCHAR(10) NOT NULL, 

    Customer_ID VARCHAR(10) NOT NULL, 

    AccountBalance FLOAT NOT NULL, 

    RoutingNumber VARCHAR(15) NOT NULL, 
	DateOpened DATE NOT NULL, 
    AccountType VARCHAR(20) NOT NULL CHECK(AccountType IN ('SAVINGS',    'CHECKING')), 

    CONSTRAINT Account_PK PRIMARY KEY (Account_ID), 

    CONSTRAINT Account_FK1 FOREIGN KEY (Customer_ID) 

    REFERENCES Customer(Customer_ID) 

); 

  

  

CREATE TABLE SavingsAccount ( 

    Account_ID VARCHAR(10) NOT NULL, 

    InterestRate FLOAT NOT NULL, 
	AccountType VARCHAR(20) NOT NULL,

    CONSTRAINT SavingsAccount_PK PRIMARY KEY (Account_ID), 

    CONSTRAINT SavingsAccount_FK1 FOREIGN KEY (Account_ID) 

    REFERENCES Account(Account_ID), 

    CONSTRAINT SavingsAccount_CHK CHECK (AccountType = 'SAVINGS') 

); 

 CREATE TABLE CheckingAccount ( 

    Account_ID VARCHAR(10) NOT NULL, 

    ATMWithdrawalCap VARCHAR(20), 

    DebitCardIssued VARCHAR(3) CHECK(DebitCardIssued IN ('YES','NO')), 
	AccountType VARCHAR(20) NOT NULL,

    ATMPinDetails VARCHAR(20), 

    CONSTRAINT CheckingAccount_PK PRIMARY KEY (Account_ID), 

    CONSTRAINT CheckingAccount_FK1 FOREIGN KEY (Account_ID) 

    REFERENCES Account(Account_ID), 

    CONSTRAINT CheckingAccount_CHK CHECK (AccountType = 'CHECKING') 

); 

CREATE TABLE Merchant 

	( 

	Merchant_ID VARCHAR(10) NOT NULL, 

           Merchant_Name VARCHAR(50) NOT NULL, 

           Merchant_Email VARCHAR(20) NOT NULL, 

           Street VARCHAR(40) NOT NULL, 

           City VARCHAR(20) NOT NULL, 

           State VARCHAR(20) NOT NULL, 

           Zipcode VARCHAR(5) NOT NULL, 

         CONSTRAINT Merchant_PK PRIMARY KEY (Merchant_ID), 
);
  

CREATE TABLE Transactions ( 

   Transaction_ID VARCHAR(10) NOT NULL, 

    Account_ID VARCHAR(10) NOT NULL, 

    Merchant_ID VARCHAR(10) NOT NULL, 

    AmountTransaction FLOAT NOT NULL, 

    Transdate DATE NOT NULL, 

    TransactionStatus VARCHAR(50) CHECK(TransactionStatus IN        ('CANCELLED','SUCCESSFUL','DISPUTED THEN RESOLVED','DECLINED')), 

    CONSTRAINT Transactions_PK PRIMARY KEY (Transaction_ID), 

    CONSTRAINT Transactions_FK1 FOREIGN KEY (Account_ID) 

    REFERENCES SavingsAccount(Account_ID), 

    CONSTRAINT Transactions_FK2 FOREIGN KEY (Merchant_ID) 

    REFERENCES Merchant(Merchant_ID) 

     ); 


  INSERT INTO Customer (Customer_ID, CustomerName, Street, City, State, Zipcode, PhoneNumber, Email) VALUES 

('C001', 'John Doe',  '123 Main St', 'New York', 'NY', '10001', '555-1234', 'johndoe@gmail.com'), 

('C002', 'Jane Smith', '456 Elm St', 'Los Angeles', 'CA', '90001', '555-5678', 'janesmith@yahoo.com'), 

('C003', 'Bob Johnson',  '789 Oak St', 'Chicago', 'IL', '60601', '555-9876', 'bobjohnson@hotmail.com'), 

('C004', 'Mary Williams',  '1010 Pine St', 'Houston', 'TX', '77002', '555-4321', 'marywilliams@gmail.com'); 

 

INSERT INTO LoginInfo (LoginID, Customer_ID, Password) VALUES 

('L001', 'C001', 'pklj123'), 

('L002', 'C002', 'abcde12345'), 

('L003', 'C003', 'qwertyuiop'), 

('L004', 'C004', 'asdfghjkl;'); 

  

INSERT INTO Account (Account_ID, Customer_ID, AccountBalance, RoutingNumber, AccountType) VALUES 

('A001', 'C001', 1000.00, '123456789', 'SAVINGS','2022-01-01'), 

('A002', 'C001', 2000.00, '123456789', 'CHECKING','2022-01-01'), 

('A003', 'C002', 1500.00, '234567890', 'SAVINGS','2022-01-01'), 

('A004', 'C002', 3000.00, '234567890', 'CHECKING','2022-01-01'); 

  

INSERT INTO SavingsAccount (Account_ID, InterestRate, AccountType) 

VALUES ('A001', 0.05, 'SAVINGS'), 

       ('A002', 0.05, 'SAVINGS'); 
  

INSERT INTO CheckingAccount (Account_ID, ATMWithdrawalCap, DebitCardIssued, AccountType, ATMPinDetails) 

VALUES ('A003', '500', 'YES', 'CHECKING', '1234'), 

       ('A004', '1000', 'NO', 'CHECKING', NULL); 

  

  
  
 
INSERT INTO Transactions(Transaction_ID, Account_ID, Merchant_ID, AmountTransaction, Transdate, TransactionStatus) VALUES 

('T001', 'A001', 'M001', 50.00, '2022-01-15', 'SUCCESSFUL'), 

('T002', 'A002', 'M002', 25.00, '2022-02-28', 'SUCCESSFUL'), 

('T003', 'A003', 'M003', 75.00, '2022-03-15', 'DISPUTED THEN RESOLVED'), 

('T004', 'A004', 'M003', 100.00, '2022-04-30', 'DECLINED'); 


INSERT INTO Merchant (Merchant_ID, Merchant_Name, Merchant_Email, Street, City, State, Zipcode) VALUES 

('M001', 'Amazon', 'contact@amazon.com', '410 Terry Ave', 'Seattle', 'WA', '98109'), 

('M002', 'Walmart', 'contact@walmart.com', '702 SW 8th St', 'Bentonville', 'AR', '72716'), 

('M003', 'Target', 'contact@target.com', '1000 Nicollet Mall', 'Minneapolis', 'MA','02125');

------selecting all of the tables 
Select * from Account;
Select * from Customer;
select * from Transactions;
select * from Merchant ;
select * from CheckingAccount;
select * from SavingsAccount;
select * from Logininfo;

-------Retrieve the account balance, customer name, and account type for all accounts. 
SELECT a.AccountBalance, c.CustomerName, a.AccountType  

FROM Account a 

JOIN Customer c ON a.Customer_ID = c.Customer_ID; 


------Retrieve the transaction amount, transaction date, customer name, and merchant name for all transactions. 

SELECT t.AmountTransaction, t.Transdate, c.CustomerName, m.Merchant_Name 

FROM Transactions t 

JOIN Account a ON t.Account_ID = a.Account_ID 

JOIN Customer c ON a.Customer_ID = c.Customer_ID 

JOIN Merchant m ON t.Merchant_ID = m.Merchant_ID; 

-------Find all checking accounts with an ATM withdrawal cap greater than $500 

SELECT * 

FROM CheckingAccount 

WHERE AccountType = 'CHECKING' AND ATMWithdrawalCap > '$500'; 


------Find all savings accounts with an interest rate less than or equal to 2%: 
SELECT * 

FROM SavingsAccount 

WHERE AccountType = 'SAVINGS' AND InterestRate <= 0.02; 


