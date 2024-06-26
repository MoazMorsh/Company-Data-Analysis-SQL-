USE [company]
GO
/****** Object:  StoredProcedure [dbo].[proc_company]    Script Date: 4/29/2024 4:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROC [dbo].[proc_company]
-- =============================================
-- Author:		
-- Create date: YYYYMMDD
-- Description:	RAW -> WRK
-- =============================================

AS
BEGIN

/* Retrieve the first name and last name of all employees.*/

select first_name, last_name from employees;

/* Find the department numbers and names.*/

select * from [Departments ];

/* Get the total number of employees.*/

select count(*) as Total_Employees from employees;

/* Find the average salary of all employees.*/

select avg(salary) as Avg_Salary from salaries;

/* Retrieve the birth date and hire date of employee with emp_no 10003.*/

select birth_date , hire_date 
from employees 
where emp_no = 10003;

/* Find the titles of all employees.*/

select emp_no , title from Employee_Titles;

/* Get the total number of departments.*/

select distinct count(*) as Total_Departments from [Departments ];

/* Retrieve the department number and name where employee with emp_no 10004 works.*/

select e.emp_no, d.dep_no, d.dep_name
from [Departments ] d
join Dept_emp e
on d.dep_no = e.dept_no
where e.emp_no = 10004; 

/* Find the gender of employee with emp_no 10007.*/

select emp_no, gender 
from employees 
where emp_no = 10007;

/* Get the highest salary among all employees.*/

select top 2 emp_no, salary 
from salaries
order by salary desc;

/* Retrieve the names of all managers along with their department names*/

select e.first_name, d.dep_name, e.emp_no 
from employees e
join Dept_manager m
on e.emp_no = m.emp_no
join [Departments ]d
on m.dept_no = d.dep_no

/* Find the department with the highest number of employees.*/

select d.dep_name, count(m.dept_no) as No_of_Emp
from Dept_manager m
join [Departments ]d
on m.dept_no = d.dep_no
group by dep_name
order by  count(m.dept_no) desc;

/* Retrieve the employee number, first name, last name, and salary of employees earning more than $60,000.*/

select e.emp_no , e.first_name, e.last_name, s.salary
from employees e
join salaries s
on e.emp_no = s.emp_no
where salary > 60000;

/* Get the average salary for each department.*/  

select d.dep_name, e.dept_no, avg(s.salary) as Avg_salary
from Dept_manager m
join Dept_emp e
on m.emp_no = e.emp_no
join [Departments ]d
on e.dept_no = d.dep_no
join Salaries s
on m.emp_no = s.emp_no
group by d.dep_name, s.salary, e.dept_no

/* Retrieve the employee number, first name, last name, and title of all employees who are currently managers.*/

select e.emp_no, e.first_name, e.last_name, t.title
from employees e
join Employee_Titles t
on e.emp_no = t.emp_no
where title like '%manager%'

/* Find the total number of employees in each department.*/

select count(emp_no) as no_of_emp, dept_no 
from Dept_emp 
group by dept_no

/* Retrieve the employee number, first name, last name, and title of all employees hired in 2005.*/

select e.emp_no, e.first_name, e.last_name, t.title
from employees e
join employee_titles t
on e.emp_no = t.emp_no
where year(hire_date) = 2005


/* Retrieve the employee number, first name, last name, and salary of employees hired before the year 2005.*/

select e.emp_no, e.first_name, e.last_name, s.salary
from employees e
join salaries s
on e.emp_no = s.emp_no
where year(hire_date) < 2005

/*Get the department number, name, and total number of employees for departments with a female manager*/

select d.dep_no, d.dep_name ,em.gender, count(e.emp_no) No_of_emp
from dept_emp e
join Employee_Titles t
on e.emp_no = t.emp_no
join [Departments ] d
on e.dept_no = d.dep_no
join employees em
on e.emp_no = em.emp_no
where gender = 'f' 
group by d.dep_no , d.dep_name, em.gender



END
/*

 select * from [dbo].[TableName_YYYYMMDD]
*/