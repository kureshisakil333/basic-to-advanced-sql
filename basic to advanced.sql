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

