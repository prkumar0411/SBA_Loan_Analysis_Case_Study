select *
from [Portfolio_DB].[dbo].[SBA_NAICS_Sec_Code_Desc1]
order by 2 asc


insert into [dbo].[SBA_NAICS_Sec_Code_Desc1]
values
	('Sector 31 – 33 – Manufacturing',32,'Manufacturing'),
	('Sector 31 – 33 – Manufacturing',33,'Manufacturing'),
	('Sector 44 - 45 – Retail Trade',45,'Retail Trade'),
	('Sector 48 - 49 – Transportation and Warehousing',49,'Transportation and Warehousing')


update [dbo].[SBA_NAICS_Sec_Code_Desc1]
set Sector = 'Manufacturing'
where LookupCodes=31






use Portfolio_DB

SELECT DISTINCT *
INTO duplicate_table
FROM SBA_NAICS_Sec_Code_Desc1
GROUP BY LookupCodes
HAVING COUNT(LookupCodes) > 1

DELETE [SBA_NAICS_Sec_Code_Desc1]
WHERE LookupCodes
IN (SELECT LookupCodes
FROM duplicate_table)

INSERT [SBA_NAICS_Sec_Code_Desc1]
SELECT *
FROM duplicate_table

DROP TABLE duplicate_table