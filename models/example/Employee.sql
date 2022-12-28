-- rename the office to office id and genrate total working days of employee 

with emp as (
select 
EmployeeID,
Extension,
EmployeeName,
EmployeeGender,
HIRE_DATE,
datediff(day,HIRE_DATE,CURRENT_DATE()) as "WORKING DAYS",
Office as OFFICE_ID,
Supervisor,
JobTitle,
AnnualSalary,
Sales_Target
from FIVETRAN_DATABASE.dbt_DBO.EMPLOYEES_
where _FIVETRAN_DELETED= 'FALSE' 
)

select * from emp
