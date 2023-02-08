PRINT '';
PRINT '*** Creating Foreign Key Constraints';
GO

-- INFORMATION
---- Province
ALTER TABLE [Information].[Province]
ADD CONSTRAINT [FK_Province_Country_CountryID] FOREIGN KEY ([CountryID]) REFERENCES [Information].[Country]([ID]);
GO

---- City
ALTER TABLE [Information].[City]
ADD CONSTRAINT [FK_City_Province_ProvinceID] FOREIGN KEY ([ProvinceID]) REFERENCES [Information].[Province]([ID]);
GO

---- District
ALTER TABLE [Information].[District]
ADD CONSTRAINT [FK_District_City_CityID] FOREIGN KEY ([CityID]) REFERENCES [Information].[City]([ID]);
GO

---- Ward
ALTER TABLE [Information].[Ward]
ADD CONSTRAINT [FK_Ward_District_DistrictID] FOREIGN KEY ([DistrictID]) REFERENCES [Information].[District]([ID]);
GO

---- Address
ALTER TABLE [Information].[Address]
ADD CONSTRAINT [FK_Address_Ward_WardID] FOREIGN KEY ([WardID]) REFERENCES [Information].[Ward]([ID]);
GO

-- HUMAN RESOURCES
---- Employee
ALTER TABLE [HumanResources].[Employee]
ADD CONSTRAINT [FK_Employeee_Employee_LineManagerID] FOREIGN KEY ([LineManagerID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_Employeee_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Information].[Address]([ID]);
GO

---- Employee Department History 
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory]
ADD CONSTRAINT [FK_EmployeeDepartmentHistory_Employeee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [HumanResources].[Department]([ID]);
GO

---- Employee Role History
ALTER TABLE [HumanResources].[EmployeeRoleHistory]
ADD CONSTRAINT [FK_EmployeeRoleHistory_Employeee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_EmployeeRoleHistory_Role_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [HumanResources].[Role]([ID]);
GO

---- Employee Salary History
ALTER TABLE [HumanResources].[EmployeeSalaryHistory]
ADD CONSTRAINT [FK_EmployeeSalaryHistory_Employeee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee]([ID]);
GO

-- PRODUCTION
---- Manufacturing and Product Inventory Location
ALTER TABLE [Production].[Location]
ADD CONSTRAINT [FK_Location_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Information].[Address]([ID]);
GO

---- Product SubCategory
ALTER TABLE [Production].[ProductSubCategory]
ADD CONSTRAINT [FK_ProductSubCategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [Production].[ProductCategory]([ID]);
GO

---- ProductLine
ALTER TABLE [Production].[ProductLine]
ADD CONSTRAINT [FK_ProductLine_ProductSubCategory_ProductSubCategoryID] FOREIGN KEY ([ProductSubCategoryID]) REFERENCES [Production].[ProductSubCategory]([ID]);
GO

---- Product
ALTER TABLE [Production].[Product]
ADD CONSTRAINT [FK_Product_ProductLine_ProductLineID] FOREIGN KEY ([ProductLineID]) REFERENCES [Production].[ProductLine]([ID]),
    CONSTRAINT [FK_Product_UnitMeasurement_UnitMeasurementID] FOREIGN KEY ([UnitMeasurementID]) REFERENCES [Production].[UnitMeasurement]([ID]),
    CONSTRAINT [FK_Product_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Production].[Location]([ID]);
GO

---- Product Cost History
ALTER TABLE [Production].[ProductCostHistory]
ADD CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

---- Product Price History
ALTER TABLE [Production].[ProductPriceHistory]
ADD CONSTRAINT [FK_ProductPriceHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

-- MANUFACTURING
---- Work Order
ALTER TABLE [Production].[WorkOrder]
ADD CONSTRAINT [FK_WorkOrder_Employee_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_WorkOrder_Employee_ApprovedByID] FOREIGN KEY ([ApprovedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_WorkOrder_WorkOrderStatus_WorkOrderStatusID] FOREIGN KEY ([WorkOrderStatusID]) REFERENCES [Production].[WorkOrderStatus]([ID]);
GO

---- Work Order Detail
ALTER TABLE [Production].[WorkOrderDetail]
ADD CONSTRAINT [FK_WorkOrderDetail_WorkOrder_WorkOrderID] FOREIGN KEY ([WorkOrderID]) REFERENCES [Production].[WorkOrder]([ID]),
    CONSTRAINT [FK_WorkOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

-- PURCHASING
---- Supplier
ALTER TABLE [Purchasing].[Supplier]
ADD CONSTRAINT [FK_Supplier_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Information].[Address]([ID]);
GO

---- Product Supplier
ALTER TABLE [Production].[ProductSupplier]
ADD CONSTRAINT [FK_ProductSupplier_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]),
    CONSTRAINT [FK_ProductSupplier_Supplier_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [Purchasing].[Supplier]([ID]),
    CONSTRAINT [FK_ProductSupplier_UnitMeasurement_UnitMeasurementID] FOREIGN KEY ([UnitMeasurementID]) REFERENCES [Production].[UnitMeasurement]([ID]);
GO

---- Purchase Order
ALTER TABLE [Purchasing].[PurchaseOrder]
ADD CONSTRAINT [FK_PurchaseOrder_Supplier_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [Purchasing].[Supplier]([ID]),
    CONSTRAINT [FK_PurchaseOrder_Employee_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_PurchaseOrder_Employee_ApprovedByID] FOREIGN KEY ([ApprovedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_PurchaseOrder_PurchaseOrderStatus_POStatusID] FOREIGN KEY ([POStatusID]) REFERENCES [Purchasing].[PurchaseOrderStatus]([ID]),
    CONSTRAINT [FK_PurchaseOrder_Location_ShipToLocationID] FOREIGN KEY ([ShipToLocationID]) REFERENCES [Production].[Location]([ID]);
GO

---- Purchase Order Detail
ALTER TABLE [Purchasing].[PurchaseOrderDetail]
ADD CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrder_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [Purchasing].[PurchaseOrder]([ID]),
    CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

---- Purchase Order Transaction History
ALTER TABLE [Purchasing].[POTransactionHistory]
ADD CONSTRAINT [FK_POTransactionHistory_PurchaseOrder_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [Purchasing].[PurchaseOrder]([ID]),
    CONSTRAINT [FK_POTransactionHistory_Employee_CheckedByID] FOREIGN KEY ([CheckedByID]) REFERENCES [HumanResources].[Employee]([ID]);
GO

---- Purchase Order Transaction History Detail
ALTER TABLE [Purchasing].[POTransactionHistoryDetail]
ADD CONSTRAINT [FK_POTransactionHistoryDetail_POTransactionHistory_POTransactionHistoryID] FOREIGN KEY ([POTransactionHistoryID]) REFERENCES [Purchasing].[POTransactionHistory]([ID]),
    CONSTRAINT [FK_POTransactionHistoryDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

---- Purchase Order Payment History
ALTER TABLE [Purchasing].[POPaymentHistory]
ADD CONSTRAINT [FK_POPaymentHistory_POTransactionHistory_POTransactionHistoryID] FOREIGN KEY ([POTransactionHistoryID]) REFERENCES [Purchasing].[POTransactionHistory]([ID]),
    CONSTRAINT [FK_POPaymentHistory_PaymentMethod_PaymentMethodID] FOREIGN KEY ([PaymentMethodID]) REFERENCES [PaymentMethod]([ID]),
    CONSTRAINT [FK_POPaymentHistory_PaymentStatus_PaymentStatusID] FOREIGN KEY ([PaymentStatusID]) REFERENCES [PaymentStatus]([ID]),
    CONSTRAINT [FK_POPaymentHistory_Employee_PaidByID] FOREIGN KEY ([PaidByID]) REFERENCES [HumanResources].[Employee]([ID]);
GO

-- SALES
---- Customer 
ALTER TABLE [Sales].[Customer]
ADD CONSTRAINT [FK_Customer_CustomerType_CustomerTypeID] FOREIGN KEY ([CustomerTypeID]) REFERENCES [Sales].[CustomerType]([ID]),
    CONSTRAINT [FK_Customer_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Information].[Address]([ID]);
GO

---- Sales Order
ALTER TABLE [Sales].[SalesOrder]
ADD CONSTRAINT [FK_SalesOrder_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer]([ID]),
    CONSTRAINT [FK_SalesOrder_Employee_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_SalesOrder_SalesOrderType_SalesOrderTypeID] FOREIGN KEY ([SalesOrderTypeID]) REFERENCES [Sales].[SalesOrder]([ID]),
    CONSTRAINT [FK_SalesOrder_SalesOrderStatus_SalesOrderStatusID] FOREIGN KEY ([SalesOrderStatusID]) REFERENCES [Sales].[SalesOrderStatus]([ID]),
    CONSTRAINT [FK_SalesOrder_RecurrenceType_RecurrenceTypeID] FOREIGN KEY ([RecurrenceTypeID]) REFERENCES [Sales].[RecurrenceType]([ID]),
    CONSTRAINT [FK_SalesOrder_SalesOrder_OriginalSalesOrderID] FOREIGN KEY ([OriginalSalesOrderID]) REFERENCES [Sales].[SalesOrder]([ID]),
    CONSTRAINT [FK_SalesOrder_Address_ShipToAddressID] FOREIGN KEY ([ShipToAddressID]) REFERENCES [Information].[Address]([ID]);
GO

---- Sales Order Detail
ALTER TABLE [Sales].[SalesOrderDetail]
ADD CONSTRAINT [FK_SalesOrderDetail_SalesOrder_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrder]([ID]),
    CONSTRAINT [FK_SalesOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]),
    CONSTRAINT [FK_SalesOrderDetail_Discount_DiscountID] FOREIGN KEY ([DiscountID]) REFERENCES [Sales].[Discount]([ID]);
GO

---- Shipping History
ALTER TABLE [Sales].[ShippingHistory]
ADD CONSTRAINT [FK_ShippingHistory_SalesOrder_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrder]([ID]),
    CONSTRAINT [FK_ShippingHistory_ShippingMethod_ShippingMethodID] FOREIGN KEY ([ShippingMethodID]) REFERENCES [ShippingMethod]([ID]),
    CONSTRAINT [FK_ShippingHistory_Employee_ShippedByID] FOREIGN KEY ([ShippedByID]) REFERENCES [HumanResources].[Employee]([ID]),
    CONSTRAINT [FK_ShippingHistory_ShippingStatus_ShippingStatusID] FOREIGN KEY ([ShippingStatusID]) REFERENCES [ShippingStatus]([ID]);
GO

----  Shipping History Detail
ALTER TABLE [Sales].[ShippingHistoryDetail]
ADD CONSTRAINT [FK_ShippingHistoryDetail_ShippingHistory_ShippingHistoryID] FOREIGN KEY ([ShippingHistoryID]) REFERENCES [Sales].[ShippingHistory]([ID]),
    CONSTRAINT [FK_ShippingHistoryDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product]([ID]);
GO

---- Sales Order Payment History
ALTER TABLE [Sales].[SOPaymentHistory]
ADD CONSTRAINT [FK_SOPaymentHistory_PaymentMethod_PaymentMethodID] FOREIGN KEY ([PaymentMethodID]) REFERENCES [PaymentMethod]([ID]),
    CONSTRAINT [FK_SOPaymentHistory_PaymentStatus_PaymentStatusID] FOREIGN KEY ([PaymentStatusID]) REFERENCES [PaymentStatus]([ID]),
    CONSTRAINT [FK_SOPaymentHistory_PaymentHistory_ShippingHistoryID] FOREIGN KEY ([ShippingHistoryID]) REFERENCES [Sales].[ShippingHistory]([ID]);
GO


---- Product Recall Histoty
ALTER TABLE [Sales].[ProductRecallHistory]
ADD CONSTRAINT [FK_ProductRecallHistory_RecallReason_RecallReasonID] FOREIGN KEY ([RecallReasonID]) REFERENCES [Sales].[RecallReason]([ID]),
    CONSTRAINT [FK_ProductRecallHistory_SalesOrderDetail_SODetailID] FOREIGN KEY ([SODetailID]) REFERENCES [Sales].[SalesOrderDetail]([ID]);
GO