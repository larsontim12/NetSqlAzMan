﻿CREATE FUNCTION [dbo].[netsqlazman_MergeAuthorizations](@AUTH1 tinyint, @AUTH2 tinyint)
RETURNS tinyint
AS
BEGIN
-- 0 Neutral 1 Allow 2 Deny 3 AllowWithDelegation
DECLARE @RESULT tinyint
IF @AUTH1 IS NULL 
BEGIN
	SET @RESULT = @AUTH2
END
ELSE 
IF @AUTH2 IS NULL 
BEGIN
SET @RESULT = @AUTH1
END
ELSE
BEGIN
	IF @AUTH1 = 2 SET @AUTH1 = 4 -- DENY WINS
	ELSE
	IF @AUTH2 = 2 SET @AUTH2 = 4 -- DENY WINS
	IF @AUTH1 >= @AUTH2
                	SET @RESULT = @AUTH1
	ELSE
	IF @AUTH1 < @AUTH2
		SET @RESULT = @AUTH2
	IF @RESULT = 4 SET @RESULT = 2
END
RETURN @RESULT
END

