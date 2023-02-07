USE HYNONatureDatabase;
GO


-- ******************************************************
-- Create tables
-- ******************************************************
PRINT '';
PRINT '*** Creating Tables';
GO

/* ---------------- */
-- PEOPLE --
---- Address ----
CREATE TABLE [Person].[Country]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Country_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Country_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[Province]
(
	[ID] [INT]IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CountryID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Province_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Province_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[City]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[ProvinceID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_City_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_City_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[District]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CityID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_District_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_District_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[Ward]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[DistrictID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Ward_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Ward_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[Address]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[WardID] [INT] NOT NULL,
	[AddressLine] [NVARCHAR](60) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Address_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[AddressType]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_AddressType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Phone Number ----

CREATE TABLE [Person].[PhoneNumber]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[PhoneNumber] [VARCHAR](15) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PhoneNumber_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PhoneNumber_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE TABLE [Person].[PhoneNumberType]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PhoneNumberType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PhoneNumberType_ModifiedDate] DEFAULT (GETDATE())
)

---- Email Address ----
CREATE TABLE [Person].[EmailAddress]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Email] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_EmailAddress_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_EmailAddress_ModifiedDate] DEFAULT (GETDATE())
)

CREATE TABLE [Person].[EmailAddressType]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](30) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_EmailAddressType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_EmailAddressType_ModifiedDate] DEFAULT (GETDATE())
)

/* ---------------- */
-- HUMAN RESOURCES --
---- Employee ----
CREATE TABLE [HumanResources].[Employee]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[LineManagerID] [INT] FOREIGN KEY REFERENCES HumanResources.Employee(ID),
	[FirstName] [NVARCHAR](50) NOT NULL,
	[MiddleName] [NVARCHAR](50) NULL,
	[LastName] [NVARCHAR](50) NOT NULL,
	[DayOfBirth] [DATE] NOT NULL,
	[IDCardNumber] [NVARCHAR](15) NULL,
	[Gender] [NCHAR](1) NOT NULL,
	[JoinedDate] [DATE] NOT NULL,
	[ActiveFlag] [BIT] NOT NULL CONSTRAINT [DF_Employee_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Employee_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Person_Gender] CHECK (UPPER([Gender]) IN ('F', 'M', 'O'))
) ON [PRIMARY];
GO


---- Department ----
CREATE TABLE [HumanResources].[Department]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Department_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Employee-Department History ----
CREATE TABLE [HumanResources].[EmployeeDepartmentHistory]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL,
	[DepartmentID] [INT] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_DepartmentHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_DepartmentHistory_ModifiedDate] DEFAULT (GETDATE())
		CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO

---- Role ----
CREATE TABLE [HumanResources].[Role]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Role_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Role_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Employee-Role History ----
CREATE TABLE [HumanResources].[EmployeeRoleHistory]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL PRIMARY KEY PRIMARY KEY,
	[RoleID] [INT] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RoleHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RoleHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_EmployeeRoleHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
) ON [PRIMARY];
GO

---- Employee-Salary History ----
CREATE TABLE [HumanResources].[EmployeeSalaryHistory]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL,
	[Salary] [MONEY] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalaryHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalaryHistory_ModifiedDate] DEFAULT (GETDATE())
		CONSTRAINT [CK_EmployeeSalaryHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO

/* ---------------- */
-- PRODUCTION --
---- Unit Measurement ----
CREATE TABLE [Production].[UnitMeasurement]
(
	[ID] [INT] IDENTITY PRIMARY KEY PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_UnitMeasurement_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_UnitMeasurement_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Category ----
CREATE TABLE [Production].[ProductCategory]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCategory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Sub Category ----
CREATE TABLE [Production].[ProductSubCategory]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductCategoryID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductSubCategory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductSubCategory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Line ----
CREATE TABLE [Production].[ProductLine]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductSubCategoryID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductLine_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductLine_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


---- Product ----
CREATE TABLE [Production].[Product]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductLine] [INT] NOT NULL,
	[UnitMeasurementID] [INT] NOT NULL,
	[LocationID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[Capacity] [VARCHAR](10) NOT NULL,
	[SerialNumber] [VARCHAR](25) NOT NULL,
	[IsAvailable] [BIT] NOT NULL CONSTRAINT [DF_Employee_ActiveFlag] DEFAULT (1),
	[ManufacturingDate] DATE NOT NULL,
	[ExpriredDate] DATE NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Product_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Product_ExpriredDate] CHECK (([ExpriredDate] >= [ManufacturingDate]) OR ([ExpriredDate] IS NULL))
) ON [PRIMARY];
GO

