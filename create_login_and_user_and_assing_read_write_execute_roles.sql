USE [master];
GO

IF NOT EXISTS
(
    SELECT name
    FROM sys.sysusers
    WHERE name = 'testuser'
)
BEGIN
    CREATE LOGIN [testuser]
    WITH PASSWORD = N'testuser123@'
       , DEFAULT_DATABASE = [master];
END;

USE [abcd];
GO

IF NOT EXISTS
(
    SELECT [name]
    FROM sys.database_principals
    WHERE name = N'testuser'
)
BEGIN
    CREATE USER [testuser] FOR LOGIN [testuser];
END;

IF DATABASE_PRINCIPAL_ID('db_executor') IS NULL
BEGIN
    CREATE ROLE db_executor;
    GRANT EXECUTE
    TO  db_executor;
END;
GO

IF DATABASE_PRINCIPAL_ID('db_executor') IS NOT NULL
BEGIN
    GRANT EXECUTE
    TO  db_executor;
END;
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
