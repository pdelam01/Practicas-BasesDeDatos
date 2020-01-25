CREATE TABLE SHOPS
( ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, FloorsNumber INT DEFAULT 10
, EmployeesNumber INT CHECK (EmployeesNumber>0)
, Surface INT DEFAULT 20000
, PhoneNumber CHAR(9) CHECK (PhoneNumber LIKE ('987[0-9][0-9][0-9][0-9][0-9][0-9]'))
, Zip CHAR(5) not null CHECK (Zip LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, Street VARCHAR (25) not null
, City VARCHAR (25) not null
, CONSTRAINT PK_SHOPS PRIMARY KEY(ShopID)
);
 
CREATE TABLE PHONENUMBERSHOPS
( PhoneNumber CHAR(9) CHECK (PhoneNumber LIKE ('987[0-9][0-9][0-9][0-9][0-9][0-9]'))
, ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERSHOPS PRIMARY KEY (PhoneNumber, ShopID)
, CONSTRAINT FK_PHONENUMBERSHOPS FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);
 
CREATE TABLE EMPLOYEES
( SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, NameEmp VARCHAR(20) not null
, SurnameEmp VARCHAR(25) not null
, Birthday DATE not null 
, EmailAddress NVARCHAR (25) CHECK (EmailAddress LIKE '%_@__%.__%')
, PhoneNumber CHAR(9) CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR (24)
, Street VARCHAR (50)
, Age INT
, City VARCHAR(25) not null
, Zip CHAR(5) CHECK (Zip LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, Sex CHAR CHECK (Sex IN ('M','F','O'))
, EmployeeDNI VARCHAR(9) not null CHECK (EmployeeDNI LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
, HoursWeek INT DEFAULT 40
, YearsInCompany INT DEFAULT 0 
, Nationality VARCHAR (30) DEFAULT 'Español'
, Category VARCHAR (20) not null CHECK (Category IN ('Manager','Customer supporter','Dependent','Security worker','Web designer'))
, CONSTRAINT PK_EMPLOYEES PRIMARY KEY(SSN));
 
CREATE TABLE PHONENUMBEREMP
( PhoneNumber CHAR(9) not null CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBEREMP PRIMARY KEY (PhoneNumber, SSN)
, CONSTRAINT FK_PHONENUMBEREMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE EMAILADDRESSEMP
( EmailAddress NVARCHAR (25) not null CHECK (EmailAddress LIKE '%_@__%.__%')
, SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSEMP PRIMARY KEY (EmailAddress, SSN)
, CONSTRAINT FK_EMAILADDRESSEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE BANKACCOUNTEMP
( CountryCode CHAR (2)  not null DEFAULT 'ES'
, ControlDigit CHAR(2) not null CHECK (ControlDigit LIKE ('[0-9][0-9]'))
, Entity CHAR(4) not null CHECK (Entity LIKE ('[0-9][0-9][0-9][0-9]'))
, Branch CHAR(4) not null CHECK (Branch LIKE ('[0-9][0-9][0-9][0-9]'))
, ControlDigit2 CHAR(2) not null CHECK (ControlDigit2 LIKE ('[0-9][0-9]'))
, AccountNumber CHAR(10) not null CHECK (AccountNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTEMP PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, SSN)
, CONSTRAINT FK_BANKACCOUNTEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
, CONSTRAINT CK_BANKACCOUNTEMP CHECK (CountryCode LIKE ('[A-Z][A-Z]'))
);
 
 CREATE TABLE NATIONALITYEMP
( Nationality VARCHAR(30) not null
, SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_NATIONALITYEMP PRIMARY KEY (Nationality, SSN)
, CONSTRAINT FK_NATIONALITYEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN) );
 
CREATE TABLE PRODUCTS
( UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, NamePro VARCHAR (50)
, Quantity INT DEFAULT 50
, Brand VARCHAR (50) not null
, Price MONEY CHECK (Price<10000)
, Category VARCHAR(10) CHECK (Category IN ('Sports','Cosmetics','Food','Technology','Clothes'))
, CONSTRAINT PK_PRODUCTS PRIMARY KEY(UPC)
);
 
CREATE TABLE SUPPLIERS
( SuppliersCode CHAR(10) not null CHECK (SuppliersCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR (24)
, PhoneNumber CHAR(9) CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, EmailAddress NVARCHAR (25) CHECK (EmailAddress LIKE '%_@__%.__%')
, Zip CHAR(5) CHECK (Zip LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, Street VARCHAR (50) not null
, City VARCHAR (25) not null DEFAULT 'Madrid'
, Price MONEY CHECK (Price>0)
, Fax CHAR(9) CHECK (Fax LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Legal_Representative VARCHAR(25) not null
, SuppName VARCHAR(25) not null
, Category CHAR not null CHECK (Category IN ('I','N'))
, CONSTRAINT PK_SUPPLIERS PRIMARY KEY (SuppliersCode)
);
 
CREATE TABLE PHONENUMBERSUPP
( PhoneNumber CHAR(9) not null CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode CHAR(10) not null CHECK (SuppliersCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERSUPP PRIMARY KEY (PhoneNumber, SuppliersCode)
, CONSTRAINT FK_PHONENUMBERSUPP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
);
 
CREATE TABLE EMAILADDRESSSUPP
( EmailAddress NVARCHAR (25) not null CHECK (EmailAddress LIKE '%_@__%.__%')
, SuppliersCode CHAR(10) not null CHECK (SuppliersCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSSUPP PRIMARY KEY (EmailAddress, SuppliersCode)
, CONSTRAINT FK_EMAILADDRESSSUPP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
);
 
CREATE TABLE BANKACCOUNTSUP
( CountryCode CHAR (2)  not null DEFAULT 'ES'
, ControlDigit CHAR(2) not null CHECK (ControlDigit LIKE ('[0-9][0-9]'))
, Entity CHAR(4) not null CHECK (Entity LIKE ('[0-9][0-9][0-9][0-9]'))
, Branch CHAR(4) not null CHECK (Branch LIKE ('[0-9][0-9][0-9][0-9]'))
, ControlDigit2 CHAR(2) not null CHECK (ControlDigit2 LIKE ('[0-9][0-9]'))
, AccountNumber CHAR(10) not null CHECK (AccountNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode CHAR(10) not null CHECK (SuppliersCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTSUP PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, SuppliersCode)
, CONSTRAINT FK_BANKACCOUNTSUP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
, CONSTRAINT CK_BANKACCOUNTSUP CHECK (CountryCode LIKE ('[A-Z][A-Z]'))
);
 
CREATE TABLE INTERNATIONALSTATE(
 IntSuppCode CHAR(10) not null CHECK (IntSuppCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Country VARCHAR(25) 
, TaxNumber CHAR(8) not null CHECK (TaxNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][A-Z][A-Z][A-Z]'))
, CONSTRAINT PK_SUPPLIERSINT PRIMARY KEY (IntSuppCode)
, CONSTRAINT FK_SUPPLIERSINT FOREIGN KEY (IntSuppCode) REFERENCES SUPPLIERS(SuppliersCode)
);

 CREATE TABLE NATIONALSTATE(
 NatSuppCode CHAR(10) not null CHECK (NatSuppCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, City VARCHAR(25) 
, CONSTRAINT PK_SUPPLIERSNAT PRIMARY KEY (NatSuppCode)
, CONSTRAINT FK_SUPPLIERSNAT FOREIGN KEY (NatSuppCode) REFERENCES SUPPLIERS(SuppliersCode)
);
 

CREATE TABLE DEPARTMENTS
( DepartmentCode CHAR not null CHECK (DepartmentCode LIKE ('[1-5]'))
, EmployeesNumber INT not null CHECK (EmployeesNumber>0)
, DepartmentName VARCHAR (10) not null CHECK (DepartmentName IN ('Food','Technology','Sports','Cosmetics','Clothes'))
, CONSTRAINT PK_DEPARTMENTS PRIMARY KEY(DepartmentCode)
);
 
CREATE TABLE MANAGER
( ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TitleOfUniversity VARCHAR(50) DEFAULT 'Collage'
, CONSTRAINT PK_MANAGER PRIMARY KEY (ManagerSSN)
, CONSTRAINT FK_MANAGER FOREIGN KEY (ManagerSSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE DEPENDENTEMP
( DependentSSN CHAR(10) not null CHECK (DependentSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentPasswd VARCHAR (4) not null CHECK (DependentPasswd LIKE ('[0-9][0-9][a-z][0-9]'))
, LanguageLevel VARCHAR (2) DEFAULT 'B1'
, DepartmentName VARCHAR (10) CHECK (DepartmentName IN ('Food','Technology','Sports','Cosmetics','Clothes'))
, CONSTRAINT PK_DEPENDENTS PRIMARY KEY (DependentSSN)
, CONSTRAINT FK_DEPENDENTS FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_DEPENDENTS2 FOREIGN KEY (DependentSSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE SALES
( ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentSSN CHAR(10) not null CHECK (DependentSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Datesale DATE not null DEFAULT getdate()
, Quantity INT DEFAULT 1
, CONSTRAINT PK_SALES PRIMARY KEY (ShopID, DependentSSN, Datesale)
, CONSTRAINT FK_DEPENDENTSSN FOREIGN KEY (DependentSSN) REFERENCES DEPENDENTEMP(DependentSSN)
, CONSTRAINT SK_QUANTITY CHECK (Quantity<1000));
 
CREATE TABLE CUSTOMERSUPPORTER
( CusSuppSSN CHAR(10) not null CHECK (CusSuppSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CustomerSuppPasswd VARCHAR (4) not null CHECK (CustomerSuppPasswd LIKE ('[0-9][0-9][a-z][0-9]'))
, LanguageLevel VARCHAR (2) DEFAULT 'B2'
, CONSTRAINT PK_CUSSUPPSSN PRIMARY KEY (CusSuppSSN)
, CONSTRAINT FK_CUSTOMERSUPPORTER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_CUSTOMERSUPPORTER2 FOREIGN KEY (CusSuppSSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE WEBDESIGNER
( WebDesignerSSN CHAR(10) not null CHECK (WebDesignerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TitleOfUniversity VARCHAR (50) DEFAULT 'Collage'
, ExtraHours INT CHECK (ExtraHours<4 AND ExtraHours>0)
, CONSTRAINT PK_WEBDESIGNER PRIMARY KEY (WebDesignerSSN)
, CONSTRAINT FK_WEBDESIGNER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_WEBDESIGNER2 FOREIGN KEY (WebDesignerSSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE SECURITYWORKER
( SecWorkerSSN CHAR(10) not null CHECK (SecWorkerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_SECURITYWORKER PRIMARY KEY (SecWorkerSSN)
, CONSTRAINT FK_SECURITYWORKER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_SECURITYWORKER2 FOREIGN KEY (SecWorkerSSN) REFERENCES EMPLOYEES(SSN)
);
 


CREATE TABLE PAYROLLS
( SSN CHAR(10) not null CHECK (SSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DatePayroll DATE not null DEFAULT getdate()
, Amount MONEY 
, CONSTRAINT PK_PAYROLLS PRIMARY KEY (SSN, DatePayroll)
, CONSTRAINT FK_PAYROLLS FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);
 
CREATE TABLE WAREHOUSE
( WarehouseCode CHAR(3) not null CHECK (WarehouseCode LIKE ('[0-9][0-9][0-9]'))
, ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_WAREHOUSE PRIMARY KEY (WarehouseCode, ShopID)
, CONSTRAINT FK_WAREHOUSE FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);
 
CREATE TABLE CLIENTS
( ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, EmailAddress NVARCHAR (25) CHECK (EmailAddress LIKE '%_@__%.__%')
, PhoneNumber  CHAR(9) CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR (24)
, Province VARCHAR(25) not null
, City VARCHAR (25) not null
, Street VARCHAR (50) not null
, Zip CHAR(5) not null CHECK (Zip LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, Nationality VARCHAR (30)
, ClientsType CHAR (2) not null CHECK (ClientsType IN ('C','P','PP','PN')) 
, RegisterDate DATE DEFAULT getdate()
, FavProduct VARCHAR(20) CHECK (FavProduct IN ('Sports','Cosmetics','Food','Technology','Clothes')) 
, CONSTRAINT PK_CLIENTS PRIMARY KEY(ClientID)
);
 

CREATE TABLE PHONENUMBERCLIENTS
( PhoneNumber CHAR(9) not null CHECK (PhoneNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERCLIENTS PRIMARY KEY (PhoneNumber, ClientID)
, CONSTRAINT FK_PHONENUMBERCLIENTS FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);
 

CREATE TABLE EMAILADDRESSCLI
( EmailAddress NVARCHAR (25) not null
, ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSCLI PRIMARY KEY (EmailAddress, ClientID)
, CONSTRAINT FK_EMAILADDRESSCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);
 
CREATE TABLE BANKACCOUNTCLI
( CountryCode CHAR (2)  not null DEFAULT 'ES'
, ControlDigit CHAR(2) not null CHECK (ControlDigit LIKE ('[0-9][0-9]'))
, Entity CHAR(4) not null CHECK (Entity LIKE ('[0-9][0-9][0-9][0-9]'))
, Branch CHAR(4) not null CHECK (Branch LIKE ('[0-9][0-9][0-9][0-9]'))
, ControlDigit2 CHAR(2) not null CHECK (ControlDigit2 LIKE ('[0-9][0-9]'))
, AccountNumber CHAR(10) not null CHECK (AccountNumber LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTCLI PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, ClientID)
, CONSTRAINT FK_BANKACCOUNTCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT CK_BANKACCOUNTCLI CHECK (CountryCode LIKE ('[A-Z][A-Z]'))
);
 
CREATE TABLE NATIONALITYCLI
( Nationality VARCHAR(30) not null
,  ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_NATIONALITYCLI PRIMARY KEY (Nationality, ClientID)
, CONSTRAINT FK_NATIONALITYCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
 );
 
CREATE TABLE ORDERS
( UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN CHAR(10) not null CHECK (ManagerSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode CHAR(10) not null CHECK (SuppliersCode LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, OrderWeight INT CHECK (OrderWeight<1000 AND OrderWeight>0)
, Price MONEY DEFAULT 10000.00
, DateUpc DATE not null DEFAULT getdate()
, Quantity INT DEFAULT 50
, CONSTRAINT PK_ORDERS PRIMARY KEY (UPC, ManagerSSN, SuppliersCode, DateUpc)
, CONSTRAINT FK_ORDERS FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_ORDERS2 FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
, CONSTRAINT FK_ORDERS3 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);
 
CREATE TABLE COMPANY
( CompanyClientID CHAR(10) not null CHECK (CompanyClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Name_company VARCHAR (30)
, Tax_Number CHAR(5) not null CHECK (Tax_Number LIKE ('[0-9][0-9][0-9][a-z][a-z]'))
, CONSTRAINT PK_COMPANY PRIMARY KEY(CompanyClientID)
, CONSTRAINT FK_COMPANYCLIENTID FOREIGN KEY (CompanyClientID) REFERENCES CLIENTS(ClientID)
);
 
CREATE TABLE PRIVATE_CLI
( PrivateClientID CHAR(10) not null CHECK (PrivateClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientDNI VARCHAR (9) not null CHECK (ClientDNI LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
, Sex CHAR CHECK (Sex IN ('M','F','O'))
, Age INT DEFAULT 18
, Birthday DATE
, NameClient VARCHAR(20) not null
, SurnameClient VARCHAR(25) not null
, CONSTRAINT PK_PRIVATECLI PRIMARY KEY(PrivateClientID)
, CONSTRAINT FK_PRIVATECLI FOREIGN KEY (PrivateClientID) REFERENCES CLIENTS(ClientID)
);
 
CREATE TABLE PREMIUM_PRI_CLI
( PrivatePremiumID CHAR(10) not null CHECK (PrivatePremiumID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DiscountCard CHAR(9) CHECK (DiscountCard LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Renewal CHAR CHECK (Renewal IN ('Y','N'))
, CONSTRAINT PK_PREMIUM_PRI_CLI PRIMARY KEY (PrivatePremiumID)
, CONSTRAINT FK_PREMIUM_PRI_CLI FOREIGN KEY (PrivatePremiumID) REFERENCES PRIVATE_CLI(PrivateClientID)
);
 
CREATE TABLE NOPREMIUM_PRI_CLI
( PrivateNoPremiumID CHAR(10) not null CHECK (PrivateNoPremiumID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_NOPREMIUM_PRI_CLI PRIMARY KEY (PrivateNoPremiumID)
, CONSTRAINT FK_NOPREMIUM_PRI_CLI FOREIGN KEY (PrivateNoPremiumID) REFERENCES PRIVATE_CLI(PrivateClientID)
);
 
CREATE TABLE OFFERS
( OfferCode CHAR(5) not null CHECK(OfferCode LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, IniciationDate DATE not null DEFAULT getdate()
, ExpirationDate DATE
, Discount INT CHECK (Discount<70)
, CONSTRAINT DateCheck CHECK (IniciationDate<=ExpirationDate)
, CONSTRAINT PK_OFFERS PRIMARY KEY(OfferCode)
);
 
CREATE TABLE COSMETIC
( CosmeticUPC CHAR(10) not null CHECK (CosmeticUPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CosmeticType VARCHAR(30)
, CONSTRAINT PK_COSMETICS PRIMARY KEY(CosmeticUPC)
, CONSTRAINT FK_COSMETICS FOREIGN KEY (CosmeticUPC) REFERENCES Products(UPC)
);
 
 


CREATE TABLE FOOD
( FoodUPC CHAR(10) not null CHECK (FoodUPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, FoodType VARCHAR(30)
, CONSTRAINT PK_FOOD PRIMARY KEY(FoodUPC)
, CONSTRAINT FK_FOOD FOREIGN KEY (FoodUPC) REFERENCES Products(UPC)
);
 
CREATE TABLE TECHNOLOGY
( TechnoUPC  CHAR(10) not null CHECK (TechnoUPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TechnoType VARCHAR(30)
, CONSTRAINT PK_TECHNOLOGY PRIMARY KEY(TechnoUPC)
, CONSTRAINT FK_TECHNOLOGY FOREIGN KEY (TechnoUPC) REFERENCES Products(UPC)
);
 
CREATE TABLE CLOTHES
( ClothesUPC CHAR(10) not null CHECK (ClothesUPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClothesType VARCHAR(30)
, CONSTRAINT PK_CLOTHES PRIMARY KEY(ClothesUPC)
, CONSTRAINT FK_CLOTHES FOREIGN KEY (ClothesUPC) REFERENCES Products(UPC)
);
 
CREATE TABLE SPORTS
( SportUPC CHAR(10) not null CHECK (SportUPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SportType VARCHAR(30)
, CONSTRAINT PK_SPORTS PRIMARY KEY(SportUPC)
, CONSTRAINT FK_SPORTS FOREIGN KEY (SportUPC) REFERENCES Products(UPC)
);
 
CREATE TABLE CLISHOP
(  ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,  ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_CLISHO PRIMARY KEY(ClientID, ShopID)
, CONSTRAINT FK_CLISHO FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_CLISHO2 FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);
 
CREATE TABLE PREOFFPRO
( OfferCode CHAR(5) not null CHECK(OfferCode LIKE ('[0-9][0-9][0-9][0-9][0-9]'))
, ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DatePreoffpro DATE not null DEFAULT getdate()
, CONSTRAINT PK_PREOFFPRO PRIMARY KEY (OfferCode, ClientID, UPC, DatePreoffpro)
, CONSTRAINT FK_PREOFFPRO FOREIGN KEY (OfferCode) REFERENCES OFFERS(OfferCode)
, CONSTRAINT FK_PREOFFPRO2 FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_PREOFFPRO3 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);
 
CREATE TABLE INCOMES
( DateIncomes DATE not null DEFAULT getdate()
, ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, IncomeName VARCHAR(20)
, Quantity MONEY DEFAULT 10000.00
, CONSTRAINT PK_INCOMES PRIMARY KEY (DateIncomes, ShopID)
, CONSTRAINT FK_INCOMES FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);
 
CREATE TABLE TYPEDEP
( DepartmentCode CHAR not null CHECK (DepartmentCode LIKE ('[1-5]'))
, UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentSSN CHAR(10) not null CHECK (DependentSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_TYPE PRIMARY KEY(DepartmentCode, UPC, DependentSSN)
, CONSTRAINT FK_TYPE FOREIGN KEY (DepartmentCode) REFERENCES DEPARTMENTS(DepartmentCode)
, CONSTRAINT FK_TYPE2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
, CONSTRAINT FK_TYPE3 FOREIGN KEY (DependentSSN) REFERENCES DEPENDENTEMP(DependentSSN)
);
 
CREATE TABLE CLIPRO
( ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,  UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DateCliPro DATE not null DEFAULT getdate()
, CONSTRAINT PK_CLIPRO PRIMARY KEY (ClientID, UPC, DateCliPro)
, CONSTRAINT FK_CLIPRO FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_CLIPRO2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);
 
CREATE TABLE COMPLAINTS
( CusSuppSSN CHAR(10) not null CHECK (CusSuppSSN LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID CHAR(10) not null CHECK (ClientID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ComplaintID CHAR(4) not null CHECK (ComplaintID LIKE('[0-9][0-9][A-Z][A-Z]'))
, Date_comp DATE not null DEFAULT getdate()
, Desc_complaints VARCHAR (250)
, Resolved CHAR CHECK (Resolved IN ('Y','N'))
, CONSTRAINT PK_COMPLAINTS PRIMARY KEY(CusSuppSSN,ClientID,Date_comp)
, CONSTRAINT FK_COMPLAINTS FOREIGN KEY (CusSuppSSN) REFERENCES CUSTOMERSUPPORTER(CusSuppSSN)
, CONSTRAINT FK_COMPLAINTS2 FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);
 
CREATE TABLE INVENTORY
( Quantity INT not null CHECK (Quantity>0)
, ShopID CHAR(10) not null CHECK (ShopID LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, UPC CHAR(10) not null CHECK (UPC LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DateIn DATE not null DEFAULT getdate()
, CONSTRAINT PK_INVENTORY PRIMARY KEY(Quantity,ShopID)
, CONSTRAINT FK_INVENTORY FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
, CONSTRAINT FK_INVENTORY2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);

GO
CREATE TRIGGER SALARY_EMPLOYEES
ON PAYROLLS
FOR INSERT, UPDATE
AS
	Declare @Salary MONEY
	Declare @Type VARCHAR(20)
	SET @Type = (SELECT Category FROM EMPLOYEES 
WHERE EMPLOYEES.SSN = (SELECT SSN FROM INSERTED));
IF @Type='Security worker'
        SET @Salary = 1300.00;
IF @Type='Manager'
        SET @Salary = 1800.00;
IF @Type='Customer supporter'
        SET @Salary = 1100.00;
IF @Type='Dependent'
        SET @Salary = 1250.00;
IF @Type='Web designer'
        SET @Salary = 2000.00;

UPDATE PAYROLLS SET Amount=@Salary
WHERE PAYROLLS.SSN = (SELECT SSN FROM INSERTED) 
RETURN 

GO  
CREATE TRIGGER AGE_CLIENTS
ON PRIVATE_CLI
FOR INSERT,UPDATE
AS
	Declare @DiaAct INT
    	Declare @Mes INT
	Declare @Año INT
	Declare @Dia INT
SET @Mes = DATEDIFF(month,(select Birthday from inserted),getdate())
SET @Año = DATEDIFF(year,(select Birthday from inserted),getdate())
SET @Dia = DATEPART(DAYOFYEAR,(SELECT Birthday FROM inserted))
SET @Mes = @Mes%12
SET @DiaAct = (SELECT DATEPART(DAYOFYEAR,getdate()))
SET @DiaAct=@DiaAct-@Dia
IF @Mes>0
		SET @Año = @Año-1;
IF @Mes=0
	BEGIN
		IF @DiaAct<0
			SET @Año = @Año-1;
	END
UPDATE PRIVATE_CLI SET Age=@Año
		WHERE PRIVATE_CLI.PrivateClientID = (select PrivateClientID from inserted)
RETURN

GO  
CREATE TRIGGER AGE_EMPLOYEES
ON EMPLOYEES
FOR INSERT,UPDATE
AS
	Declare @DiaAct INT
    	Declare @Mes INT
	Declare @Año INT
Declare @Dia INT
SET @Mes = DATEDIFF(month,(select Birthday from inserted),getdate())
SET @Año = DATEDIFF(year,(select Birthday from inserted),getdate())
SET @Dia = DATEPART(DAYOFYEAR,(SELECT Birthday FROM inserted))
SET @Mes = @Mes%12
SET @DiaAct = (SELECT DATEPART(DAYOFYEAR,getdate()))
SET @DiaAct=@DiaAct-@Dia
IF @Mes>0
		SET @Año = @Año-1;
IF @Mes=0
	BEGIN
		IF @DiaAct<0
			SET @Año = @Año-1;
	END
UPDATE EMPLOYEES SET Age=@Año
		WHERE EMPLOYEES.SSN = (select SSN from inserted)
RETURN

GO  
CREATE TRIGGER EXPIRATION_DATE
ON OFFERS
FOR INSERT,UPDATE
AS
	Declare @FechaExp DATE
	Declare @FechaIni DATE
	SET @FechaIni =  (SELECT IniciationDate FROM OFFERS 
WHERE OFFERS.OfferCode = (SELECT OfferCode FROM INSERTED));
SET @FechaExp = (SELECT DATEADD(MONTH,3,@FechaIni))
	UPDATE OFFERS SET ExpirationDate=@FechaExp
		WHERE OFFERS.OfferCode = (select OfferCode from inserted)
    	
RETURN


GO
INSERT INTO SHOPS (ShopID, FloorsNumber, EmployeesNumber, Surface, PhoneNumber, Zip, Street, City) 
VALUES ('0123556789', 8, 1.200, 50.000, '987585652', 58962, 'Calle mis amigos nº2','Melilla');
SELECT * FROM SHOPS

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('jeje@gmail.com','123410520','P','1230478153', 'Leon', '24209', 'Calle los alamos', 'Castilla y Leon', 'Cosmetics');
SELECT * FROM CLIENTS

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('aloc@gmail.com','618992547','C','1245859632', 'Toledo', '24589', 'Calle los alamos', 'Aragon', 'Sports');
SELECT * FROM CLIENTS

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('feli@gmail.com','000992547','PP','0005859632', 'Gerona', '24589', 'Calle los alamos', 'España', 'Clothes');
SELECT * FROM CLIENTS

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('cola@gmail.com','061899200','PN','1240009632', 'Murcia', '24000', 'Calle los alamos', 'Cataluña', 'Sports');
SELECT * FROM CLIENTS

INSERT INTO PRIVATE_CLI(PrivateClientID,ClientDNI,Sex,Birthday,NameClient,SurnameClient)
VALUES('1230478153','71499933Q','M','2000-01-01','Elisa','Panyagua');
SELECT * FROM PRIVATE_CLI

INSERT INTO PRIVATE_CLI(PrivateClientID,ClientDNI,Sex,Birthday,NameClient,SurnameClient)
VALUES('0005859632','70359933Q','O','2000-03-01','Mario','Camu');
SELECT * FROM PRIVATE_CLI

INSERT INTO COMPANY(CompanyClientID, Tax_Number)
VALUES('1245859632','012AA');
SELECT * FROM COMPANY

INSERT INTO NOPREMIUM_PRI_CLI(PrivateNoPremiumID)
VALUES('1230478153');
SELECT * FROM NOPREMIUM_PRI_CLI

INSERT INTO PREMIUM_PRI_CLI(PrivatePremiumID)
VALUES('0005859632');
SELECT * FROM PREMIUM_PRI_CLI

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('1504219799', 'Federico', 'Perez', '2/12/89', 'pdelm08@elcorteingles.com', '618477447', 
'ES010123012340123456','Madrid','Calle los avelinos','34256','71455533E',12,3,'Español','Dependent');
SELECT * FROM EMPLOYEES

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('1504120799', 'Diego', 'Perez', '2/12/2000', 'dfrnv04@elcorteingles.com', '618472247', 
'ES010123012340123456','Madrid','Calle los avelardos','34256','71455223Q',12,3,'Español','Security Worker');
SELECT * FROM EMPLOYEES

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('0000120799', 'Adrian', 'Barrio', '10/12/1990', 'asdfg01@elcorteingles.com', '618472247', 
'ES010123012340123456','Madrid','Calle los avelardos','34256','71473686A',40,3,'Frances','Manager');
SELECT * FROM EMPLOYEES

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('4545120799', 'Romina', 'Sanchez', '2/12/20', 'jirnv00@elcorteingles.com', '618748247', 
'ES010123012340123456','Valladolid','Calle los avulenses','34256','71455223Q',2,3,'Ingles','Customer Supporter');
SELECT * FROM EMPLOYEES

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('0000120120', 'Juan Andres', 'Barrio', '10/08/1992', 'olkim01@elcorteingles.com', '645783562', 
'ES010123012340123326','Leon','Calle los avelinenses','78756','10548632B',40,2,'Español','Web Designer');
SELECT * FROM EMPLOYEES

INSERT INTO PAYROLLS(SSN, DatePayroll)
VALUES ('0000120120', '01/01/2020');
SELECT * FROM PAYROLLS

INSERT INTO MANAGER(ManagerSSN, TitleOfUniversity) 
VALUES ('0000120799','Engeniering');
SELECT * FROM MANAGER

INSERT INTO DEPENDENTEMP(DependentSSN, ManagerSSN, DependentPasswd, LanguageLevel, DepartmentName) 
VALUES ('1504219799', '0000120799','12s3','B2','Clothes');
SELECT * FROM DEPENDENTEMP

INSERT INTO SECURITYWORKER(SecWorkerSSN, ManagerSSN)
VALUES('1504120799', '0000120799');
SELECT * FROM SECURITYWORKER
 
INSERT INTO WEBDESIGNER(WebDesignerSSN, ManagerSSN)
VALUES('0000120120','0000120799');
SELECT * FROM WEBDESIGNER
 
INSERT INTO CUSTOMERSUPPORTER(CusSuppSSN,ManagerSSN, CustomerSuppPasswd)
VALUES('4545120799','0000120799','00A0');
SELECT * FROM CUSTOMERSUPPORTER

INSERT INTO DEPARTMENTS(DepartmentCode, EmployeesNumber, DepartmentName) 
VALUES ('1', 50, 'Sports');
SELECT * FROM DEPARTMENTS


INSERT INTO SALES (ShopID, DependentSSN, Datesale) 
VALUES('0123556789', '1504219799', '2019-05-08');
SELECT * FROM SALES

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('7898562369', 100, 'Rebuk',20,'Technology');
SELECT * FROM PRODUCTS

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1542589635', 100, 'Kike',30,'Sports');
SELECT * FROM PRODUCTS

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('0122456789', 100, 'Calvo Glein',50,'Cosmetics');
SELECT * FROM PRODUCTS

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1472583690', 200, 'Hacendaño',5,'Food');
SELECT * FROM PRODUCTS

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1599512364', 50, 'Dulce Camino',40,'Clothes');
SELECT * FROM PRODUCTS

INSERT INTO TECHNOLOGY(TechnoUPC)
VALUES('7898562369');
SELECT * FROM TECHNOLOGY
 
INSERT INTO SPORTS(SportUPC)
VALUES('1542589635');
SELECT * FROM SPORTS
 
INSERT INTO FOOD(FoodUPC)
VALUES('1472583690');
SELECT * FROM FOOD
 
INSERT INTO COSMETIC(CosmeticUPC)
VALUES('0122456789');
SELECT * FROM COSMETIC
 
INSERT INTO CLOTHES(ClothesUPC)
VALUES('1599512364');
SELECT * FROM CLOTHES

INSERT INTO INVENTORY(ShopID, UPC,DateIn , Quantity) 
VALUES ('0123556789', '0122456789', '2019-05-08', 100);
SELECT * FROM INVENTORY

INSERT INTO SUPPLIERS(SuppliersCode, BankAccount, EmailAddress,Zip,Street, City, Price, Fax, Legal_Representative,SuppName,Category)
VALUES('0123456789', 'ES0101230123010123996789' , 'calvo@gmail.com', '24010', 'Ave del hoyo', 'Vigo', 100, '987562235', 'Angela Dominguez', 'Prendas colmillo', 'I');
SELECT * FROM SUPPLIERS

INSERT INTO SUPPLIERS(SuppliersCode, BankAccount, EmailAddress,Zip,Street, City, Price, Fax, Legal_Representative,SuppName,Category)
VALUES('2525699635', 'ES0101230123010123456789' , 'calvo@gmail.com', '24010', 'Ave del palomar', 'Leon', 100, '987562235', 'Juan Perez', 'Reposterias paco', 'N');
SELECT * FROM SUPPLIERS

INSERT INTO NATIONALSTATE (NatSuppCode, City) 
VALUES ('2525699635', 'Vigo');
SELECT * FROM NATIONALSTATE

INSERT INTO INTERNATIONALSTATE (IntSuppCode, Country, TaxNumber) 
VALUES ('0123456789', 'España', '98765ABC');
SELECT * FROM INTERNATIONALSTATE

INSERT INTO WAREHOUSE(WarehouseCode,ShopID)
VALUES('265', '0123556789');
SELECT * FROM WAREHOUSE

INSERT INTO ORDERS(UPC, ManagerSSN, SuppliersCode,DateUpc)
VALUES('0122456789', '0000120799', '0123456789', '2019-05-06');
SELECT * FROM ORDERS
 
INSERT INTO COMPLAINTS(CusSuppSSN,ClientID,ComplaintID,Resolved)
VALUES('4545120799','1245859632','01AZ','Y');
SELECT * FROM COMPLAINTS

INSERT INTO TYPEDEP(DepartmentCode, UPC, DependentSSN)
VALUES('1', '1542589635', '1504219799');
SELECT * FROM TYPEDEP

INSERT INTO EMAILADDRESSCLI(EmailAddress, ClientID) 
VALUES ('aloc@gmail.com','1245859632');
SELECT * FROM EMAILADDRESSCLI

INSERT INTO EMAILADDRESSEMP(EmailAddress, SSN) 
VALUES ('jirnv00@elcorteingles.com','4545120799');
SELECT * FROM EMAILADDRESSEMP

INSERT INTO EMAILADDRESSSUPP(EmailAddress, SuppliersCode) 
VALUES ('cavo@gmail.com','2525699635');
SELECT * FROM EMAILADDRESSSUPP 

INSERT INTO BANKACCOUNTCLI(CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,ClientID)
VALUES ('ES','01','2345','6789','00','0123456789','1245859632');
SELECT * FROM  BANKACCOUNTCLI

INSERT INTO BANKACCOUNTEMP(CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,SSN)
VALUES ('ES', '31', '9123', '1113', '21', '0123458889','0000120799');
SELECT * FROM  BANKACCOUNTEMP

INSERT INTO BANKACCOUNTSUP (CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,SuppliersCode)
VALUES ('ES', '01', '0123', '0123', '01', '0123456789 ','2525699635');
SELECT * FROM   BANKACCOUNTSUP

INSERT INTO PHONENUMBERCLIENTS(PhoneNumber,ClientID)
VALUES('618992547','1245859632');
SELECT * FROM PHONENUMBERCLIENTS

INSERT INTO PHONENUMBEREMP(PhoneNumber,SSN)
VALUES('645783562','0000120120');
SELECT * FROM PHONENUMBEREMP

INSERT INTO PHONENUMBERSUPP(PhoneNumber,SuppliersCode)
VALUES('987562235','0123456789');
SELECT * FROM PHONENUMBERSUPP

INSERT INTO PHONENUMBERSHOPS(PhoneNumber,ShopID)
VALUES('987585652','0123556789');
SELECT * FROM PHONENUMBERSHOPS

INSERT INTO NATIONALITYCLI(Nationality, ClientID)
VALUES('Britanica','1245859632');
SELECT * FROM NATIONALITYCLI

INSERT INTO NATIONALITYEMP(Nationality, SSN)
VALUES('Español','0000120120');
SELECT * FROM NATIONALITYEMP

INSERT INTO INCOMES(DateIncomes, ShopID, IncomeName)
VALUES('01/02/2019','0123556789','Balones');
SELECT * FROM INCOMES

INSERT INTO CLISHOP(ClientID, ShopID)
VALUES('1230478153','0123556789');
SELECT * FROM CLISHOP	

INSERT INTO OFFERS(OfferCode, IniciationDate)
VALUES('00001','31/10/2019');
SELECT * FROM OFFERS

INSERT INTO PREOFFPRO(OfferCode, ClientID, UPC, DatePreoffpro)
VALUES('00001','1230478153','1542589635','01/01/2020');
SELECT * FROM PREOFFPRO

INSERT INTO CLIPRO(ClientID, UPC, DateCliPro)
VALUES('1230478153','1542589635','01/01/2020');
SELECT * FROM CLIPRO


