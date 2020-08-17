CREATE TABLE Departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    PRIMARY KEY (dept_no)
);

SELECT * FROM Departments;

CREATE TABLE Dept_Emp (
	emp_no INTEGER NOT NULL,
    dept_no VARCHAR NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES Employees (emp_no), 
    FOREIGN KEY(dept_no) REFERENCES Departments (dept_no) 
);

SELECT * FROM Dept_Emp;

CREATE TABLE Dept_Manager (
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES Departments (dept_no), 
    FOREIGN KEY(emp_no) REFERENCES Employees (emp_no) 
    
);

SELECT * FROM Dept_Manager;

CREATE TABLE Employees (
    emp_no INTEGER   NOT NULL,
    emp_title_id VARCHAR  NOT NULL,
    birth_date VARCHAR  NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY(emp_title_id) REFERENCES Titles (title_id)
);

SELECT * FROM Employees;

CREATE TABLE Salaries (
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL, 
    FOREIGN KEY(emp_no) REFERENCES Employees (emp_no) 
    
);

SELECT * FROM Salaries;

CREATE TABLE Titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    PRIMARY KEY (title_id)
);

SELECT * FROM Titles;

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Salaries
INNER JOIN Employees ON
Employees.emp_no=Salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM Employees
WHERE RIGHT(hire_date, 4) = '1986';


--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

SELECT Dept_Manager.dept_no, Departments.dept_name, Dept_Manager.emp_no, Employees.last_name, Employees.first_name
FROM Dept_Manager
INNER JOIN Departments ON
Departments.dept_no=Dept_Manager.dept_no
INNER JOIN Employees ON
Employees.emp_no=Dept_Manager.emp_no;


--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT Dept_Emp.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name 
FROM Dept_Emp
INNER JOIN Employees ON
Employees.emp_no=Dept_Emp.emp_no
INNER JOIN Departments ON
Departments.dept_no=Dept_Emp.dept_no; 


--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND LEFT(last_name, 1) = 'B';


--6.List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.

SELECT Dept_Emp.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name 
FROM Dept_Emp
INNER JOIN Employees ON
Employees.emp_no=Dept_Emp.emp_no
INNER JOIN Departments ON
Departments.dept_no=Dept_Emp.dept_no
WHERE Departments.dept_name = 'Sales';

--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT Dept_Emp.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name 
FROM Dept_Emp
INNER JOIN Employees ON
Employees.emp_no=Dept_Emp.emp_no
INNER JOIN Departments ON
Departments.dept_no=Dept_Emp.dept_no
WHERE Departments.dept_name IN ('Sales', 'Development');

--8.In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
