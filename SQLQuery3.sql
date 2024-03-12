---What is the summary of all approved PPP loans?
Select
	year(DateApproved) as Year_Approved,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2020
group by year(DateApproved)

union

Select
	year(DateApproved) as Year_Approved,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2021
group by year(DateApproved)


---Summary of 2021 PPP Approved Loans per Originating Lender, loan count, total amount and average

Select
	year(DateApproved) as Year_Approved,
	count(OriginatingLender) OriginatingLender,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2020
group by year(DateApproved)

union

Select
	year(DateApproved) as Year_Approved,
	count(OriginatingLender) OriginatingLender,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2021
group by year(DateApproved)

--Top 15 Originating Lenders for 2021 PPP Loans
--Data is ordered by Approved_Amt

Select TOP 15
	OriginatingLender,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Approved_Amt, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2021
group by OriginatingLender
order by 3 DESC		---(3 means order by is executed on column 3 which is Approved_Amt.)

---Top 20 Industries that received the PPP Loans in 2021&2020

;with CTE as(
Select TOP 20
	d.Sector,
	count(LoanNumber) as No_Of_Approved, 
	sum(InitialApprovalAmount) Sum_Of_Approved, 
	AVG(InitialApprovalAmount) Average_Loan_Size
FROM [Portfolio_DB].[dbo].[SBA_Public_Data] p
inner join [Portfolio_DB].[dbo].[SBA_NAICS_Sec_Code_Desc1] d
on left(p.NAICSCode,2)=d.LookupCodes
where year(DateApproved)=2020
group by d.Sector
---order by 3 DESC
)
select Sector,No_Of_Approved,Sum_Of_Approved,Average_Loan_Size,
Sum_Of_Approved/sum(Sum_Of_Approved) over()*100 as Percent_By_Amt
from CTE
Order by 3 DESC


---How much of the PPP Loans of 2021 have been fully forgiven

Select 
	count(LoanNumber) as No_Of_Approved, 
	sum(CurrentApprovalAmount) Curr_Approved_Amt, 
	AVG(CurrentApprovalAmount) Curr_Average_Loan_Size,
	SUM(ForgivenessAmount) Amt_Forgiven,
	SUM(ForgivenessAmount)/sum(CurrentApprovalAmount) Percent_Forgiven
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
where year(DateApproved)=2021


--In which month was the highest amount given out by the SBA to borrowers

select Year(DateApproved) Year_Approved, 
	Month(DateApproved)Month_Approved, 
	ProcessingMethod, 
	sum(CurrentApprovalAmount) Net_Dollars
FROM [Portfolio_DB].[dbo].[SBA_Public_Data]
group by Year(DateApproved),  Month(DateApproved), ProcessingMethod
order by 4 desc

