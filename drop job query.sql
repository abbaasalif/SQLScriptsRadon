USE [iot];
GO

DROP TABLE [dbo].[Temperature];
EXEC sys.sp_stop_streaming_job @name= N'ResultInsertJob';
EXEC sys.sp_drop_streaming_job @name= N'ResultInsertJob';
DROP EXTERNAL STREAM [DataGeneratorInput];
DROP EXTERNAL DATA SOURCE [EdgeHub];
DROP EXTERNAL STREAM [TableOutput];
Drop EXTERNAL DATA SOURCE [LocalSQL];
DROP DATABASE SCOPED CREDENTIAL [SQLCredential];
DROP MASTER KEY;