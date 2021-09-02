select 
    * 
    from Temperature
    WHERE datetime >= dateadd(day,datediff(day,1,GETDATE()),0)
        AND datetime < dateadd(day,datediff(day,0,GETDATE()),0) order by datetime desc