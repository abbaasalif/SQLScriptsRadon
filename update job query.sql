USE master
GO

-- CREATE DATABASE [iot];
-- GO 

USE [iot];
GO

CREATE TABLE [dbo].[Temperature](
	[deviceid] nchar(10) NULL,
	[messageid] int NULL,
	[datetime] datetime NULL,
	[temperature] float NULL,
	[humidity] float NULL,
	[radon] float NULL
) ON [PRIMARY]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S3c3r3t@2021';
GO

-- create stream input from edge hub
-- (See routes setting in deployment2.json)
-- CREATE EXTERNAL FILE FORMAT [JSONFormat]
-- WITH (FORMAT_TYPE = JSON)
-- GO

CREATE EXTERNAL DATA SOURCE [EdgeHub]
WITH (
LOCATION = N'edgehub://'
)
GO

CREATE EXTERNAL STREAM [DataGeneratorInput] WITH
(
	DATA_SOURCE = EdgeHub,
	FILE_FORMAT = JSONFormat,
	LOCATION = N'input1'
)
GO

-- Create stream output to database table

CREATE DATABASE SCOPED CREDENTIAL [SQLCredential]
WITH IDENTITY = 'sa', SECRET = 'Aadmaaa@123'

CREATE EXTERNAL DATA SOURCE [LocalSQL]
WITH (LOCATION = 'sqlserver://tcp:.,1433', CREDENTIAL = [SQLCredential])

CREATE EXTERNAL STREAM [TableOutput] WITH
(
	DATA_SOURCE = [LocalSQL],
	LOCATION = N'iot.dbo.Temperature'
)

--creating a streaming job and starting the job

EXEC sys.sp_create_streaming_job @name=N'ResultInsertJob',
@statement=N'SELECT * INTO TableOutput from DataGeneratorInput'

EXEC sys.sp_start_streaming_job @name = N'ResultInsertJob'
