USE [master];
GO

CREATE ROLE db_executor;
GO

GRANT EXECUTE
TO  db_executor;
GO

CREATE LOGIN [testuser]
WITH PASSWORD = N'testuser123@'
   , DEFAULT_DATABASE = [master];
GO

USE [testdb];
GO

CREATE USER [testuser] FOR LOGIN [testuser];
GO

EXEC sp_addrolemember @rolename = N'db_datareader'
                    , @membername = N'testuser';
GO

EXEC sp_addrolemember @rolename = N'db_datawriter'
                    , @membername = N'testuser';
GO

EXEC sp_addrolemember @rolename = N'db_executor'
                    , @membername = N'testuser';
GO
