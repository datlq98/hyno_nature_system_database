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
---- Country
CREATE TABLE [Information].[Country]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Country_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Country_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Provice
CREATE TABLE [Information].[Province]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CountryID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Province_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Province_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- City
CREATE TABLE [Information].[City]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[ProvinceID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_City_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_City_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- District
CREATE TABLE [Information].[District]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[CityID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_District_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_District_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Ward
CREATE TABLE [Information].[Ward]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[DistrictID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Ward_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Ward_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Address
CREATE TABLE [Information].[Address]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[WardID] [INT] NOT NULL,
	[AddressLine] [NVARCHAR](60) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Address_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

/* ---------------- */
-- HUMAN RESOURCES --
---- Employee ----
CREATE TABLE [HumanResources].[Employee]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[LineManagerID] [INT] NULL,
	[AddressID] [INT] NOT NULL,
	[FirstName] [NVARCHAR](50) NOT NULL,
	[MiddleName] [NVARCHAR](50) NULL,
	[LastName] [NVARCHAR](50) NOT NULL,
	[DayOfBirth] [DATE] NOT NULL,
	[IDCardNumber] [NVARCHAR](15) NULL,
	[PhoneNumber] [NVARCHAR](10) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[Gender] [NCHAR](1) NOT NULL,
	[JoinedDate] [DATE] NOT NULL,
	[ActiveFlag] [BIT] NOT NULL CONSTRAINT [DF_Employee_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Employee_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Person_Gender] CHECK (UPPER([Gender]) IN ('F', 'M', 'O')),
	CONSTRAINT [CK_Employee_EmailAddress] CHECK (EmailAddress LIKE '%___@___%.__%'),
	CONSTRAINT [CK_Customer_PhoneNumber] CHECK (PhoneNumber NOT LIKE '%[^0-9]%')
) ON [PRIMARY];
GO

---- Department ----
CREATE TABLE [HumanResources].[Department]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Department_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Employee-Department History ----
CREATE TABLE [HumanResources].[EmployeeDepartmentHistory]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL,
	[DepartmentID] [INT] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_DepartmentHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_DepartmentHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO

---- Role ----
CREATE TABLE [HumanResources].[Role]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Role_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Role_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Employee-Role History ----
CREATE TABLE [HumanResources].[EmployeeRoleHistory]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL,
	[RoleID] [INT] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RoleHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RoleHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_EmployeeRoleHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO

---- Employee-Salary History ----
CREATE TABLE [HumanResources].[EmployeeSalaryHistory]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[EmployeeID] [INT] NOT NULL,
	[Salary] [MONEY] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalaryHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalaryHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_EmployeeSalaryHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO

/* ---------------- */
-- PRODUCTION --
---- Unit Measurement ----
CREATE TABLE [Production].[UnitMeasurement]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_UnitMeasurement_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_UnitMeasurement_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Category ----
CREATE TABLE [Production].[ProductCategory]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCategory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Sub Category ----
CREATE TABLE [Production].[ProductSubCategory]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
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
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
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
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[ProductLineID] [INT] NOT NULL,
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
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
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
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[ProductID] [INT] NOT NULL,
	[Price] [MONEY] NOT NULL,
	[StartDate] [DATE] NOT NULL,
	[EndDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductPriceHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductPriceHistory_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_ProductPriceHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
	CONSTRAINT [CK_ProductPriceHistory_Price] CHECK ([Price] >= 0.00)
) ON [PRIMARY];
GO

---- Manufacturing and Product Inventory Locations
CREATE TABLE [Production].[Location]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[AddressID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[ActiveFlag] BIT NOT NULL CONSTRAINT [DF_Location_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Location_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

-- MANUFACTURING
---- Work Order Status
CREATE TABLE [Production].[WorkOrderStatus]
(
	[ID] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](30) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrderStatus_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrderStatus_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Work Order 
CREATE TABLE [Production].[WorkOrder]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[CreatedByID] [INT] NOT NULL,
	[ApprovedByID] [INT] NOT NULL,
	[WorkOrderStatusID] [INT] NOT NULL,	
	[RequestedDate] [DATE] NOT NULL,
	[ExpectedStartDate] [DATE] NOT NULL,
	[ExpectedEndDate] [DATE] NOT NULL,
 	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrder_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrder_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_WorkOrder_ExpectedStartDate] CHECK (([ExpectedStartDate] >= [RequestedDate])),
	CONSTRAINT [CK_WorkOrder_ExpectedEndDate] CHECK (([ExpectedEndDate] > [ExpectedStartDate]))
) ON [PRIMARY];
GO

---- Work Order Detail
CREATE TABLE [Production].[WorkOrderDetail]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[WorkOrderID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	[ActualStartDate] [DATE] NOT NULL,
	[ActualEndDate] [DATE] NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrderDetail_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_WorkOrderDetail_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_WorkOrderDetail_ActualEndDate] CHECK (([ActualEndDate] > [ActualStartDate]))
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

-- SHIPMENT
---- Shipping Method
CREATE TABLE [ShippingMethod]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingMethod_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingMethod_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Shipping Status
CREATE TABLE [ShippingStatus]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingStatus_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingStatus_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

-- PURCHASING --
---- Supplier ----
CREATE TABLE [Purchasing].[Supplier]
(
	[ID] [INT] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[AddressID] [INT] NOT NULL,
	[Name] [NVARCHAR](50) NOT NULL,
	[FaxNumber] [NVARCHAR](20) NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[PhoneNumber] [NVARCHAR](10) NOT NULL,
	[JoinedDate] [DATE] NOT NULL,
	[ActiveFlag] [BIT] NOT NULL CONSTRAINT [DF_Supplier_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Supplier_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Supplier_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Supplier_EmailAddress] CHECK (EmailAddress LIKE '%___@___%.__%'),
	CONSTRAINT [CK_Customer_PhoneNumber] CHECK (PhoneNumber NOT LIKE '%[^0-9]%')
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
	[MerchandiseSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_PurchaseOrder_MerchandiseSubTotal] DEFAULT (0.00),
	[VATSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_PurchaseOrder_VATSubTotal] DEFAULT (0.00),
	[OrderedDate] [DATE] NOT NULL CONSTRAINT [DF_PurchaseOrder_OrderDate] DEFAULT (GETDATE()),
	[ExpectedDeliveryDate] [DATE] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrder_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_PurchaseOrder_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_PurchaseOrder_ExpectedDeliveryDate] CHECK (
			([ExpectedDeliveryDate] >= [OrderedDate])
		OR ([ExpectedDeliveryDate] IS NULL)
		),
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
	[CheckedByID] [INT] NOT NULL,
	[PartOfOrder] [SMALLINT] NOT NULL,
	[ActualShipDate] [DATETIME] NOT NULL CONSTRAINT [DF_POTransactionHistory_ActualDeliveryDate] DEFAULT (GETDATE()),
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
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_CustomerType_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO
---- Customer ----
CREATE TABLE [Sales].[Customer]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[CustomerTypeID] [INT] NOT NULL,
	[AddressID] [INT] NOT NULL,
	[CompanyName] [NVARCHAR](50) NULL,
	[FirstName] [NVARCHAR](50) NOT NULL,
	[MiddleName] [NVARCHAR](50) NULL,
	[LastName] [NVARCHAR](50) NOT NULL,
	[DayOfBirth] [DATE] NOT NULL,
	[JoinedDate] [DATE] NOT NULL,
	[IDCardNumber] [NVARCHAR](13),
	[EmailAddress] [nvarchar](50) NOT NULL,
	[PhoneNumber] [NVARCHAR](10) NOT NULL,
	[TAXNumber] [NVARCHAR](20),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Customer_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_Customer_JoinedDate] CHECK ([JoinedDate] >= [DayOfBirth]),
	CONSTRAINT [CK_Customer_EmailAddress] CHECK (EmailAddress LIKE '%___@___%.__%'),
	CONSTRAINT [CK_Customer_PhoneNumber] CHECK (PhoneNumber NOT LIKE '%[^0-9]%')
) ON [PRIMARY];
GO