---- Product Cost History ----
CREATE TABLE [Production].[ProductCostHistory]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductID] [INT] NOT NULL,
	[Cost] [MONEY] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCostHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCostHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_ProductCostHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
	CONSTRAINT [CK_ProductCostHistory_Cost] CHECK ([Cost] >= 0.00)
) ON [PRIMARY];
GO

---- Product Price History ----
CREATE TABLE [Production].[ProductPriceHistory]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductID] [INT] NOT NULL,
	[Price] [MONEY] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE],
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductPriceHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductPriceHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_ProductPriceHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
	CONSTRAINT [CK_ProductPriceHistory_Price] CHECK ([Price] >= 0.00)
) ON [PRIMARY];
GO

---- Manufacturing and Product Inventory Locations ----
CREATE TABLE [Production].[Location]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[AddressID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[ActiveFlag] BIT NOT NULL CONSTRAINT [DF_Location_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Location_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


-- PURCHASING --
---- Supplier ----
CREATE TABLE [Purchasing].[Supplier]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[FaxNumber] [NVARCHAR](20) NULL,
	[JoinedDate] [DATE] NOT NULL,
	[ActiveFlag] [BIT] NOT NULL CONSTRAINT [DF_Supplier_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Supplier_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Supplier_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Supplier ----
CREATE TABLE [Production].[ProductSupplier]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ProductID] [INT] NOT NULL,
	[SupplierID] [INT] NOT NULL,
	[UnitMeasurementID] [INT] NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductSupplier_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductSupplier_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

-- PAYMENT --
---- Payment Method ----
CREATE TABLE [PaymentMethod]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PaymentMethod_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PaymentMethod_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


---- Payment Status ----
CREATE TABLE [PaymentStatus]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PaymentStatus_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PaymentStatus_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Purchase Order Status ----
CREATE TABLE [Purchasing].[PurchaseOrderStatus]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](30) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrderStatus_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrderStatus_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


---- Purchase Order  ----
CREATE TABLE [Purchasing].[PurchaseOrder]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[SupplierID] [INT] NOT NULL,
	[CreatedByID] [INT] NOT NULL,
	[ApprovedByID] [INT] NOT NULL,
	[POStatusID] [INT] NOT NULL,
	[ShipToLocationID] [INT] NOT NULL,
	[MerchandiseSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_SalesOrder_MerchandiseSubTotal] DEFAULT (0.00),
	[VATSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_SalesOrder_VATSubTotal] DEFAULT (0.00),
	[OrderDate] [DATE] NOT NULL CONSTRAINT [DF_PurchaseOrder_OrderDate] DEFAULT (GETDATE()),
	[ExpectedDeliveryDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrder_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrder_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_PurchaseOrder_ExpectedDeliveryDate] CHECK (([ExpectedDeliveryDate] >= [OrderDate]) OR ([ExpectedDeliveryDate] IS NULL)),
	CONSTRAINT [CK_PurchaseOrder_MerchandiseSubTotal] CHECK ([MerchandiseSubTotal] >= 0.00), 
    CONSTRAINT [CK_PurchaseOrder_VATSubTotal] CHECK ([VATSubTotal] >= 0.00), 
) ON [PRIMARY];
GO


---- Purchase Order Detail ----
CREATE TABLE [Purchasing].[PurchaseOrderDetail]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[PurchaseOrderID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrderDetail_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate] DEFAULT (GETDATE()),
) ON [PRIMARY];
GO

