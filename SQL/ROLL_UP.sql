SELECT DISTINCT 
        ST2.UNIQUE_ID_1, ST2.UNIQUE_ID_2 
        ,( 
                        SELECT  ST1.FIELD_TO_ROLL_UP + ' / ' --AS [TEXT()] 
                        FROM  TABLENAME_TO_BE_ROLLED_UP_FROM ST1 
                        WHERE   ST1.UNIQUE_ID_1 = ST2.UNIQUE_ID_1 
                        AND     ST1.UNIQUE_ID_2 = ST2.UNIQUE_ID_2 
                        ORDER BY ST1.UNIQUE_ID_1, ST1.UNIQUE_ID_2 
                        ,ST1.FIELD_TO_ROLL_UP ASC 
                        FOR XML PATH ('') 
                ) CODES_ROLLED_UP 
        FROM   TABLENAME_TO_BE_ROLLED_UP_FROM  ST2 