---- Discount 
CREATE TABLE [Sales].[Discount]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[Description] [NVARCHAR](200) NOT NULL,
	[DiscountPercent] [DECIMAL](3, 2) NOT NULL,
	[ActiveFlag] BIT NOT NULL CONSTRAINT [DF_Discount_ActiveFlag] DEFAULT (1),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Discount_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_Discount_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT CK_Discount_DiscountPercent CHECK (DiscountPercent BETWEEN 0.00 AND 1.00),
) ON [PRIMARY];
GO

---- Sales Order Type ---- 
CREATE TABLE [Sales].[SalesOrderType]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalesOrderType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalesOrderType_ModifiedDate] DEFAULT (GETDATE()),
) ON [PRIMARY];
GO

---- Sales Order Recurance Type ---- 
CREATE TABLE [Sales].[RecurrenceType]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RecurrenceType_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RecurrenceType_ModifiedDate] DEFAULT (GETDATE()),
) ON [PRIMARY];
GO

---- Sales Order Status ----
CREATE TABLE [Sales].[SalesOrderStatus]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](30) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalesOrderStatus_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalesOrderStatus_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Sales Order ----
CREATE TABLE [Sales].[SalesOrder]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[CustomerID] [INT] NOT NULL,
	[CreatedByID] [INT] NOT NULL,
	[SalesOrderTypeID] [INT] NOT NULL,
	[SalesOrderStatusID] [INT] NOT NULL,
	[RecurrenceTypeID] [INT] NULL,
	[OriginalSalesOrderID] [INT] NOT NULL,
	[ShiptoAddressID] [INT] NOT NULL,
	[MerchandiseSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_SalesOrder_MerchandiseSubTotal] DEFAULT (0.00),
	[VATSubTotal] [MONEY] NOT NULL CONSTRAINT [DF_SalesOrder_VATSubTotal] DEFAULT (0.00),
	[OrderedDate] [DATETIME] NOT NULL CONSTRAINT [DF_SalseOrder_OrderedDate] DEFAULT (GETDATE()),
	[ExpectedShipDate] [DATETIME] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalseOrder_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalesOrder_ModifiedDate] DEFAULT (GETDATE()),
	CONSTRAINT [CK_SalseOrder_ExpectedShipDate] CHECK (([ExpectedShipDate] >= [OrderedDate]) OR ([ExpectedShipDate] IS NULL)),
	CONSTRAINT [CK_PurchaseOrder_MerchandiseSubTotal] CHECK ([MerchandiseSubTotal] >= 0.00),
	CONSTRAINT [CK_PurchaseOrder_VATSubTotal] CHECK ([VATSubTotal] >= 0.00),
) ON [PRIMARY];
GO

