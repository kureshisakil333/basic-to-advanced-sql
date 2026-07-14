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

-- group by + having

-- 21) find department with more then 3 employees
SELECT d.dept_name,count(e.emp_id) AS total_emp
FROM departments d
JOIN emp e
ON d.dept_id=e.dept_id
GROUP BY d.dept_name HAVING total_emp > 3;

-- 22) find cities where average salary > 60000
SELECT city,AVG(salary) AS avg_salary
FROM emp GROUP BY city HAVING avg_salary > 60000;

-- 23) find department with total salary > 200000
SELECT d.dept_name,sum(e.salary) AS total_salary
FROM departments d
JOIN emp e
ON d.dept_id=e.dept_id
GROUP BY d.dept_name HAVING total_salary > 200000;

-- 24) find cities having more than 2 employees
SELECT city,count(emp_id) AS total_emp
FROM emp GROUP BY city HAVING total_emp > 2;

-- 25) find average salary by gender
SELECT gender,avg(salary) AS avg_salary
FROM emp GROUP BY gender;

-- join practice question

-- 26) show employees name with department name.
SELECT e.emp_name,d.dept_name
FROM emp e
JOIN departments d
ON e.dept_id=d.dept_id;

-- 27) show all employees and their project name
SELECT e.emp_name,p.project_name
FROM emp e
JOIN projects p
ON e.dept_id=p.dept_id;

-- 28) find employees working in IT
SELECT e.emp_name,d.dept_name
FROM emp e
JOIN departments d
ON e.dept_id=d.dept_id
WHERE d.dept_name="IT";

-- 29) show project budgets with department name
SELECT d.dept_name,p.project_name,p.budget AS project_budget
FROM departments d
JOIN projects p
ON d.dept_id=p.dept_id;

-- 30) find employees whose department budget > 300000
SELECT e.emp_name,d.dept_name,p.budget AS project_budgets
FROM emp e
JOIN departments d
ON e.dept_id=d.dept_id
JOIN projects p
ON e.dept_id=p.dept_id
WHERE p.budget > 300000;

-- subqueries practice question

-- 31) find second highest salary
-- sub query  (SELECT max(salary) FROM emp)
SELECT emp_name,max(salary) as max_salary
FROM emp WHERE salary < (SELECT max(salary) FROM emp)
GROUP BY emp_name LIMIT 1;
select * from emp order by salary desc;

-- 32) find employees earning above average salary
-- sub query (select avg(salary) from emp);
SELECT emp_name,salary FROM emp
WHERE salary > (SELECT avg(salary) FROM emp);

-- 33) find highest paid employee from each department
-- sub query((SELECT MAX(salary) FROM emp WHERE dept_id=e.dept_id))
SELECT d.dept_name,e.emp_id,e.emp_name,e.salary
FROM emp e
JOIN departments d
ON d.dept_id=e.dept_id
WHERE e.salary=(SELECT MAX(salary) FROM emp WHERE dept_id=e.dept_id);

-- 34) find department with no employee
SELECT d.dept_name,count(e.emp_id) as total_emp
FROM emp e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name HAVING total_emp < 0;

-- 35) find employees hired before the oldest IT employee
SELECT e.emp_name, e.hire_date
FROM emp e
WHERE e.hire_date < (
    SELECT MIN(e2.hire_date)
    FROM emp e2
    JOIN departments d
        ON e2.dept_id = d.dept_id
    WHERE d.dept_name = 'IT'
);


