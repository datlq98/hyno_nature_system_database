PRINT '';
PRINT '*** Creating Foreign Key Constraints';
GO


--- Information 
ALTER TABLE [Person].[Province] ADD 
    CONSTRAINT [FK_Province_Country_CountryID] FOREIGN KEY 
    (
        [CountryID]
    ) REFERENCES [Person].[Country](
        [ID]
    );
GO
ALTER TABLE [Person].[City] ADD 
    CONSTRAINT [FK_City_Province_ProvinceID] FOREIGN KEY 
    (
        [ProvinceID]
    ) REFERENCES [Person].[Province](
        [ID]
    );
GO
ALTER TABLE [Person].[Dictrict] ADD 
    CONSTRAINT [FK_Strict_City_CityID] FOREIGN KEY 
    (
        [CityID]
    ) REFERENCES [Person].[City](
        [ID]
    );
GO
ALTER TABLE [Person].[Ward] ADD 
    CONSTRAINT [FK_Ward_Dictrict_DistictID] FOREIGN KEY 
    (
        [DistictID]
    ) REFERENCES [Person].[Dictrict](
        [ID]
    );
GO
ALTER TABLE [Person].[Address] ADD 
    CONSTRAINT [FK_Address_Ward_DistictID] FOREIGN KEY 
    (
        [WardID]
    ) REFERENCES [Person].[Ward](
        [ID]
    );
GO

---- Human Resource

ALTER TABLE [HumanResources].[Employee] ADD 
    CONSTRAINT [FK_Employeee_Employee_LineManagerID] FOREIGN KEY 
    (
        [LineManagerID]
    ) REFERENCES [HumanResources].[Employee](
        [ID]
    );
GO

ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] ADD 
    CONSTRAINT [FK_Employeee_EmployeeDepartmentHistory_EmployeeID] FOREIGN KEY 
    (
        [EmployeeID]
    ) REFERENCES [HumanResources].[Employee](
        [ID]
    ),
    CONSTRAINT [FK_Department_EmployeeDepartmentHistory_DepartmentID] FOREIGN KEY 
    (
        [DepartmentID]
    ) REFERENCES [HumanResources].[Department](
        [ID]
    );
GO

ALTER TABLE [HumanResources].[EmployeeRoleHistory] ADD 
    CONSTRAINT [FK_Employeee_EmployeeRoleHistory_EmployeeID] FOREIGN KEY 
    (
        [EmployeeID]
    ) REFERENCES [HumanResources].[Employee](
        [ID]
    ),
    CONSTRAINT [FK_Department_EmployeeRoleHistory_RoleID] FOREIGN KEY 
    (
        [RoleID]
    ) REFERENCES [HumanResources].[Role](
        [ID]
    );;
GO




---- Production
ALTER TABLE [Production].[ProductSubCategory] ADD 
    CONSTRAINT [FK_ProductSubCategory_ProductCategory_ProductCategoryID] FOREIGN KEY 
    (
        [ProductCategoryID]
    ) REFERENCES [Production].[ProductCategory](
        [ID]
    );
GO

ALTER TABLE [Production].[ProductLine] ADD 
    CONSTRAINT [FK_ProductLine_ProductSubCategory_ProductSubCategoryID] FOREIGN KEY 
    (
        [ProductSubCategoryID]
    ) REFERENCES [Production].[ProductSubCategory](
        [ID]
    );
GO

ALTER TABLE [Production].[Product] ADD 
    CONSTRAINT [FK_Product_ProductLine_ProductLineID] FOREIGN KEY 
    (
        [ProductLineID]
    ) REFERENCES [Production].[ProductLine](
        [ID]
    ),
    CONSTRAINT [FK_Product_UnitMeaurement_UnitMeasurementID] FOREIGN KEY 
    (
        [UnitMeasurementID]
    ) REFERENCES [Production].[UnitMeasurement](
        [ID]
    );
GO

ALTER TABLE [Production].[ProductCostHistory] ADD 
    CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ID]
    );
GO