---- Purchase Order Transaction History ----
CREATE TABLE [Purchasing].[POTransactionHistory]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[PurchaseOrderID] [INT] NOT NULL,
	[CheckByID] [INT] NOT NULL,
	[PartOfOrder] [SMALLINT] NOT NULL,
	[ActualDeliveryDate] [DATE] NOT NULL CONSTRAINT [DF_POTransactionHistory_ActualDeliveryDate] DEFAULT (GETDATE()),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POTransactionHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POTransactionHistoryr_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_POTransactionHistory_PartOfOrder] CHECK ([PartOfOrder] > 0), 
) ON [PRIMARY];
GO

---- Purchase Order Transaction History Detail ----
CREATE TABLE [Purchasing].[POTransactionHistoryDetail]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[POTransactionHistoryID] [INT] NOT NULL,
	[ProductID] [INT] NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POTransactionHistoryDetail_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POTransactionHistoryDetail_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Purchase Order Payment History ----
CREATE TABLE [Purchasing].[POPaymentHistory]
(
	[ID] [INT] IDENTITY PRIMARY KEY,
	[POTransactionHistoryID] [INT] NOT NULL,
	[PaymentMethodID] [INT] NOT NULL,
	[PaymentStatusID] [INT] NOT NULL,
	[PaidByID] [INT] NOT NULL,
	[PaidAmount] [MONEY] NOT NULL CONSTRAINT [DF_POPaymentHistory_PaidAmount] DEFAULT (0.00),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POPaymentHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_POPaymentHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_POPaymentHistory_PaidAmount] CHECK ([PaidAmount] >= 0.00)
) ON [PRIMARY];
GO

