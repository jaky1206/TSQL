USE [master];
GO
CREATE LOGIN [testLogin] WITH PASSWORD = N'testlogin123@';
GO

USE [testDatabase];
GO
CREATE USER [testUser] FOR LOGIN [testLogin];
GO

USE [testDatabase];
GO
GRANT EXECUTE
    , SELECT
    , INSERT
    , UPDATE
    , DELETE
ON SCHEMA::[Proxy]
TO  [testuser];
GO