---- Sales Order ----
CREATE TABLE [Sales].[SalesOrderDetail]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[SalesOrderID] [INT] NOT NULL,
	[ProductID] [INT] NOT NULL,
	[DiscountID] [INT] NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalseOrderDetail_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SalseOrderDetail_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Recall Reason
CREATE TABLE [Sales].[RecallReason]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[Name] [NVARCHAR](50) NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RecallReason_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_RecallReason_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Product Recall History ----
CREATE TABLE [Sales].[ProductRecallHistory]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[SODetailID] [INT] NOT NULL,
	[RecallReasonID] [INT] NOT NULL,
	[RecallDate] [DATE] NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductRecallHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ProductRecallHistory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Shipping History ----
CREATE TABLE [Sales].[ShippingHistory]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[SalesOrderID] [INT] NOT NULL,
	[ShippingMethodID] [INT] NOT NULL,
	[ShippedByID] [INT] NOT NULL,
	[ShippingStatusID] [INT] NOT NULL,
	[ActualShipDate] [DATETIME] NULL CONSTRAINT [DF_ShippingHistory_ActualShipDate] DEFAULT (GETDATE()),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingHistory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

---- Shipping History Detail ----
CREATE TABLE [Sales].[ShippingHistoryDetail]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[ShippingHistoryID] [INT] NOT NULL,
	[ProductID] [INT] NOT NULL,
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingHistoryDetail_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_ShippingHistoryDetail_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

--- Sale Order Payment History ----
CREATE TABLE [Sales].[SOPaymentHistory]
(
	[ID] [INT] IDENTITY(1, 1) PRIMARY KEY,
	[PaymentMethodID] [INT] NOT NULL,
	[PaymentStatusID] [INT] NOT NULL,
	[ShippingHistoryID] [INT] NOT NULL,
	[PaidAmount] [MONEY] NOT NULL CONSTRAINT [DF_SOPaymentHistory_PaidAmount] DEFAULT (0.00),
	[DebtTotal] [MONEY] NOT NULL CONSTRAINT [DF_SOPaymentHistory_DebtTotal] DEFAULT (0.00),
	[PaidDate] [DATETIME] NOT NULL CONSTRAINT [DF_SOPaymentHistory_PaidDate] DEFAULT (GETDATE()),
	[CreatedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SOPaymentHistory_CreatedDate] DEFAULT (GETDATE()),
	[ModifiedAt] [DATETIME] NOT NULL CONSTRAINT [DF_SOPaymentHistory_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO