CREATE TABLE SHOPS
( ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE(ShopID, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, FloorsNumber NUMBER(2)  DEFAULT 10
, EmployeesNumber NUMBER(4) CHECK (EmployeesNumber>0)
, Surface NUMBER(5) DEFAULT 20000
, PhoneNumber VARCHAR2(9)  CHECK (REGEXP_LIKE (PhoneNumber, '987[0-9][0-9][0-9][0-9][0-9][0-9]'))
, Zip VARCHAR2(5) not null CHECK (REGEXP_LIKE (Zip,'[0-9][0-9][0-9][0-9][0-9]'))
, Street NVARCHAR2(50) not null
, City NVARCHAR2(25) not null
, CONSTRAINT SHOP_PK PRIMARY KEY (ShopID) 
);

CREATE TABLE CLIENTS
( ClientID VARCHAR2 (10) not null  CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, EmailAddress NVARCHAR2 (25) CHECK (REGEXP_LIKE(EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, PhoneNumber VARCHAR2(9)  CHECK (REGEXP_LIKE (PhoneNumber, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR2 (20)
, Province VARCHAR(25) not null
, City NVARCHAR2(25) not null
, Street NVARCHAR2 (50) not null
, Zip VARCHAR2(5) not null CHECK (REGEXP_LIKE (Zip,'[0-9][0-9][0-9][0-9][0-9]'))
, Nationality VARCHAR2 (50)
, ClientsType CHAR (2) not null CHECK (ClientsType IN ('C','P','PP','PN'))
, RegisterDate DATE DEFAULT SYSDATE not null
, FavProduct  VARCHAR(20) CHECK (FavProduct IN ('Sports','Cosmetics','Food','Technology','Clothes'))
, CONSTRAINT CLIENT_PK PRIMARY KEY (ClientID)
);

CREATE TABLE COMPANY
( CompanyClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (CompanyClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Name_Company NVARCHAR2 (30)
, TaxNumber VARCHAR2(5) not null CHECK (REGEXP_LIKE(TaxNumber,'[0-9][0-9][0-9][a-z][a-z]'))
, CONSTRAINT COMPANY_PK PRIMARY KEY(CompanyClientID)
, CONSTRAINT FK_COMPANY FOREIGN KEY (CompanyClientID) REFERENCES CLIENTS(ClientID)
);




CREATE TABLE PRIVATE_CLI
( PrivateClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (PrivateClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, NameClient NVARCHAR2(20) not null
, ClientDNI VARCHAR (9) not null CHECK (REGEXP_LIKE (ClientDNI,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
, SurnameClient NVARCHAR2(25) not null
, Sex CHAR(1) CHECK (Sex IN ('M','F','O'))
, Birthday DATE
, Age NUMBER(3) DEFAULT 18
, CONSTRAINT PRIVATECLI_PK PRIMARY KEY(PrivateClientID)
, CONSTRAINT FK_PRIVATECLI FOREIGN KEY (PrivateClientID) REFERENCES CLIENTS(ClientID)
);

CREATE TABLE PREMIUM_PRI_CLI
( PrivatePremiumID VARCHAR2(10) not null CHECK (REGEXP_LIKE (PrivatePremiumID ,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DiscountCard VARCHAR2(9) CHECK (REGEXP_LIKE (DiscountCard,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Renewal CHAR(1) CHECK (Renewal IN ('Y','N'))
, CONSTRAINT PREMIUM_CL_PKI PRIMARY KEY (PrivatePremiumID)
, CONSTRAINT FK_PREMIUM_CLI FOREIGN KEY (PrivatePremiumID) REFERENCES PRIVATE_CLI(PrivateClientID)
);

CREATE TABLE NOPREMIUM_PRI_CLI
( PrivateNoPremiumID VARCHAR2(10) not null CHECK (REGEXP_LIKE (PrivateNoPremiumID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT NOPREMIUM_CLI_PK PRIMARY KEY (PrivateNoPremiumID)
, CONSTRAINT FK_NOPREMIUM_CLI FOREIGN KEY (PrivateNoPremiumID) REFERENCES PRIVATE_CLI(PrivateClientID)
);

CREATE TABLE CLISHOP
( ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ShopID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT CLIENTSHO_PK PRIMARY KEY (ClientID, ShopID)
, CONSTRAINT FK_CLISHO FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_CLISHO2 FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);

CREATE TABLE PRODUCTS
( UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (UPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, NamePro NVARCHAR2 (50)
, Quantity NUMBER(5) DEFAULT 50
, Brand VARCHAR (50) not null
, Price NUMBER(14,9) CHECK (Price<10000)
, Category VARCHAR(10) CHECK (Category IN ('Sports','Cosmetics','Food','Technology','Clothes'))
, CONSTRAINT PRODUCTS_PK PRIMARY KEY(UPC)
);

CREATE TABLE COSMETIC
( CosmeticUPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (CosmeticUPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CosmeticType VARCHAR2 (30)
, CONSTRAINT COSMETIC_PK PRIMARY KEY(CosmeticUPC)
, CONSTRAINT FK_COSMETICS FOREIGN KEY (CosmeticUPC) REFERENCES Products(UPC)
);


CREATE TABLE FOOD
( FoodUPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (FoodUPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, FoodType VARCHAR2 (30)
, CONSTRAINT FOOD_PK PRIMARY KEY(FoodUPC)
, CONSTRAINT FK_FOOD FOREIGN KEY (FoodUPC) REFERENCES Products(UPC)
);

CREATE TABLE TECHNOLOGY
( TechnoUPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (TechnoUPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TechnoType VARCHAR2 (30)
, CONSTRAINT TECHNO_PK PRIMARY KEY(TechnoUPC)
, CONSTRAINT FK_TECHNOLOGY FOREIGN KEY (TechnoUPC) REFERENCES Products(UPC)
);

CREATE TABLE CLOTHES
( ClothesUPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClothesUPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClothesType VARCHAR2 (30)
, CONSTRAINT CLOTHES_PK PRIMARY KEY(ClothesUPC)
, CONSTRAINT FK_CLOTHES FOREIGN KEY (ClothesUPC) REFERENCES Products(UPC)
);

CREATE TABLE SPORTS
( SportUPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (SportUPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SportsType VARCHAR2 (30)
, CONSTRAINT SPORTS_PK PRIMARY KEY(SportUPC)
, CONSTRAINT FK_SPORTS FOREIGN KEY (SportUPC) REFERENCES Products(UPC)
);

CREATE TABLE DEPARTMENTS
( DepartmentCode CHAR not null CHECK (DepartmentCode IN ('1','2','3','4','5'))
, EmployeesNumber NUMBER (5) not null CHECK (EmployeesNumber>0)
, DepartmentName VARCHAR2 (10) not null
, CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DepartmentCode)
);

CREATE TABLE SUPPLIERS
( SuppliersCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (SuppliersCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR2(24)
, PhoneNumber VARCHAR2(9) CHECK (REGEXP_LIKE (PhoneNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, EmailAddress NVARCHAR2(50) CHECK (REGEXP_LIKE (EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, Zip VARCHAR2(5) not null CHECK (REGEXP_LIKE (Zip,'[0-9][0-9][0-9][0-9][0-9]'))
, Street NVARCHAR2(50) not null
, City NVARCHAR2(25)  DEFAULT 'Madrid' not null
, Price NUMBER(19,4) CHECK (Price>0)
, Fax VARCHAR2(9) CHECK (REGEXP_LIKE (Fax,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Legal_representative VARCHAR2(25) not null
, SuppName NVARCHAR2(25) not null
, Category CHAR(1) not null CHECK (Category IN ('I','N'))
, CONSTRAINT SUPPLIERS_PK PRIMARY KEY(SuppliersCode)
);

CREATE TABLE NATIONALSTATE
( NatSuppCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (NatSuppCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, City NVARCHAR2(25) 
, CONSTRAINT SUPPLIERSNAT_PK PRIMARY KEY (NatSuppCode)
, CONSTRAINT FK_SUPPLIERSNAT FOREIGN KEY (NatSuppCode) REFERENCES SUPPLIERS (SuppliersCode)
);

CREATE TABLE INTERNATIONALSTATE
( IntSuppCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (IntSuppCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Country VARCHAR2(25)
, TaxNumber VARCHAR2(8) not null CHECK (REGEXP_LIKE (TaxNumber,'[0-9][0-9][0-9][0-9][0-9][A-Z][A-Z][A-Z]'))
, CONSTRAINT SUPPLIERSINT_PK PRIMARY KEY (IntSuppCode)
, CONSTRAINT FK_SUPPLIERSINT FOREIGN KEY (IntSuppCode) REFERENCES SUPPLIERS (SuppliersCode)
);

CREATE TABLE EMPLOYEES
( SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, NameEmp NVARCHAR2 (20) not null
, SurnameEmp NVARCHAR2 (25) not null
, Birthday DATE not null
, EmailAddress NVARCHAR2 (25) CHECK (REGEXP_LIKE (EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, PhoneNumber VARCHAR2 (9) CHECK (REGEXP_LIKE (PhoneNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, BankAccount VARCHAR2 (24)
, City NVARCHAR2 (30)
, Street NVARCHAR2 (50) 
, Zip VARCHAR2(5) CHECK (REGEXP_LIKE (Zip,'[0-9][0-9][0-9][0-9][0-9]'))
, Sex CHAR (1) CHECK (Sex IN ('M','F','O'))
, Age NUMBER(3)
, EmployeeDNI VARCHAR2 (10) not null CHECK (REGEXP_LIKE   (EmployeeDNI,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
, HoursWeek NUMBER (2)  DEFAULT 40
, YearsInCompany NUMBER (2) DEFAULT 0
, Nationality VARCHAR2 (30) DEFAULT 'Espanya'
, Category VARCHAR2 (20) not null CHECK (Category IN ('Manager','Customer supporter','Dependent','Security worker','Web designer'))
, CONSTRAINT PK_EMPLOYEES PRIMARY KEY (SSN)
);

CREATE TABLE MANAGER
( ManagerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TitleOfUniversity VARCHAR2(25) DEFAULT 'Collage'
, CONSTRAINT PK_MANAGER PRIMARY KEY (ManagerSSN)
, CONSTRAINT FK_MANAGER FOREIGN KEY (ManagerSSN) REFERENCES EMPLOYEES (SSN)
);

CREATE TABLE DEPENDENTEMP
( DependentSSN VARCHAR2(10) not null  CHECK (REGEXP_LIKE (DependentSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentPasswd VARCHAR2(10) not null CHECK (REGEXP_LIKE (DependentPasswd,'[0-9][0-9][a-z][0-9]'))
, LanguageLevel VARCHAR2(2) DEFAULT 'B1'
, DepartmentName VARCHAR2(10) CHECK (DepartmentName IN ('Food','Technology','Sports','Cosmetics','Clothes'))
, CONSTRAINT PK_DEPENDENTS PRIMARY KEY (DependentSSN)
, CONSTRAINT FK_DEPENDENTS FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_DEPENDENTS2 FOREIGN KEY (DependentSSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE CUSTOMERSUPPORTER
( CusSuppSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (CusSuppSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CustomerSuppPasswd VARCHAR2(4) CHECK (REGEXP_LIKE (CustomerSuppPasswd,'[0-9][0-9][a-z][0-9]'))
, LanguageLevel VARCHAR2(2) DEFAULT 'B2'
, CONSTRAINT PK_CUSTOMERSUPPORTER PRIMARY KEY (CusSuppSSN)
, CONSTRAINT FK_CUSTOMERSUPPORTER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_CUSTOMERSUPPORTER2 FOREIGN KEY (CusSuppSSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE WEBDESIGNER
( WebDesignerSSN VARCHAR2(10) not null  CHECK (REGEXP_LIKE (WebDesignerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN VARCHAR2(10) not null  CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, TitleOfUniversity VARCHAR2(50) DEFAULT 'Collage'
, ExtraHours VARCHAR2(2) CHECK (ExtraHours<4 AND ExtraHours>0)
, CONSTRAINT PK_WEBDESIGNER PRIMARY KEY (WebDesignerSSN)
, CONSTRAINT FK_WEBDESIGNER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_WEBDESIGNER2 FOREIGN KEY (WebDesignerSSN) REFERENCES EMPLOYEES(SSN)

);

CREATE TABLE SECURITYWORKER
( SecWorkerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (SecWorkerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_SECURITYWORKER PRIMARY KEY (SecWorkerSSN)
, CONSTRAINT FK_SECURITYWORKER FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_SECURITYWORKER2 FOREIGN KEY (SecWorkerSSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE INCOMES
( DateIncomes DATE DEFAULT SYSDATE not null
, ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ShopID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, IncomeName NVARCHAR2(20) 
, Quantity NUMBER(5)  DEFAULT 10000
, CONSTRAINT PK_INCOMES PRIMARY KEY(DateIncomes, ShopID)
, CONSTRAINT FK_INCOMES FOREIGN KEY (ShopID) REFERENCES SHOPS (ShopID)
);

CREATE TABLE SALES
( ShopID VARCHAR2 (10) not null CHECK (REGEXP_LIKE (ShopID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (DependentSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Datesale DATE DEFAULT SYSDATE not null
, Quantity NUMBER(5) DEFAULT 1
, CONSTRAINT PK_SALES PRIMARY KEY (ShopID, DependentSSN, Datesale)
, CONSTRAINT FK_SALES FOREIGN KEY (ShopID) REFERENCES SHOPS (ShopID)
, CONSTRAINT FK_SALES2 FOREIGN KEY (DependentSSN) REFERENCES DEPENDENTEMP (DependentSSN)
);

CREATE TABLE PAYROLLS
( SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DatePayroll DATE DEFAULT SYSDATE not null
, Amount NUMBER(5,2) 
, CONSTRAINT PK_PAYROLLS PRIMARY KEY (SSN, DatePayroll)
, CONSTRAINT FK_PAYROLLS FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE WAREHOUSE
( WarehouseCode VARCHAR2(3) not null CHECK (REGEXP_LIKE (WarehouseCode,'[0-9][0-9][0-9]'))
, ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ShopID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_WAREHOUSE PRIMARY KEY (WarehouseCode, ShopID)
, CONSTRAINT FK_WAREHOUSE FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);

CREATE TABLE ORDERS
( UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (UPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ManagerSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (ManagerSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (SuppliersCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, Weight NUMBER (4) CHECK (Weight<1000 AND Weight>0)
, Price NUMBER (5) DEFAULT 10000
, DateUpc DATE  DEFAULT SYSDATE not null
, Quantity NUMBER(5) DEFAULT 50
, CONSTRAINT PK_ORDERS PRIMARY KEY (UPC, ManagerSSN, SuppliersCode, DateUpc) 
, CONSTRAINT FK_ORDERS FOREIGN KEY (ManagerSSN) REFERENCES MANAGER(ManagerSSN)
, CONSTRAINT FK_ORDERS2 FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
, CONSTRAINT FK_ORDERS3 FOREIGN KEY (UPC) REFERENCES PRODUCTS (UPC)
);

CREATE TABLE OFFERS
( OfferCode VARCHAR2(5) not null CHECK (REGEXP_LIKE (OfferCode,'[0-9][0-9][0-9][0-9][0-9]'))
, IniciationDate Date DEFAULT sysdate not null
, ExpirationDate Date
, Discount NUMBER (3) CHECK (Discount<70)
, CONSTRAINT DateCheck CHECK (IniciationDate<=ExpirationDate)
, CONSTRAINT PK_OFFERS PRIMARY KEY(OfferCode)
);

CREATE TABLE PREOFFPRO 
( OfferCode VARCHAR2(5) not null CHECK (REGEXP_LIKE (OfferCode,'[0-9][0-9][0-9][0-9][0-9]'))
, ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (UPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DatePreoffpro DATE DEFAULT SYSDATE not null
, CONSTRAINT PK_PREOFFPRO PRIMARY KEY (OfferCode, ClientID, UPC, DatePreoffpro)
, CONSTRAINT FK_PREOFFPRO FOREIGN KEY (OfferCode) REFERENCES OFFERS(OfferCode)
, CONSTRAINT FK_PREOFFPRO2 FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_PREOFFPRO3 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);

CREATE TABLE COMPLAINTS
( CusSuppSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (CusSuppSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ComplaintID VARCHAR2(4) not null CHECK (REGEXP_LIKE(ComplaintID,'[0-9][0-9][A-Z][A-Z]'))
, Date_comp DATE DEFAULT SYSDATE not null
, Desc_complaints VARCHAR2 (250)
, Resolved CHAR (1) CHECK (Resolved IN ('Y','N'))
, CONSTRAINT COMPLAINTS_PK PRIMARY KEY(CusSuppSSN,ClientID,Date_comp)
, CONSTRAINT FK_COMPLAINTS FOREIGN KEY (CusSuppSSN) REFERENCES CUSTOMERSUPPORTER(CusSuppSSN)
, CONSTRAINT FK_COMPLAINTS2 FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);

CREATE TABLE INVENTORY
( Quantity NUMBER (5) not null CHECK (Quantity>0)
, ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE(ShopID, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE(UPC, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

, DateIn DATE DEFAULT SYSDATE not null 
, CONSTRAINT INVENTORY_PK PRIMARY KEY (Quantity, ShopID)
, CONSTRAINT FK_INVENTORY FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
, CONSTRAINT FK_INVENTORY2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);

CREATE TABLE CLIPRO
( ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (UPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DateCliPro DATE  DEFAULT SYSDATE not null
, CONSTRAINT CLIPRO_PK PRIMARY KEY (ClientID, UPC, DateCliPro)
, CONSTRAINT FK_CLIPRO FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT FK_CLIPRO2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
);

CREATE TABLE TYPEDEP
( DepartmentCode CHAR(1) not null CHECK (DepartmentCode IN ('1','2','3','4','5'))
, UPC VARCHAR2(10) not null CHECK (REGEXP_LIKE (UPC,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, DependentSSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (DependentSSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT TYPE_PK PRIMARY KEY(DepartmentCode, UPC, DependentSSN)
, CONSTRAINT FK_TYPE FOREIGN KEY (DepartmentCode) REFERENCES DEPARTMENTS(DepartmentCode)
, CONSTRAINT FK_TYPE2 FOREIGN KEY (UPC) REFERENCES PRODUCTS(UPC)
, CONSTRAINT FK_TYPE3 FOREIGN KEY (DependentSSN) REFERENCES DEPENDENTEMP(DependentSSN)
);

CREATE TABLE BANKACCOUNTCLI
( CountryCode VARCHAR2(2)  DEFAULT 'ES' not null
, ControlDigit VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit,'[0-9][0-9]'))
, Entity VARCHAR2(4) not null CHECK (REGEXP_LIKE (Entity,'[0-9][0-9][0-9][0-9]'))
, Branch VARCHAR2(4) not null CHECK (REGEXP_LIKE (Branch,'[0-9][0-9][0-9][0-9]'))
, ControlDigit2 VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit2,'[0-9][0-9]'))
, AccountNumber VARCHAR2(10) not null CHECK (REGEXP_LIKE (AccountNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTCLI PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, ClientID)
, CONSTRAINT FK_BANKACCOUNTCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
, CONSTRAINT CK_BANKACCOUNTCLI CHECK (REGEXP_LIKE (CountryCode,'[A-Z][A-Z]'))
);


CREATE TABLE BANKACCOUNTEMP
( CountryCode VARCHAR2(2)  DEFAULT 'ES' not null
, ControlDigit VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit,'[0-9][0-9]'))
, Entity VARCHAR2(4) not null CHECK (REGEXP_LIKE (Entity,'[0-9][0-9][0-9][0-9]'))
, Branch VARCHAR2(4) not null CHECK (REGEXP_LIKE (Branch,'[0-9][0-9][0-9][0-9]'))
, ControlDigit2 VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit2,'[0-9][0-9]'))
, AccountNumber VARCHAR2(10) not null CHECK (REGEXP_LIKE (AccountNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
,SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTEMP PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, SSN)
, CONSTRAINT FK_BANKACCOUNTEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
, CONSTRAINT CK_BANKACCOUNTEMP CHECK (REGEXP_LIKE (CountryCode,'[A-Z][A-Z]'))
);  

CREATE TABLE BANKACCOUNTSUP
( CountryCode VARCHAR2(2)  DEFAULT 'ES' not null
, ControlDigit VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit,'[0-9][0-9]'))
, Entity VARCHAR2(4) not null CHECK (REGEXP_LIKE (Entity,'[0-9][0-9][0-9][0-9]'))
, Branch VARCHAR2(4) not null CHECK (REGEXP_LIKE (Branch,'[0-9][0-9][0-9][0-9]'))
, ControlDigit2 VARCHAR2(2) not null CHECK (REGEXP_LIKE (ControlDigit2,'[0-9][0-9]'))
, AccountNumber VARCHAR2(10) not null CHECK (REGEXP_LIKE (AccountNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode VARCHAR(10) not null CHECK (REGEXP_LIKE (SuppliersCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_BANKACCOUNTSUP PRIMARY KEY (ControlDigit, Entity, Branch, ControlDigit2, AccountNumber, SuppliersCode)
, CONSTRAINT FK_BANKACCOUNTSUP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
, CONSTRAINT CK_BANKACCOUNTSUP CHECK (REGEXP_LIKE (CountryCode,'[A-Z][A-Z]'))
);


CREATE TABLE EMAILADDRESSEMP
( EmailAddress NVARCHAR2(25) not null CHECK (REGEXP_LIKE (EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE (SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSEMP PRIMARY KEY (EmailAddress, SSN)
, CONSTRAINT FK_EMAILADDRESSEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE EMAILADDRESSSUPP
( EmailAddress NVARCHAR2(25) not null CHECK (REGEXP_LIKE (EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, SuppliersCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (SuppliersCode,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSSUPP PRIMARY KEY (EmailAddress, SuppliersCode)
, CONSTRAINT FK_EMAILADDRESSSUPP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
);

CREATE TABLE EMAILADDRESSCLI
( EmailAddress NVARCHAR2(25) not null CHECK (REGEXP_LIKE (EmailAddress, '^(\S+)@(\S+).(\S+)$'))
, ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_EMAILADDRESSCLI PRIMARY KEY (EmailAddress, ClientID)
, CONSTRAINT FK_EMAILADDRESSCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);

CREATE TABLE PHONENUMBERSHOPS
( PhoneNumber VARCHAR2(9) CHECK (REGEXP_LIKE (PhoneNumber, '987[0-9][0-9][0-9][0-9][0-9][0-9]'))
, ShopID VARCHAR2(10) not null CHECK (REGEXP_LIKE (ShopID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERSHOPS PRIMARY KEY (PhoneNumber, ShopID)
, CONSTRAINT FK_PHONENUMBERSHOPS FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);

CREATE TABLE PHONENUMBEREMP
( PhoneNumber VARCHAR2(9) not null CHECK (REGEXP_LIKE (PhoneNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE(SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBEREMP PRIMARY KEY (PhoneNumber, SSN)
, CONSTRAINT FK_PHONENUMBEREMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN)
);

CREATE TABLE PHONENUMBERSUPP
( PhoneNumber VARCHAR2(9) not null CHECK (REGEXP_LIKE (PhoneNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, SuppliersCode VARCHAR2(10) not null CHECK (REGEXP_LIKE (SuppliersCode, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERSUPP PRIMARY KEY (PhoneNumber, SuppliersCode)
, CONSTRAINT FK_PHONENUMBERSUPP FOREIGN KEY (SuppliersCode) REFERENCES SUPPLIERS(SuppliersCode)
);

CREATE TABLE PHONENUMBERCLIENTS
( PhoneNumber VARCHAR2(9) not null CHECK (REGEXP_LIKE(PhoneNumber,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE(ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_PHONENUMBERCLIENTS PRIMARY KEY (PhoneNumber, ClientID)
, CONSTRAINT FK_PHONENUMBERCLIENTS FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID)
);

 CREATE TABLE NATIONALITYEMP
( Nationality VARCHAR2(30) not null
, SSN VARCHAR2(10) not null CHECK (REGEXP_LIKE(SSN,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_NATIONALITYEMP PRIMARY KEY (Nationality, SSN)
, CONSTRAINT FK_NATIONALITYEMP FOREIGN KEY (SSN) REFERENCES EMPLOYEES(SSN) );

CREATE TABLE NATIONALITYCLI
( Nationality VARCHAR2(30) not null
,  ClientID VARCHAR2(10) not null CHECK (REGEXP_LIKE(ClientID,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
, CONSTRAINT PK_NATIONALITYCLI PRIMARY KEY (Nationality, ClientID)
, CONSTRAINT FK_NATIONALITYCLI FOREIGN KEY (ClientID) REFERENCES CLIENTS(ClientID) );


INSERT INTO SHOPS (ShopID, FloorsNumber, EmployeesNumber, Surface, PhoneNumber, Zip, Street, City) 
VALUES ('0123656789', 8, 1200, 50000, '987585652', '58962', 'Calle mis amigos n2','Melilla');

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('jeje@gmail.com','123410520','P','1230478153', 'Leon', '24209', 'Calle los alamos', 'Castilla y Leon', 'Cosmetics');

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('xDxD@gmail.com','731410520','C','1230000153', 'Madrid', '30209', 'Avenida los alamos', 'Castilla', 'Sports');

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('cola@gmail.com','061899200','PN','1240009632', 'Murcia', '24000', 'Calle los alamos', 'Catalu� 'Sports');

INSERT INTO CLIENTS (EmailAddress, PhoneNumber, ClientsType, ClientID, City, Zip, Street, Province, FavProduct) 
VALUES ('feli@gmail.com','000992547','PP','0005859632', 'Gerona', '24589', 'Calle los alamos', 'Espanya 'Clothes');

INSERT INTO PRIVATE_CLI(PrivateClientID,ClientDNI,Sex,Birthday,NameClient,SurnameClient)
VALUES('1230478153','71499933Q','M',TO_DATE('22/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'),'Elisa','Panyagua');

INSERT INTO PRIVATE_CLI(PrivateClientID,ClientDNI,Sex,Birthday,NameClient,SurnameClient)
VALUES('0005859632','70359933Q','O',TO_DATE('22/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'),'Mario','Camu');

INSERT INTO COMPANY(CompanyClientID, TaxNumber)
VALUES('1230000153','012aa');

INSERT INTO NOPREMIUM_PRI_CLI(PrivateNoPremiumID)
VALUES('1230478153');


INSERT INTO PREMIUM_PRI_CLI(PrivatePremiumID)
VALUES('0005859632');

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('1504219799', 'Federico', 'Perez', TO_DATE('22/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 'pdelm08@elcorteingles.com', '618477447', 
'ES010123012340123456','Madrid','Calle los avelinos','34256','71455533E',12,3,'Espanya','Dependent');

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('1504120799', 'Diego', 'Perez', TO_DATE('22/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 'dfrnv04@elcorteingles.com', '618472247', 
'ES010123012340123456','Madrid','Calle los avelardos','34256','71455223Q',12,3,'Espanya','Security worker');

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('0000120799', 'Adrian', 'Barrio', TO_DATE('10/November/1990 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 'asdfg01@elcorteingles.com', '618472247', 
'ES010123012340123456','Madrid','Calle los avelardos','34256','71473686A',40,3,'Frances','Manager');

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('4545120799', 'Romina', 'Sanchez', TO_DATE('23/April/1968 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 'jirnv00@elcorteingles.com', '618748247', 
'ES010123012340123456','Valladolid','Calle los avulenses','34256','71455223Q',2,3,'Ingles','Customer supporter');

INSERT INTO EMPLOYEES(SSN,NameEmp,SurnameEmp,Birthday, EmailAddress, PhoneNumber, BankAccount
, City,Street, Zip, EmployeeDNI, HoursWeek, YearsInCompany , Nationality, Category)
VALUES ('0000120120', 'Juan Andres', 'Barrio', TO_DATE('10/July/1991 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 'olkim01@elcorteingles.com', '645783562', 
'ES010123012340123326','Leon','Calle los avelinenses','78756','10548632B',40,2,'Espanya','Web designer');



INSERT INTO PAYROLLS(SSN, DatePayroll)
VALUES ('0000120120', TO_DATE('01/January/20 8:30:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO MANAGER(ManagerSSN, TitleOfUniversity) 
VALUES ('0000120799','Engeniering');

INSERT INTO DEPENDENTEMP(DependentSSN, ManagerSSN, DependentPasswd, LanguageLevel, DepartmentName) 
VALUES ('1504219799', '0000120799','12s3','B2','Clothes');

INSERT INTO SECURITYWORKER(SecWorkerSSN, ManagerSSN)
VALUES('1504120799', '0000120799');

INSERT INTO WEBDESIGNER(WebDesignerSSN, ManagerSSN)
VALUES('0000120120','0000120799');

INSERT INTO CUSTOMERSUPPORTER(CusSuppSSN,ManagerSSN, CustomerSuppPasswd)
VALUES('4545120799','0000120799','00a0');

INSERT INTO DEPARTMENTS(DepartmentCode, EmployeesNumber, DepartmentName) 
VALUES ('1', 50, 'Sports');

INSERT INTO SALES (ShopID, DependentSSN, Datesale) 
VALUES('0123556789', '1504219799', TO_DATE('10/July/1991 8:30:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('7898562369', 100, 'Rebuk',20,'Technology');

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1542589635', 100, 'Kike',30,'Sports');

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('0122456789', 100, 'Calvo Glein',50,'Cosmetics');

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1472583690', 200, 'Hacendado',5,'Food');

INSERT INTO PRODUCTS(UPC,Quantity,Brand,Price,Category)
VALUES('1599512364', 50, 'Dulce Camino',40,'Clothes');



INSERT INTO TECHNOLOGY(TechnoUPC)
VALUES('7898562369');

INSERT INTO SPORTS(SportUPC)
VALUES('1542589635');

INSERT INTO FOOD(FoodUPC)
VALUES('1472583690');

INSERT INTO COSMETIC(CosmeticUPC)
VALUES('0122456789');

INSERT INTO CLOTHES(ClothesUPC)
VALUES('1599512364');

INSERT INTO INVENTORY(ShopID, UPC,DateIn , Quantity) 
VALUES ('0123556789', '1472583690',TO_DATE('10/July/1991 8:30:00AM','DD/MON/YY HH:MI:SSAM'), 13200);

INSERT INTO SUPPLIERS(SuppliersCode, BankAccount, EmailAddress,Zip,Street, City, Price, Fax, Legal_Representative,SuppName,Category)
VALUES('0123456789', 'ES0101230123010123996789' , 'calvo@gmail.com', '24010', 'Ave del hoyo', 'Vigo', 100, '987562235', 'Angela Dominguez', 'Prendas colmillo', 'I');

INSERT INTO SUPPLIERS(SuppliersCode, BankAccount, EmailAddress,Zip,Street, City, Price, Fax, Legal_Representative,SuppName,Category)
VALUES('2525699635', 'ES0101230123010123456789' , 'calvo@gmail.com', '24010', 'Ave del palomar', 'Leon', 100, '987562235', 'Juan Perez', 'Reposterias paco', 'N');

INSERT INTO NATIONALSTATE (NatSuppCode, City) 
VALUES ('2525699635', 'Vigo');

INSERT INTO INTERNATIONALSTATE (IntSuppCode, Country, TaxNumber) 
VALUES ('0123456789', 'Francia', '98765ABC');

INSERT INTO WAREHOUSE(WarehouseCode,ShopID)
VALUES('265', '0123556789');

INSERT INTO ORDERS(UPC, ManagerSSN, SuppliersCode,DateUpc)
VALUES('0122456789', '0000120799', '0123456789', TO_DATE('18/July/2019 8:30:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO COMPLAINTS(CusSuppSSN,ClientID,ComplaintID,Resolved)
VALUES('4545120799','1245859632','01AZ','Y');

INSERT INTO TYPEDEP(DepartmentCode, UPC, DependentSSN)
VALUES('1', '1542589635', '1504219799');

INSERT INTO EMAILADDRESSCLI(EmailAddress, ClientID) 
VALUES ('aloc@gmail.com','0005859632');-

INSERT INTO EMAILADDRESSEMP(EmailAddress, SSN) 
VALUES ('jirnv00@elcorteingles.com','4545120799');

INSERT INTO EMAILADDRESSSUPP(EmailAddress, SuppliersCode) 
VALUES ('cavo@gmail.com','2525699635');

INSERT INTO BANKACCOUNTCLI(CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,ClientID)
VALUES ('ES','01','2345','6789','00','0123456789','0005859632');

INSERT INTO BANKACCOUNTEMP(CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,SSN)
VALUES ('ES', '31', '9123', '1113', '21', '0123458889','0000120799');

INSERT INTO BANKACCOUNTSUP (CountryCode , ControlDigit ,Entity,Branch,ControlDigit2, AccountNumber,SuppliersCode)
VALUES ('ES', '01', '0123', '0123', '01', '0123456789','2525699635');

INSERT INTO PHONENUMBERCLIENTS(PhoneNumber,ClientID)
VALUES('618992547','0005859632');

INSERT INTO PHONENUMBEREMP(PhoneNumber,SSN)
VALUES('645783562','0000120120');

INSERT INTO PHONENUMBERSUPP(PhoneNumber,SuppliersCode)
VALUES('987562235','0123456789');

INSERT INTO PHONENUMBERSHOPS(PhoneNumber,ShopID)
VALUES('987585652','0123556789');

INSERT INTO NATIONALITYCLI(Nationality, ClientID)
VALUES('Britanica','1245859632');

INSERT INTO NATIONALITYEMP(Nationality, SSN)
VALUES('Espanya','0000120120');

INSERT INTO INCOMES(DateIncomes, ShopID, IncomeName)
VALUES('01/02/2019','0123556789','Balones');

INSERT INTO CLISHOP(ClientID, ShopID)
VALUES('1230478153','0123556789');

INSERT INTO OFFERS(OfferCode, IniciationDate)
VALUES('00001',TO_DATE('22/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO PREOFFPRO(OfferCode, ClientID, UPC, DatePreoffpro)
VALUES('00001','0005859632','1472583690',TO_DATE('23/April/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO CLIPRO(ClientID, UPC, DateCliPro)
VALUES('1230478153','1542589635',TO_DATE('23/July/2011 8:30:00AM','DD/MON/YY HH:MI:SSAM'));
​