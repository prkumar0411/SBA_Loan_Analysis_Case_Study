create view ppp_main as

SELECT 
	d.Sector,  
	year(DateApproved) Year_Approved,
	month(DateApproved) month_Approved,
	OriginatingLender, 	
	BorrowerState,
	Race,
	Gender,
	Ethnicity,
	count(LoanNumber) as No_Of_Approved, 
	sum(CurrentApprovalAmount) Curr_Approved_Amt, 
	AVG(CurrentApprovalAmount) Curr_Average_Loan_Size,
	SUM(ForgivenessAmount) Amt_Forgiven,
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size

FROM [Portfolio_DB].[dbo].[SBA_Public_Data] p
inner join [Portfolio_DB].[dbo].[SBA_NAICS_Sec_Code_Desc1] d
on left(p.NAICSCode,2)=d.LookupCodes
group by 
	d.Sector,  
	year(DateApproved),
	month(DateApproved),
	OriginatingLender, 	
	BorrowerState,
	Race,
	Gender,
	Ethnicity