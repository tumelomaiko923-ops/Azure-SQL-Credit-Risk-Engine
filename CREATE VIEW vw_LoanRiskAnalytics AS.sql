CREATE VIEW vw_LoanRiskAnalytics AS
SELECT LoanID,CreditScore,EmploymentType,Age,income,LoanAmount,
ROUND (CAST(Income AS FLOAT)/ NULLIF (LoanAmount,0),2) AS IncomeToLoanRation,
CASE 
WHEN(CreditScore>=700) THEN 'LowerRisk'
WHEN(CreditScore BETWEEN 600 AND 699) THEN 'MediumRisk'
ELSE 'HigherRisk'
END AS LoanEligibity,
CASE
WHEN CreditScore < 600 or EmploymentType = 'unemployed' or Age >= 59 THEN 0
WHEN EmploymentType = 'salaried' AND income >= 30000 AND income < 40000 THEN  10000
WHEN EmploymentType = 'salaried' AND income >= 40000 AND income < 50000 THEN  20000
WHEN EmploymentType = 'salaried' AND income >= 50000 AND income < 60000 THEN  30000
WHEN EmploymentType = 'salaried' AND income >= 60000 AND income < 70000 THEN  40000
WHEN EmploymentType = 'salaried' AND income >= 70000  THEN  100000
WHEN EmploymentType = 'Self-Employed' AND income >= 30000 AND income < 40000 THEN  5000
WHEN EmploymentType = 'Self-Employed' AND income >= 40000 AND income < 50000 THEN  10000
WHEN EmploymentType = 'Self-Employed' AND income >= 50000 AND income < 60000 THEN  17000
WHEN EmploymentType = 'Self-Employed' AND income >= 60000 AND income < 70000 THEN  35000
WHEN EmploymentType = 'Self-Employed' AND income >= 70000 THEN  60000
ELSE 0 
END AS 'EligibleLoanAmount'
FROM loan_risk_prediction 