-- SALES --
---- Customer Type ----
CREATE TABLE [Sales].[CustomerType]
(
	[ID] [INT] IDENTITY(1,1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Customer ----
CREATE TABLE [Sales].[Customer]
(
	[ID] [INT] IDENTITY(1,1) PRIMARY KEY,
	[CustomerTypeID] [INT] NOT NULL,
	[CompanyName] [NVARCHAR](50) NULL,
	[FirstName] [NVARCHAR](50) NOT NULL,
	[MiddleName] [NVARCHAR](50) NULL,
	[LastName] [NVARCHAR](50) NOT NULL,
	[DayOfBirth] [DATE] NOT NULL,
	[JoinedDate] [DATE] NOT NULL,
	[IDCardNumber] [NVARCHAR](13),
	[CompanyName] [NVARCHAR](50),
	[TAXNumber] [NVARCHAR](20),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Customer_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Customer_JoinedDate] CHECK ([JoinedDate] >= [DayOfBirth])
) ON [PRIMARY];
GO

---- BankCard Type ----
CREATE TABLE [Sales].[BankCardType]
(
	[ID] [INT] IDENTITY(1,1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


---- Customer BankCard ----
CREATE TABLE [Sales].[CustomerBankCard]
(
	[ID] [INT] IDENTITY(1,1) PRIMARY KEY,
	[CustomerID] INT NOT NULL,
	[BankCardTypeID] INT NOT NULL,
	[BankName] [NVARCHAR](50) NOT NULL,
	[CardNumber] [NVARCHAR](25) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerBankCard_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerBankCard_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO


---- Customer Phone Number ---- 

---- Discount ----
CREATE TABLE Sales.Discount
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(200) NOT NULL,
	DiscountPercent DECIMAL(3,2) NOT NULL CONSTRAINT chkDiscountPercentValue CHECK (DiscountPercent BETWEEN 0 AND 1),
	ActiveFlag BIT NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
) ON [PRIMARY];
GO

---- Sales Order Type ---- 
CREATE TABLE Sales.SalesOrderType
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Sales Order Recurance Type ---- 
CREATE TABLE Sales.RecuranceType
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Sales Order Status ----
CREATE TABLE Sales.SalesOrderStatus
(
	ID INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(30) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Sales Order ----
CREATE TABLE Sales.SalesOrder
(
	ID INT IDENTITY PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Sales.Customer(ID) NOT NULL,
	CreatedByID INT FOREIGN KEY REFERENCES HumanResources.Employee(ID) NOT NULL,
	SalesOrderTypeID INT FOREIGN KEY REFERENCES Sales.SalesOrderType(ID) NOT NULL,
	SalesOrderStatusID INT FOREIGN KEY REFERENCES Sales.SalesOrderStatus(ID) NOT NULL,
	RecuranceTypeID INT FOREIGN KEY REFERENCES Sales.RecuranceType(ID),
	OriginalSalesOrderID INT FOREIGN KEY REFERENCES Sales.SalesOrder(ID),
	MerchandiseSubTotal MONEY NOT NULL,
	VATSubTotal MONEY NOT NULL,
	Amount MONEY NOT NULL,
	OrderedDate DATETIME NOT NULL,
	ExpectedDeliveryDate DATE NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Sales Order ----
CREATE TABLE Sales.SalesOrderDetail
(
	ID INT IDENTITY PRIMARY KEY,
	SalesOrderID INT FOREIGN KEY REFERENCES Sales.SalesOrder(ID) NOT NULL,
	ProductID INT FOREIGN KEY REFERENCES Production.Product(ID) NOT NULL,
	DiscountID INT FOREIGN KEY REFERENCES Sales.Discount(ID),
	MerchandiseSubTotal MONEY NOT NULL,
	UnitPrice MONEY NOT NULL,
	Quantity SMALLINT NOT NULL,
	Amount MONEY NOT NULL,
	OrderedDate DATETIME NOT NULL,
	ExpectedDeliveryDate DATE NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Recall Reason ----
CREATE TABLE Sales.RecallReason
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Product Recall History ----
CREATE TABLE Sales.ProductRecallHistory
(
	ID INT IDENTITY PRIMARY KEY,
	SODetailID INT FOREIGN KEY REFERENCES Sales.SalesOrderDetail(ID) NOT NULL,
	RecallReasonID INT FOREIGN KEY REFERENCES Sales.RecallReason(ID) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Shipping Method ----
CREATE TABLE Sales.ShippingMethod
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)
---- Shipping Status ---- 
CREATE TABLE Sales.ShippingStatus
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Shipping History ----
CREATE TABLE Sales.ShippingHistory
(
	ID INT IDENTITY PRIMARY KEY,
	SalesOrderID INT FOREIGN KEY REFERENCES Sales.SalesOrder(ID) NOT NULL,
	DeliveryByID INT FOREIGN KEY REFERENCES HumanResources.Employee(ID) NOT NULL,
	ShippingMethodID INT FOREIGN KEY REFERENCES  Sales.ShippingMethod(ID) NOT NULL,
	ShippingStatusID INT FOREIGN KEY REFERENCES  Sales.ShippingStatus(ID) NOT NULL,
	ActualDeliveryDate DATETIME NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)
---- Shipping History Detail ----
CREATE TABLE Sales.ShippingHistoryDetail
(
	ID INT IDENTITY PRIMARY KEY,
	ShippingHistoryID INT FOREIGN KEY REFERENCES Sales.ShippingHistory(ID) NOT NULL,
	ProductID INT FOREIGN KEY REFERENCES Production.Product(ID) NOT NULL,
	Quantity SMALLINT NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)

---- Shipping Sales Order Invoice ---- 
CREATE TABLE Sales.ShippingSOInvoice
(
	ID INT IDENTITY PRIMARY KEY,
	ShippingHistoryID INT FOREIGN KEY REFERENCES Sales.ShippingHistory(ID) NOT NULL,
	MerchandiseSubTotal MONEY NOT NULL,
	DebtSubTotal MONEY NOT NULL,
	TotalPayment MONEY NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)


--- Sale Order Payment History ----
CREATE TABLE Sales.SOPaymentHistory
(
	ID INT IDENTITY PRIMARY KEY,
	PaymentMethodID INT FOREIGN KEY REFERENCES PaymentMethod(ID) NOT NULL,
	SOPaymentStatusID INT FOREIGN KEY REFERENCES Sales.SOPaymentStatus(ID) NOT NULL,
	ShippingSOInvoiceID INT FOREIGN KEY REFERENCES Sales.ShippingSOInvoice(ID) NOT NULL,
	PaidAmount MONEY NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedAt DATETIME NOT NULL DEFAULT GETDATE()
)