select *
into SBA_NAICS_Sec_Code_Desc1
from (

	SELECT [NAICS_Industry_Description],
		iif([NAICS_Industry_Description] like '"%', 
			SUBSTRING([NAICS_Industry_Description],9,2),
			SUBSTRING([NAICS_Industry_Description],8,2)) LookupCodes, /*With if stat, seperation of sec no as lookup code is done.*/
		SUBSTRING([NAICS_Industry_Description],CHARINDEX('–',[NAICS_Industry_Description])+2,LEN([NAICS_Industry_Description])) as Sector
	FROM [Portfolio_DB].[dbo].[SBA_Industry_Standards]
	where [NAICS_Codes]='' /*The NAICS code for sectors is blank so this line will give all the sectors.*/
 )main
where ISNUMERIC(LookupCodes)=1

	 
