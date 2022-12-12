/* -

Austin Animal Shelter SQL Queries

		QUESTIONS: 
		•	When are intakes the highest/lowest  To possibly offer promotions
		o	What months are highest/lowest?
		*   What time of day is the highest / lowest
		•	Are there more cats or dogs in the shelter? 
		•	What is the average age upon intake and outcome? 
		•	What is the most common outcome? 
		•	Is there a breed that is more common than others? 
		•	Is there a color that is more common? 
		•	Does color affect adoption rates? 
		•	How many are repeat animals
		•	What is the most common name? 
		•	How many are euthanized? 
		•	How many died in care? 
		•	How many were adopted? 
		•	What are the reasons that owners give up pets? 
		o	Most common reason?  

		5 characteristics of quality data

    Validity. The degree to which your data conforms to defined business rules or constraints.
    Accuracy. Ensure your data is close to the true values.
    Completeness. The degree to which all required data is known.
    Consistency. Ensure your data is consistent within the same dataset and/or across multiple data sets.
    Uniformity. The degree to which the data is specified using the same unit of measure.


		Data Cleaning Steps
			1.  Remove duplicates or irrelevant information
			2.  Fix structural errors (data consistency)
			3.  Remove/filter outliers
			4.  Handle missing data
			5.  Validate and QA

*/

-- OVERVIEW of Intakes
		Select * from Intakes;

-- OVERVIEW of Outcomes
		Select * from Outcomes;

-- DUPLICATES
	-- Checking for Intake duplicates  -- there are 23 duplicates
			Select Animal_Id, Name, DateTime, COUNT(*)
			From Intakes	
			Group By Animal_ID, Name, DateTime
			Having Count (*) > 1
			Order By Animal_ID;

		-- Deleting Intake Duplicates - Deleted 23 values
				WITH CTE AS
				(
				SELECT *,ROW_NUMBER() OVER (PARTITION BY Animal_ID,Name,DateTime ORDER BY Animal_ID,Name,DateTime) AS RN

				FROM Intakes
				)

				Delete FROM CTE WHERE RN<>1;

		-- Changed Column [Animal ID] to make intake column of [Animal_ID]. Renamed column
		-- Checking for duplicates for Outcomes -- There are 17 duplicates 

			Select Animal_Id, Name, DateTime, COUNT(*)
			From Outcomes	
			Group By Animal_ID, Name, DateTime
			Having Count (*) > 1
			Order By Animal_ID

		-- Deleting Outcome Duplicates - Deleted 17 values
				
			WITH CTE AS
			(
			SELECT *,ROW_NUMBER() OVER (PARTITION BY Animal_ID,Name,DateTime ORDER BY Animal_ID,Name,DateTime) AS RN

			FROM Outcomes
			)

			DELETE FROM CTE WHERE RN<>1

		-- Verifying Duplicates were removed for Outcomes
			Select Animal_Id, Name, DateTime, COUNT(*)
			From Outcomes	
			Group By Animal_ID, Name, DateTime
			Having Count (*) > 1
			Order By Animal_ID

-- IRRELEVANT INFORMATION

		-- Checking Animal Type to ensure it is limited to cats and dogs.  
		-- There are Birds, Livestock, and Other that need to be removed as they are not part of the analysis.
		Select Distinct Animal_Type
		from Intakes

		--Removing all animals from Intakes except cats or dog.   7215 rows removed
		Select * FROM Intakes
		WHERE Animal_Type like 'Bird' or Animal_Type like 'Livestock' or Animal_Type like 'Other' 

		--Changed Animal Type in Outcomes to match column name in Intakes.  Updated column from Animal Type to Animal_Type. 
		-- Viewing Animal Types in Outcomes
			Select distinct [Animal_Type]
			from Outcomes

		--Removing all animals from Outcomes except cats or dog.   7212 rows removed
		DELETE FROM Outcomes
		WHERE Animal_Type like 'Bird' or Animal_Type like 'Livestock' or Animal_Type like 'Other' 

-- REMOVING IRRELEVANT COLUMN
		
		--Removing MonthYear from Intake as it is a redundant column from DateTime
		Alter table dbo.intakes
		Drop column MonthYear

		--Removing MonthYear from Outcome as it is a redundant column from DateTime
		--Select * from outcomes
			Alter table dbo.outcomes	
			Drop column MonthYear

-- CONSISTENCY

		Select * from intakes;

		SELECT Distinct Intake_Type from intakes -- No cleaning needed as all fields are relevant
		SELECT Distinct Outcome_Type from Outcomes  -- Need to change missing values to Unknown
			
			Select *
			From outcomes
			Where outcome_type = ''

			Update outcomes
			Set Outcome_Type = 'Unknown'
			Where outcome_Type = ''



		SELECT Distinct Intake_Condition from intakes -- No cleaning needed as all fields are relevant
		SELECT Distinct Outcome_Subtype from Outcomes -- We will leave these alone as I'm not familiar with this termin

		SELECT Distinct sex_upon_intake from intakes  -- Below changed 1 null value to Unknown	
		--Checking null values in Sex_upon_intake  - There is 1 value NULL that needs to be changed to Unkown. 
			SELECT *
			FROM intakes	
			WHERE sex_upon_intake = 'Unknown';

		-- Changing Null to Unknown for Sex_Upon_Intake
			--SELECT Sex_upon_Intake,
			--REPLACE ([Sex_Upon_Intake], 'NULL', 'Unknown') AS Test
			--from intakes	
			--WHERE Sex_Upon_Intake = 'NULL'
			
			Update dbo.Intakes
			SET Sex_upon_Intake = REPLACE(Sex_upon_Intake, 'NULL', 'Unknown')
			WHERE Sex_upon_Intake = 'NULL'
		
		SELECT Distinct sex_upon_outcome from Outcomes  -- Below changed 1 null value to Unknown	
		
			SELECT sex_upon_outcome from Outcomes
			Where sex_upon_outcome = 'NULL'
			
			Update dbo.Outcomes	
			SET Sex_Upon_Outcome = 'Unknown'
			Where Sex_Upon_Outcome = 'NULL'


		SELECT Distinct age_upon_intake from intakes 
		Order by age_upon_intake

				SELECT Animal_ID, Name, DateTime, age_upon_intake from intakes  -- There are -1 year, -2, and -3 years for a total of 7 values that need to be removed. 
				WHERE age_upon_intake like '-1 years' or age_upon_intake like '-2 years' or Age_upon_Intake like '-3 years'
				Order by age_upon_intake
	
				-- Deleting age upon Intake with negative years
				DELETE from dbo.intakes
				WHERE age_upon_intake like '-1 years' or age_upon_intake like '-2 years' or Age_upon_Intake like '-3 years'
	
				-- Deleting age upon Outcome with negative years
				DELETE from dbo.Outcomes
				WHERE [Age upon Outcome] like '-1 years' or [Age upon Outcome] like '-2 years' or [Age upon Outcome] like '-3 years'

		SELECT * FROM INTAKES 
		
		SELECT Top 10 Breed, COUNT(Breed) AS Breed_Count  -- displays top 10 breeds from Outcomes and the count number. 
		from outcomes
		Group By Breed
		Order by Breed_Count desc
	
		SELECT Top 10 Breed, COUNT(Breed) AS Breed_Count  -- displays top 10 breeds from Intakes and the count number. 
		from Intakes
		Group By Breed
		Order by Breed_Count desc

		SELECT Distinct color from intakes -- no cleaning appears to be needed
		Order by Color

		SELECT Distinct color from outcomes -- no cleaning appears to be needed
		Order by Color

-- 2.  Structural Errors
		
		Select * from Intakes

			--Intake Name Column needs adjusting those with an asterick.  27,803 Rows Updated 
					SELECT [Name],  
					REPLACE([Name], '*', '') AS [Clean Name]
					FROM dbo.intakes
					Where Name Like '%*%'
					Order By name desc

					UPDATE dbo.intakes
					SET Name = REPLACE(Name, '*', '')
					WHERE Name Like '%*%'

			--Outcome Name Column needs adjusting those with an asterick.
					SELECT [Name],  -- 28,080 rows to be updated
					REPLACE([Name], '*', '') AS [Clean Name]
					FROM dbo.Outcomes	
					Where Name Like '%*%'
					Order By name desc

					Update dbo.outcomes
					SET Name = REPLACE([Name], '*', '')
					Where Name Like '%*%'


			-- Intake Viewing and Updating Null values to Unknown in Name 32,788 values
				Select Name
				From Intakes
				Where Name is NULL

				UPDATE intakes
				Set Name = 'Unknown'
				Where Name is NULL
		
			-- Outcome Viewing and Updating Empty values to Unknown 32,788 values
								
				Update dbo.outcomes
				SET Name = 'Unknown'
				WHERE Name = ''

			-- Outcomes for names with only numbers - 179 rows
				SELECT Name 
				FROM OUTCOMES 
				Where Name not like '%[A-Za-z]%'

				Update Outcomes 
				Set Name ='Unknown' 
				Where Name not like '%[A-Za-z]%' 
			

			-- Replacing the empty cells
			UPDATE dbo.intakes
			SET Name = Trim(REPLACE(Name, '', 'Unknown'))
			Where Name Like ''

			-- Updating empty Names to Nulls  ---- CANNOT SEEM TO UPDATE THE THREE VALUES THAT ARE BLANK.  
			Update Intakes
			SET Name = REPLACE(Name, ' ', 'Unknown') 
			Where Name Like ''

			-- Or Alternative

					--Update intakes
					--Set Name =  'Unknown'
					--Where Name Like ''
	
			--Removing Grams from Name.
				SELECT [Name],  
				REPLACE([Name], 'Grams', '') AS [Clean Name]
				FROM dbo.intakes
				Where Name Like '%Grams%'
				Order By name desc

			-- Also removes Grams from Name  -- Did not continue down this path as the number of names is so few for main search
			With CTE As   -- 

				(Select Name, LEFT (Name, CHARINDEX('Grams', Name) -1) AS Grams
				From Intakes
				Where Name like '%Grams%'
				)

			--Replace numeric characters with empty space from video using Translate (DNU)
			
			With CTE AS 
			(
			Select Name, 
				Trim(TRANSLATE(Name, '0123456789', '          ')) as Clean_Name
			from Intakes
			Where Name Like '%Grams'
			)

			Select *  
			from CTE
			Where Name Like'%Grams'

			Select  distinct name from Intakes
			Order by Name asc
			
			--Updating names with only numbers 
			SELECT Name FROM INTAKES Where Name not like '%[A-Za-z]%'
			update intakes set name='Unknown' where name not like '%[A-Za-z]%' 

--Updating Intake table to add Date_Converted and Time Converted columns
		Alter Table intakes
		Add Date_Converted date,
		Time_Converted time;


--Converting Intake Date/Time and extracting the Date only
		select datetime,
		convert(varchar,[datetime], 101) Converted_Date
		from Intakes	
		
		Update intakes
		Set Date_Converted = FORMAT([datetime], 'MM-dd-yyyy')
		Where Date_Converted is NOT NULL

-- Extracting time only in am/pm  116875 rows effected
		
		Select * from Intakes
		
		SELECT DateTime,
		FORMAT([datetime], 'hh:mm tt') AS Converted_Date
		from Intakes
		
		Update intakes
		Set Time_Converted = FORMAT([datetime], 'hh:mm tt')
		Where Time_Converted is NULL

				-- Example section using convert to change to time only. Extracting time only in Military time and includes miliseconds. 
						--select datetime,
						--convert(varchar,[datetime], 108) Converted_Date
						--from Intakes
		
		Select * from Outcomes

--Outcomes table has datetime listed as varchar, need to change to datetime2

ALTER TABLE Outcomes
ALTER COLUMN DateTime datetime; 

--Updating Intake table to add Date_Converted and Time Converted columns
		Alter Table Outcomes	
		Add Date_Converted date,
		Time_Converted time;

--Converting Date/Time and extracting the Date only -- 117255 rows effected

		Select Datetime,
		Convert (varchar,[datetime], 101) Test
		From Outcomes

		Update Outcomes  
		Set Date_Converted = Convert (varchar,[datetime], 101)
	
--Converting Outcome Date/Time and extracting the Time only. tt refers to am/pm

	Select * from Outcomes

		SELECT DateTime,
		FORMAT([datetime], 'hh:mm tt') AS Converted_Date
		from Outcomes

		Update Outcomes
		Set Time_Converted = FORMAT([datetime], 'hh:mm tt')
		Where Time_Converted is NULL

-- Selecting top 25 Names
		Select Top 25 Name, COUNT(Name) as Name_Count
		from Intakes
		Group by Name
		Order by Name_Count desc
			
		Select Top 25 Name, COUNT(Name) as Name_Count
		from Outcomes
		Group by Name
		Order by Name_Count desc

/* Final notes: 

	1. Those names including gram in them will not make a difference when filtering for top 100, therefore, going to leave names as is. 
	2. Leaving Address alone since it's not delimited; may come back and approach towards end of survey.  
	3.  --SQL Questions will be answered in different Query
	*/




