-- create database
create database if not exists company_db;

-- Switch to the database
use company_db;

-- create department table
create table if not exists departmets(
dept_id int primary key,
dept_name varchar(50)
);

-- create table employees
create table if not exists emp(
emp_id int primary key,
emp_name varchar(50),
gender varchar(10),
age int,
salary int,
dept_id int,
city varchar(50),
hire_date date,
foreign key (dept_id) references departments (dept_id)
);

-- create table orders
create table if not exists orders(
order_id int primary key,
customer_name varchar(50),
amount decimal(10,2),
order_date date
);

-- create table project
create table if not exists project(
project_id int primary key,
project_name varchar(50),
dept_id int,
budget int,
foreign key (dept_id) references departments (dept_id)
);

/*
 Import Data into Tables
  step 1: click right click on database
  step 2: click table data import wizard
  step 3: set table file location and click next
  step 4: select "use existing table" and select table name for each table and click next
  step 5: check column and click next
  step 6: click next
*/

-- show table data
SELECT * FROM departments;
SELECT * FROM emp;
SELECT * FROM Orders;
SELECT * FROM projects;

-- basic question :

-- 1) show all employees
SELECT * FROM emp;

-- 2) show employees name and salary
SELECT emp_name,salary FROM emp;

-- 3) find employees from ahmedabad
SELECT * FROM emp
WHERE city="Ahmedabad";

-- 4) find employees with salary > 60000
SELECT * FROM  emp
WHERE salary > 60000;

-- 5) find female employees
SELECT * FROM emp
WHERE gender="Female";

-- 6) find employees between age 25 and 30
SELECT * FROM emp
WHERE age BETWEEN 25 AND 30;

-- 7) sort employees by salary descending
SELECT * FROM emp
ORDER BY salary DESC;

-- 8) find top 5 highest salary
SELECT * FROM emp
ORdER BY salary DESC LIMIT 5;

-- 9) count total employees 
SELECT count(emp_id) as "total_employees" FROM emp;

-- 10) find minmum and maximum salary
SELECT min(salary) as "min_salary",max(salary) as "max_salary"
FROM emp;

-- WHERE + LIKE + IN

-- 11) find employees whose name start with 'A'
SELECT * FROM emp
WHERE emp_name LIKE 'A%';

-- 12) find employees whose city ends with 'A'
SELECT * FROM emp
WHERE city LIKE '%a';

-- 13) find employees in ahmedabad,surat and pune
SELECT * FROM emp
WHERE city  IN ("Ahmedabad","Surat","Pune");

-- 14) find employees not in IT department
SELECT e.emp_name,d.dept_name
FROM emp e
INNER JOIN departments d
ON e.dept_id=d.dept_id
WHERE d.dept_name NOT LIKE '%IT%';

-- 15) find employees with salary between 50000 and 70000
SELECT * FROM emp
WHERE salary BETWEEN 50000 AND 70000;

-- Aggregate function :

-- 16) find average salary
SELECT avg(salary) as "average_salary" FROM emp;

-- 17) find total salary department wise
SELECT d.dept_name,sum(e.salary) as "total_salary"
FROM departments d
INNER JOIN emp e
ON d.dept_id=e.dept_id
GROUP BY d.dept_name;

-- 18) count employees in each city
SELECT city,count(emp_id) as "total_employee"
FROM emp GROUP BY city;

-- 19) find average salary city wise
SELECT city,avg(salary) as `average salary`
FROM emp GROUP BY city;

-- 20) find highest salary in each department
SELECT d.dept_name,max(e.salary) as `highest salary`
FROM departments d
INNER JOIN emp e
ON d.dept_id=e.dept_id
GROUP BY d.dept_name;
