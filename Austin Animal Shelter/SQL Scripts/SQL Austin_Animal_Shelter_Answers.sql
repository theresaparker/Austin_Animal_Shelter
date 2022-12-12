/* -

Austin Animal Shelter SQL Queries

		QUESTIONS: 
		•	When months are intakes the highest/lowest for ALL intakes? 
				--Highest:
					--    May = 11780
					--    June = 11486
					--    October = 11201
				--Lowest
					--    February = 7843
					--    March = 8238
					--    January  - 8627
		
		•	When months are adoptions the highest and What months are adoptions the lowest? 
	
				 ----Highest
					--    July = 5575
					--    December = 5535
					--    August  = 5365

				----Lowest
					--    April = 2954
					--    March = 3541
					--    May  = 3916

		o	What time of day are adoptions the highest and lowest?
			
				----Highest 
					--	5pm = 11352
					--	6pm = 9161
					--  4pm = 7534
				----Lowest 
					--	3am = 4
					--	2am = 5
					--  4am = 8

		•	Are there more cats or dogs in the shelter? Dogs

				--Dogs = 70429  = 60% dogs
				--Cats = 46446  = 40% cats

		•	What is the average age/highest count by age upon intake and outcome?  1 year old for both intake and outcome

				--Intake
					-- 18,498 at 1 year old
					-- 17,327 at 2 years old 
					-- 11,854 at 1 month old 

					-- 1 at 24 years old 
					-- 1 at 23 years
					-- 1 at 22 years

				--Ouctome

					-- 18824 at 1 year old 
					-- 17318 at 2 years old 
					-- 14970 at 2 months old 

					-- 1 at 24 years
					-- 1 at 24 years
					-- 5 at 22 years

		•	What is the most common Intake Reason? Strays then Owner Surrenders
						
				73% Strays
				21% Owner Surrenders
					(Out of those 21% for Owner Surrender they were because) 
						--Normal conditions  88.3%
						--Injured 4.8%
						--Sick 3.1%
						--Nursing 2.9%
						--Aged .4%
						--Other .2%
						--Pregnant .1%
						--Medical  .1%
						--Feral  .1%
						--Behavior .000%
				6% Public Assist
				< 1% Abandoned
				< 1% Euthanasia Request

		* What is the most common Outcome Type?  Adoption
			
			--Percentage of Each Outcome Type
            --Adoption 46.6%
            --Transfer 30.4%
            --Return to Owner 18.3%
            --Euthanisia 3.2%
            --Died .8%
            --Rto-Adopt  .6%
            --Disposal .1%
            --Missing .1%
            --Unknown 0%
            --Relocate 0%
				
			-–Out of those that are euthanized EUTHANIZED what is the reason? Suffering
				--Aggressive 14.4%
				--Rabies Risk 4.8%
				--Beahvior 4.3%
				--At Vet 4.2%
				--Medical 3.8%
				--Court/Investigation .8%
				--Blank .7%

		•	Is there a breed that is more common than others? 
				Dogs:
				Top Intake Dog is:  Pitbuls Mix, Labrador Retreiver Mix, Chihuahua Shorthair mix
				Top Adopted Dog is: Labrador Retreiver Mix, Pitbull Mix, Chihuahua Mix
				Top Euthanized Dog: Pibtull, Chihuahua Mixx, Labrador Retriever Mix

				Cats:
				Top Intake Cat is:  Domestic Shorthair Mix, Domestic Shorthair, Domestic Medium Hair Mix
				Top Adopted Cat is: Domestic Shorthair Mix, Domestic Shorthair, Domestic Medium Hair Mix
				Top Euthanized Cat: Domestic Shorthair Mix, Domestic Shorthair, Domestic Medium HairMix

		•	Is there a color that is more common?  
			
				Dogs: 
					* Intakes
						Tricolor
						White/Liver
						Sable/White
					* Adopted
						Black/White = 4236
						Brown/White = 1880
						Tan/White = 1869
					* Euthanized
						Black/White - 166
						Brown/White - 113
						Tan/White 107
				Cats: 
					* Intakes
						Calico
						Cream Tabby
						Black/White
					* Adopted		
						Brown Tabby
						Black
						Black/White			
					* Euthanized
						Brown Tabby
						Black 
						Black/White 
						
		•	How does color affect adoption rates?  - Black/White dogs were the most popular to be adopted. 

		•	What is the most common name? 
				
				Cats
				--Luna = 124
				--Charlie = 121
				--Lucy = 86
				--Max = 84
				--Bella = 84
				--Oliver = 83
				--Lily = 82
				--Shadow = 79
				--Jack = 79
				--Daisy = 74
				
				Dogs
				--Max = 537
				--Bella = 474
				--Luna = 414
				--Rocky = 374
				--Daisy = 365
				--Charlie = 317
				--Coco = 307
				--Buddy = 305
				--Princess = 299
				--Lucy = 287
		•	How many are euthanized each year?  2014 had the highest euthanasia rates for both cats and dogs. 
			
			2013 = 277
			2014 = 1050
			2015 = 847
			2016 = 240
			2017 = 346
			2018 = 240
			2019 = 312
			2020 = 230
			2021 = 19

		•	How many died in care each year? 
		•	How many are adopted each year? 
		*   What is the average length of time in the shelter from intake to adoption/euthanasia?

	
*/

--What months are INTAKES the highest/lowest for all intakes?  

		--Highest: 
			--	May = 11780
			--	June = 11486
			--	October = 11201
		--Lowest
			--	February = 7843
			--	March = 8238
			--	January  - 8627

		--Top 3 intake month count
				With CTE AS
			(
				Select *, DATEPART(month, Date_Converted) AS Intake_Month
			From Intakes

			)

			Select Top 3
			Intake_Month, Count(*) AS Top_Month_Count
			from CTE
			Group by Intake_Month
			Order by Top_Month_Count desc;

			--Slowest 3 intake month count
			With CTE AS
			(
			Select *, DATEPART(month, Date_Converted) AS Intake_Month
			From Intakes

			)

			Select Top 3
			Intake_Month, Count(*) AS Lowest_Month_Count
			from CTE
			Group by Intake_Month
			Order by Lowest_Month_Count asc

--What months the Outcomes the highest/lowest for Adoption rates? 

		----Highest 
			--	July - 5575
			--	December - 5535
			--	August  - 5365

		----Lowest 
			--	April - 2954
			--	March - 3541
			--	May  - 3916

	With CTE AS
	(
	Select *, DATEPART(month, Date_Converted) AS Intake_Month
	From Outcomes
	)

	Select 
	Intake_Month, Count(*) AS Month_Count
	from CTE
	WHERE Outcome_Type like 'Adoption'
	Group By Intake_Month
	Order by Month_Count desc

-- What time of day are adoptions the highest and lowest? 
			
		----Highest 
			--	5pm = 11352
			--	6pm = 9161
			--  4pm = 7534
	

		----Lowest 
			--	3am = 4
			--	2am = 5
			--  4am = 8
			
	With CTE AS
	(
	Select *, DATEPART(HOUR, Time_Converted) AS Intake_Hour
	From Outcomes
	)

	Select
	Intake_Hour, Count(*) AS Hour_Count
	from CTE
	WHERE Outcome_Type like 'Adoption'
	Group By Intake_Hour
	Order by Hour_Count desc

-- Are there more cats or dogs in the shelter? Dogs.
		--Dogs = 70429  = 60% dogs
		--Cats = 46446  = 40% cats

	 -- Viewing Total Animal County
			Select COUNT(Animal_Type)
			from Intakes

	-- Cat and Dog by Counts and Percentage
		Select Animal_Type, 
		Count(Animal_Type) as Animal_Count,
		ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS Percentage_Outcome
		from Intakes    
		Group by Animal_Type
		Order by Percentage_Outcome desc	

	-- Alternative method to Cat and Dog Total 
		Select distinct Animal_Type, Count(Animal_Type) over (partition by Animal_Type) as Animal_Count
		from Intakes

-- What is the average age upon intake and outcome?  1 year old for both intake and outcome. 

		--Intake
			-- 18,498 at 1 year old
			-- 17,327 at 2 years old 
			-- 11,854 at 1 month old 

			-- 1 at 24 years old 
			-- 1 at 23 years
			-- 1 at 22 years

		--Ouctome

			-- 18824 at 1 year old 
			-- 17318 at 2 years old 
			-- 14970 at 2 months old 

			-- 1 at 24 years
			-- 1 at 24 years
			-- 5 at 22 years

	--Counts by Age Upon Intake
		Select Distinct Age_Upon_Intake, Count(Age_Upon_Intake) over (partition by Age_Upon_Intake) as Age_Count
		from Intakes
		Order by Age_Count desc

	--Counts by Age Upon Outcomes
		Select Distinct Age_Upon_Outcome, Count(Age_Upon_Outcome) over (partition by Age_Upon_Outcome) as Age_Count
		from Outcomes
		Order by Age_Count desc

--What is the most common Intake Reason? 

		--Strays are 73% of Intake Type 
		--Owner Surrenders are 21%
		--Public Assist is 6% 
		--Abondoned is less than 1%
		--Euthanisia Reuest is less than 1%

				-- Viewing total number of intake types  - 116,875
					Select COUNT(Intake_Type)
					from Intakes

				-- Viewing Count of Intake_Type  
					Select Distinct Intake_Type, 
					Count(Intake_Type) over (partition by Intake_type) as Intake_Count
					from Intakes
					Order by Intake_Count desc
		
				--Viewing Percentage of Intake_Count
		
					select Intake_Type, ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Percentage_Outcome
					from Intakes    
					group by Intake_Type
					Order by Percentage_Outcome desc

				--What makes up an Owner Surrender Intake?  

					--Normal conditions  88.3%
					--Injured 4.8%
					--Sick 3.1%
					--Nursing 2.9%
					--Aged .4%
					--Other .2%
					--Pregnant .1%
					--Medical  .1%
					--Feral  .1%
					--Behavior .000%
					
						With CTE AS
							(
							Select * 
							from Intakes
							Where Intake_Type = 'Owner Surrender'
							)
						Select Intake_Condition, ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Condition_Outcome
							from Intakes    
							group by Intake_Condition
							Order by Condition_Outcome desc


-- What is the most common Outcome Type?
	
	-- Viewing total number of outcomes  - 117,255
     Select COUNT(Outcome_Type)
     from Outcomes

	 -- Viewing Count of Intake_Type  
			--Adoption = 54609
			--Transfer = 35649
			--Return to Owner = 21428
			--Euthanasia = 3738
			--Died = 944
			--Rto-Adopt = 694
			--Disposal = 112
			--Missing = 64
			--Unknown = 15
			--Relocate = 2
	  Select Distinct Outcome_Type,
      Count(Outcome_Type) over (partition by Outcome_type) as Outcome_Count
      from Outcomes
      Order by Outcome_Count desc

	  --Percentage of Outcome Type
			--Adoption 46.6%
			--Transfer 30.4%
			--Return to Owner 18.3%
			--Euthanisia 3.2%
			--Died .8%
			--Rto-Adopt  .6%
			--Disposal .1%
			--Missing .1%
			--Unknown 0%
			--Relocate 0%

	  --Viewing Percetage of Outcome Type
	  Select Outcome_Type, 
		ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Percentage_Outcome
		from Outcomes    
		group by Outcome_Type
		Order by Percentage_Outcome desc

-- Viewing subtypes(reasons) those are euthanized? 
			--Suffering 67.1%
			--Aggressive 14.4%
			--Rabies Risk 4.8%
			--Beahvior 4.3%
			--At Vet 4.2%
			--Medical 3.8%
			--Court/Investigation .8%
			--Blank .7%
			
		 With CTE AS
           (
           Select *
           from Outcomes
           Where Outcome_Type = 'Euthanasia'
                )

			Select Outcome_Subtype, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS [Percentage_Euthanized]
			from CTE    
			group by Outcome_Subtype
			Order by Percentage_Euthanized desc

-- Is there a breed that is more common than others? 


		--Viewing top DOG breed in Intakes: Pit Bull Mix,Labrador Retreiver Mix,Chihuahua Shorthair Mix

			Select Top 10 Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Percentage
			from intakes
			Where Animal_Type = 'Dog'
			group by Breed
			Order by Breed_Percentage desc
	
		--Viewing top CAT breed in Intakes : Domestic Shorthair Mix, Domestic Shorthair,Domestic Medium Hair Mix

			Select Top 10 Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Percentage
			from intakes
			Where Animal_Type = 'Cat'
			group by Breed
			Order by Breed_Percentage desc

		--Viewing top DOG breed that is "adopted":  Labrador Retriever Mix, Pit Bull Mix, Chihuahua Shorthair Mix

			With CTE AS
				   (
				   Select *
				   from Outcomes
				   Where Outcome_Type = 'Adoption' and Animal_Type = 'Dog' 
						)

			Select Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Adopted
			from CTE    
			group by Breed
			Order by Breed_Adopted desc

	--Viewing top DOG breed that is "Euthanized"     Pitbull Mix, Chihuahua Shorthair Mix,Labrador Retriever Mix
		 
			With CTE AS
				   (
				   Select *
				   from Outcomes
				   Where Outcome_Type = 'Euthanasia' and Animal_Type = 'Dog'
						)

			Select Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Euthanized
			from CTE    
			group by Breed
			Order by Breed_Euthanized desc

	--Viewing top CAT breed that is "adopted"  Domestic Shorthair Mix, Domestic Shorthair, Domestic Medium Hair Mix
	 
			With CTE AS
				   (
				   Select *
				   from Outcomes
				   Where Outcome_Type = 'Adoption' and Animal_Type = 'CAT' 
						)

			Select Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Adopted
			from CTE    
			group by Breed
			Order by Breed_Adopted desc

	--Viewing top CAT breed that is "Euthanized"  Domestic Shorthair Mix, Domestic Shorthair, Domestic Medium HairMix
	 	 
			With CTE AS
				   (
				   Select *
				   from Outcomes
				   Where Outcome_Type = 'Euthanasia' and Animal_Type = 'CAT'
						)

			Select Breed, 
			ROUND(count(*) * 100.0 / sum(count(*)) over(),1) AS Breed_Euthanized
			from CTE    
			group by Breed
			Order by Breed_Euthanized desc

-- Is there a color that is more common?  
	--DOGS
		--Top 3 color intakes in Dog
		Select Top 3 Color
		From Intakes
		Where Animal_Type = 'Dog'

		--Top 3 color dogs that are adopted 
				Black/White - 4236
				Brown/White = 1880
				Tan/White = 1869

		--Top 3 color of adopted dogs
		Select Top 3 Color, Count(*) AS color_count
		From Outcomes
		Where Animal_Type = 'Dog' and Outcome_type = 'Adoption'
		Group By color
		Order by color_count desc

		--Top 3 color dogs that are Euthanized
			--Black/White - 166
			--Brown/White = 113
			--Tan/White = 107

		--Top 3 color of dogs that are Euthanized
		Select Color, Count(*) AS color_count
		From Outcomes
		Where Animal_Type = 'Dog' and Outcome_type = 'Euthanasia'
		Group By color
		Order by color_count desc

--CATS
		--Top 3 color intakes in cat
			--Calico
			--Cream Tabby
			--Black/White
		
		Select Top 3 Color
		From Intakes
		Where Animal_Type = 'Cat'

		--Top 3 color cats that are adopted 
			-- Brown Tabby 
			-- Black
			-- Black/White

		Select Top 3 Color, Count(*) AS color_count
		From Outcomes
		Where Animal_Type = 'Cat' and Outcome_type = 'Adoption'
		Group By color
		Order by color_count desc

		--Top 3 color dogs that are Euthanized
			--Brown Tabby 
			--Black
			--Black/White

		Select Top 3 Color, Count(*) AS color_count
		From Outcomes
		Where Animal_Type = 'Cat' and Outcome_type = 'Euthanasia'
		Group By color
		Order by color_count desc

-- What is the most common Cat Name

		--Top 10 Cat Names
			--Luna = 124
			--Charlie = 121
			--Lucy = 86
			--Max = 84
			--Bella = 84
			--Oliver = 83
			--Lily = 82
			--Shadow = 79
			--Jack = 79
			--Daisy = 74
		
			Select Top 10 Name, Count(*) as Name_Count
			From Outcomes
			Where Animal_Type = 'Cat' and Name <> 'Unknown'
			Group By Name
			Order by Name_Count desc

-- What is the most common Dog Name
		--Top 10 Dog Names
			--Max = 537
			--Bella = 474
			--Luna = 414
			--Rocky = 374
			--Daisy = 365
			--Charlie = 317
			--Coco = 307
			--Buddy = 305
			--Princess = 299
			--Lucy = 287
			
			Select Top 10 Name, Count(*) as Name_Count
			From Outcomes
			Where Animal_Type = 'Dog' and Name <> 'Unknown'
			Group By Name
			Order by Name_Count desc

--	How many are euthanized each year?
	
	--Total By Count
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia'
		Group by datepart(Year, Date_Converted)
		Order by Year_Count desc

	--Total Chronological
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia'
		Group by datepart(Year, Date_Converted)
		Order by Year
	
	--Dogs By Count
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia' and Animal_Type = 'Dog'
		Group by datepart(Year, Date_Converted)
		Order by Year_Count desc
	
	--Dogs by Chronological
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia' and Animal_Type = 'Dog'
		Group by datepart(Year, Date_Converted)
		Order by Year

	--Cats by Chronological
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia' and Animal_Type = 'Cat'
		Group by datepart(Year, Date_Converted)
		Order by Year

		--Cats by Count
		Select datepart(year, Date_Converted) as Year, count(*) as Year_Count
		from Outcomes
		Where Outcome_Type = 'Euthanasia' and Animal_Type = 'Cat'
		Group by datepart(Year, Date_Converted)
		Order by Year_Count desc

--How many died in care? 
	
		--Count of the reason where Outcome type is Died
		Select distinct outcome_subtype, COUNT(*) as count_subtype
		from outcomes
		Where outcome_type = 'died'
		Group by Outcome_Subtype
		Order by count_subtype desc

		-- Number that died each year
		Select datepart(year, date_converted) as year, Count(Outcome_Type) as subcount
		from outcomes
		Where Outcome_Type = 'Died'
		Group by datepart(year, date_converted)
		Order by year	

		--Count of those that died each year and the reason why
		Select datepart(year, date_converted) as year, COUNT (outcome_subtype) AS sub_count
		, Outcome_Subtype
		from outcomes
		Where Outcome_Type = 'Died'
		Group by outcome_subtype, datepart(year, date_converted)
		Order by datepart(year, date_converted), outcome_subtype
		
		--Count of the reason where outcome type is Died for dogs
		Select distinct outcome_subtype, COUNT(*) as count_subtype, ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS dog_percent_subtype
		from outcomes
		Where outcome_type = 'died' and animal_type = 'Dog'
		Group by Outcome_Subtype
		Order by count_subtype desc

		--Count of the reason where outcome type is Died for dogs
		Select distinct outcome_subtype, COUNT(*) as count_subtype, ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS cat_percent_subtype
		from outcomes
		Where outcome_type = 'died' and animal_type = 'Cat'
		Group by Outcome_Subtype
		Order by count_subtype desc

--How many are adopted each year? 

		--Adding a new column to table for Year
		ALTER TABLE OUTCOMES
		ADD YEAR SMALLINT;

		--Adding Year values to Year column
		UPDATE OUTCOMES
		SET YEAR = DATEPART(YEAR, DATE_CONVERTED)
		WHERE YEAR is NULL

		-- Count and total Percentage of Cat Adoptions by Subtype
		Select outcome_subtype, COUNT(*) as cat_adoptions, ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS cat_percent_subtype
		from outcomes
		Where outcome_type = 'Adoption' and animal_type = 'Cat'
		Group by Outcome_Subtype
		Order by cat_adoptions desc

		-- Count and total Percentage of Dog Adoptions by Subtype
		Select distinct outcome_subtype, COUNT(*) as dog_adoptions, ROUND(count(*) * 100.0 / sum(count(*)) over(),0) AS dog_percent_subtype
		from outcomes
		Where outcome_type = 'Adoption' and animal_type = 'Dog'
		Group by outcome_subtype
		Order by dog_adoptions desc

		-- Cat adoptions by year without Subtype
		Select  Year, COUNT (*) AS Cat_Adoptions
		from outcomes
		Where Outcome_Type = 'Adoption' and animal_type = 'Cat'
		Group by Outcome_type, Year
		Order by Year, outcome_type

		--Dog adoptions by year without Subtype
		Select datepart(year, date_converted) as year,COUNT (*) AS dog_adoptions 
		from outcomes
		Where Outcome_Type = 'Adoption' and animal_type = 'Dog'
		Group by Outcome_type, datepart(year, date_converted)
		Order by datepart(year, date_converted)

		-- Dog and Cat Adoption adopted by year
		Select Animal_Type, COUNT(*) as Animal_Count, datepart(year, date_converted) as Year
		from Outcomes
		Where Outcome_Type = 'Adoption'
		Group by Animal_Type, datepart(year, date_converted)
		Order by  datepart(year, date_converted) asc

		---Pivot Table to show cat and dog adoptions by year
		SELECT * FROM (
			Select
				Year,
				Animal_Type, 
				COUNT(*) As Adoption_Count
			FROM Outcomes
			WHERE Outcome_Type ='Adoption'
			Group by Animal_Type, Year
		) t 
		PIVOT(
			SUM (Adoption_Count)
			FOR [Year]
			IN (
				[2013],
				[2014],
				[2015],
				[2016],
				[2017],
				[2018],
				[2019],
				[2020],
				[2021])
		) AS pivot_table;

--What is the average time from intake to outcome?

	--Average days until Euthanasia of dog
	select AVG(DATEDIFF(day,a.DateTime, b.DateTime)) AS DateDiff
	from intakes a 
	inner join outcomes b
	on a.animal_id = b.animal_id
	Where outcome_type = 'Euthanasia' and b.Animal_Type = 'Dog'

	--Average days until Adoption of cat
	select AVG(DATEDIFF(day,a.DateTime, b.DateTime)) AS DateDiff
	from intakes a 
	inner join outcomes b
	on a.animal_id = b.animal_id
	Where outcome_type = 'Adoption' and b.Animal_Type = 'Cat'

---- Merging by Union without duplicates

	SELECT Animal_ID, Name, datetime
	FROM Intakes a
	UNION 
	SELECT Animal_ID, Name, datetime
	FROM Outcomes b
	Order by Animal_ID, datetime

	--Joining and viewing datediff in months only.
	select a.animal_id, a.datetime, b.animal_id, b.datetime, DATEDIFF(month,a.DateTime, b.DateTime) AS DateDiff
	from intakes a 
	inner join outcomes b
	on a.animal_id = b.animal_id
	Order by DateDiff desc

--- Correct Query for animals intake to outcome by days and various other categories
Select 
	i.Animal_ID,
	o.Animal_ID, 
	i.DateTime, 
	o.DateTime, 
		case when i.DateTime > o.DateTime THEN 
		DATEDIFF(hour,o.DateTime,i.datetime)
		ELSE 
		DATEDIFF(hour,i.DateTime,o.datetime)
		END AS [Datediff_hours],
	i.Intake_Type,
	i.intake_condition, 
	o.Outcome_Type, 
	o.Outcome_Subtype,
	o.Age_upon_Outcome,
	o.year
from Intakes i 
left join Outcomes o on o.Animal_ID = i.Animal_ID
where o.Animal_ID IS NOT NULL and o.Outcome_type = 'Euthanasia' and i.intake_condition = 'Normal'
order by datediff_hours

select * from intakes where Animal_ID = 'A695280'
Select * from outcomes where Animal_ID = 'A695280'

/*	
--DIGGING DEEPER
	4 week old chihuahua was euthanized after 1 hour, brought in under normal conditions. 
	4 month old pitbull mix euthanized after 7 hours, brought in under normal conditions. 
	wHY ARE ANIMALS BEING EUTHANIZED SO QUICKLY IF THEY ARE BROUGHT IN UNDER NORMAL INTAKE CONDITIONS??
*/

SELECT * FROM 
(
		Select
			Year,
			Animal_Type, 
			COUNT(*) As Adoption_Count
		FROM Outcomes
		WHERE Outcome_Type ='Euthanasia'
		Group by Animal_Type, Year
	) t 
	PIVOT(
		SUM (Adoption_Count)
		FOR [Year]
		IN (
		[2013],
		[2014],
		[2015],
		[2016],
		[2017],
		[2018],
		[2019],
		[2020],
		[2021])
) AS pivot_table;






