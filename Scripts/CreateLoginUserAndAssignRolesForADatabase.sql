USE [master];
GO

IF NOT EXISTS
(
    SELECT name
    FROM sys.sysusers
    WHERE name = 'testLogin'
)
BEGIN
    CREATE LOGIN [testLogin]
    WITH PASSWORD = N'testlogin123@'
       , DEFAULT_DATABASE = [master];
END;

USE [testDatabase];
GO

IF NOT EXISTS
(
    SELECT [name]
    FROM sys.database_principals
    WHERE name = N'testUser'
)
BEGIN
    CREATE USER [testUser] FOR LOGIN [testLogin];
END;

IF DATABASE_PRINCIPAL_ID('db_executor') IS NULL
BEGIN
    CREATE ROLE db_executor;
END;
GO

IF DATABASE_PRINCIPAL_ID('db_executor') IS NOT NULL
BEGIN
    GRANT EXECUTE
    TO  db_executor;
END;
GO

EXEC sp_addrolemember @rolename = N'db_datareader'
                    , @membername = N'testUser';
GO

EXEC sp_addrolemember @rolename = N'db_datawriter'
                    , @membername = N'testUser';
GO

EXEC sp_addrolemember @rolename = N'db_executor'
                    , @membername = N'testUser';
GO
