Create database PMSS;
Use PMSS;

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    DateOfBirth DATE,
    DepartmentID INT,
    CONSTRAINT FK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Create Salaries table
CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    Salary DECIMAL(10,2),
    CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Populate Departments table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
(1, 'Finance'),
(2, 'Human Resources'),
(3, 'IT'),
(4, 'Marketing');

-- Populate Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Gender, DateOfBirth, DepartmentID) VALUES
(1, 'Muhammad', 'Ali', 'M', '1990-05-01', 1),
(2, 'Fatima', 'Khan', 'F', '1992-08-15', 2),
(3, 'Ahmed', 'Hussain', 'M', '1985-12-10', 3),
(4, 'Aisha', 'Ahmed', 'F', '1988-04-20', 4);

-- Populate Salaries table
INSERT INTO Salaries (SalaryID, EmployeeID, Salary) VALUES
(1, 1, 50000),
(2, 2, 45000),
(3, 3, 60000),
(4, 4, 55000);

-- Queries
-- Query 1: List all employees' names and their salaries.
SELECT FirstName, LastName, Salary
FROM Employees
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID;

-- Query 2: Calculate the average salary in the company.
SELECT AVG(Salary) AS AverageSalary
FROM Salaries;

-- Query 3: List employees in the Finance department.
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = 1;

-- Query 4: List employees who are earning more than $50,000.
SELECT FirstName, LastName, Salary
FROM Employees
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID
WHERE Salary > 50000;

-- Query 5: Count the number of male employees.
SELECT COUNT(*) AS MaleEmployeesCount
FROM Employees
WHERE Gender = 'M';

-- Query 6: List employees' full names concatenated.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- Query 7: Update an employee's salary.
UPDATE Salaries
SET Salary = 60000
WHERE EmployeeID = 2;

-- Query 8: Delete an employee record.
DELETE FROM Employees
WHERE EmployeeID = 4;

-- Query 9: Find the highest salary in the company.
SELECT MAX(Salary) AS HighestSalary
FROM Salaries;

-- Query 10: List employees with their departments.
SELECT FirstName, LastName, DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- Query 11: Create a view to display employee names and their salaries.
CREATE VIEW EmployeeSalaries AS
SELECT FirstName, LastName, Salary
FROM Employees
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID;

-- Query 12: Use a user-defined function to calculate the bonus based on salary.
CREATE FUNCTION CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Bonus DECIMAL(10,2);
    SET @Bonus = @Salary * 0.1; -- Assuming 10% bonus
    RETURN @Bonus;
END;

-- Query 13: Call the user-defined function to calculate bonus for a specific employee.
SELECT FirstName, LastName, Salary, dbo.CalculateBonus(Salary) AS Bonus
FROM Employees
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID
WHERE EmployeeID = 1;

-- Query 14: Display the total salary expense for each department.
SELECT DepartmentName, SUM(Salary) AS TotalSalaryExpense
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID
GROUP BY DepartmentName;

-- Query 15: Create a stored procedure to update an employee's salary.
CREATE PROCEDURE UpdateSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Salaries
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
