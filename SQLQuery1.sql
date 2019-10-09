-- 1 zad
CREATE OR ALTER PROC usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT 
	FirstName,
	LastName
	FROM Employees
	WHERE Salary > 35000
END

EXEC dbo.usp_GetEmployeesSalaryAbove35000

--zad2

CREATE PROC usp_GetEmployeesSalaryAboveNumber(@filter DECIMAL(18,4))
AS
BEGIN
	SELECT 
	FirstName,
	LastName
	FROM Employees
	WHERE Salary >= @filter
END

EXEC dbo.usp_GetEmployeesSalaryAboveNumber 48100

--zad 3
CREATE PROC usp_GetTownsStartingWith(@startWith VARCHAR(10))
AS
BEGIN
	SELECT
	t.[Name]
	FROM Towns AS t
	WHERE LEFT(t.[Name],LEN(@startWith)) = @startWith
END

EXEC dbo.usp_GetTownsStartingWith 'b'

--zad 4
CREATE PROC usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
BEGIN
	SELECT
	e.FirstName,
	e.LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @townName
END

EXEC dbo.usp_GetEmployeesFromTown 'Sofia'

--zad 5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @result VARCHAR(10);
	IF(@salary <30000)
	BEGIN
		SET @result = 'Low'
	END
	IF(@salary BETWEEN 30000 AND 50000)
	BEGIN
		SET @result = 'Average'
	END
	IF(@salary > 50000)
	BEGIN
		SET @result = 'High'
	END

	RETURN @result;
END

SELECT
	e.Salary,
	dbo.ufn_GetSalaryLevel(e.Salary) AS [Salary Level]
FROM Employees AS e

--zad 6
CREATE PROC usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(10))
AS
BEGIN
	SELECT
		e.FirstName,
		e.LastName
	FROM Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @salaryLevel
END

EXEC dbo.usp_EmployeesBySalaryLevel 'High'

--zad 7 NEDOVYRSHENA
CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @setIndex INT = 1
	DECLARE @validCharsCount INT = 0
	DECLARE @checkedChars VARCHAR(50)
	WHILE(@setIndex < LEN(@setOfLetters) + 1)
	BEGIN
		DECLARE @hasNotBeenChecked INT = 1
		DECLARE @checkedIndex INT = 1
		WHILE(@checkedIndex < LEN(@checkedChars) + 1)
		BEGIN
			IF(SUBSTRING(@checkedChars,@checkedIndex,1) = SUBSTRING(@setOfLetters,@setIndex,1))
			BEGIN
				SET @hasNotBeenChecked = 0
			END

			SET @checkedIndex = @checkedIndex + 1
		END
		IF(@hasNotBeenChecked = 1)
		BEGIN

			DECLARE @wordIndex INT = 1
			WHILE(@wordIndex < LEN(@word) + 1)
			BEGIN
				
				IF(SUBSTRING(@setOfLetters,@setIndex,1) = SUBSTRING(@word,@wordIndex,1))
				BEGIN
					SET @validCharsCount = @validCharsCount + 1
				END
				
				SET @wordIndex = @wordIndex + 1
			END
			SET @checkedChars = CONCAT(@checkedChars,SUBSTRING(@setOfLetters,@setIndex,1))
		END
	SET @setIndex = @setIndex + 1
	END
	DECLARE @result BIT
	IF(@validCharsCount = LEN(@word))
	BEGIN
		SET @result = 1
	END
	ELSE
	BEGIN
		SET @result = 0
	END
	RETURN @result
END

SELECT dbo.ufn_IsWordComprised('pppp','Guy')



---------  ^
--DEBUG 7  |
---------  V
DECLARE @owi INT = 1
WHILE @owi < LEN('oistmiahf') + 1

BEGIN
--PRINT SUBSTRING('STATICSTRING',@owi,1)

	DECLARE @wi INT = 0
	WHILE @wi < LEN('Sofia') + 1
	BEGIN
		--PRINT SUBSTRING('SOFIA',@wi,1)
		SET @wi = @wi + 1

		IF(SUBSTRING('oistmiahf',@owi,1) = SUBSTRING('Sofia',@wi,1))
		BEGIN
			PRINT SUBSTRING('oistmiahf',@owi,1)
		END
	END

	SET @owi = @owi + 1
END

DECLARE @addToMe VARCHAR(50)

SET @addToMe = CONCAT(@addToMe,'a')

SELECT @addToMe
