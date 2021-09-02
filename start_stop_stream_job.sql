EXEC sys.sp_create_streaming_job @name=N'ResultInsertJob',
@statement=N'SELECT * INTO TableOutput from DataGeneratorInput'

EXEC sys.sp_start_streaming_job @name = N'ResultInsertJob'
-- EXEC sys.sp_start_streaming_job @name = N'ResultInsertJob'
-- use this only while updating the stream job
-- EXEC sys.sp_drop_streaming_job @name= N'ResultInsertJob'
