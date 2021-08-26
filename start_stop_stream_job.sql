EXEC sys.sp_stop_streaming_job @name = N'ResultInsertJob'
-- use this only while updating the stream job
-- EXEC sys.sp_drop_streaming_job @name= N'ResultInsertJob'