--Viewing Data
	SELECT * 
	FROM intakes

--Checking null values in Animal_ID
	SELECT Animal_ID
	FROM dbo.intakes	
	WHERE Animal_ID IS NULL;

--Checking Count on Animal_ID  - There are 124,120 values
	SELECT Count(Animal_ID)
	From dbo.intakes

--Updating Table to change NULL to No Name 
	UPDATE dbo.intakes
	SET Name='No Name'
	WHERE Name IS NULL;

--Removing astericks from Name by creating another column in that view
	SELECT [Name],  
	REPLACE([Name], '*', '') AS [Clean Name]
	FROM dbo.intakes
	Where Name Like '%*%'
	Order By name desc

--Updating table to remove astericks from name
	UPDATE dbo.intakes
	SET Name = REPLACE(Name, '*', '');

--Removing MonthYear column as it is duplicate and not needed
	ALTER TABLE dbo.intakes
	DROP COLUMN MonthYear;

--Viewing all intake types
	Select distinct intake_type
	from intakes

--Viewing animal type
	select distinct animal_type
	from intakes

--Removing all animals except cats or dog   7218 rows removed
	DELETE FROM Intakes
	WHERE Animal_Type like 'Bird' or Animal_Type like 'Livestock' or Animal_Type like 'Other' 

--Viewing OwnerAddress broken into three different columns

	Select found_location, LEFT(found_location, CHARINDEX(' in ',Found_Location)) AS address_location, -- viewing address only
	RIGHT(found_location,LEN(found_location)- CHARINDEX(' in ',Found_Location)) as city_location, -- viewing city only
	RIGHT (found_location,4) as State  -- viewing state only
	from Intakes
 
	 -- Adding column for city
		ALTER TABLE dbo.intakes
		ADD city_location nvarchar(100)

	--Updating database to add information to column city_location
		Update dbo.intakes
		SET city_location = RIGHT(found_location,LEN(found_location)- CHARINDEX(' in ',Found_Location))

	-- Querying the removal of theRemoving in from City
		SELECT [city_location],  
		REPLACE([city_location], 'in ', '') AS [city_only], 
		REPlACE(city_location
		FROM dbo.intakes
		Where city_location Like '%in %'
		Order By city_location desc
	

