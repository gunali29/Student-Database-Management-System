CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(50)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Marks (
    MarkID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT,
    MarksObtained INT,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

INSERT INTO Students (StudentName, Age) VALUES
('Alice', 20),
('Bob', 21),
('Charlie', 19);

INSERT INTO Courses (CourseName) VALUES
('Math'),
('Science'),
('English');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1), -- Alice in Math
(1, 2), -- Alice in Science
(2, 1), -- Bob in Math
(2, 3), -- Bob in English
(3, 2); -- Charlie in Science

INSERT INTO Marks (EnrollmentID, MarksObtained) VALUES
(1, 85), -- Alice Math
(2, 90), -- Alice Science
(3, 78), -- Bob Math
(4, 65), -- Bob English
(5, 40); -- Charlie Science

SELECT s.StudentName, c.CourseName, m.MarksObtained
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Marks m ON e.EnrollmentID = m.EnrollmentID;

SELECT c.CourseName, s.StudentName, MAX(m.MarksObtained) AS TopMark
FROM Marks m
JOIN Enrollments e ON m.EnrollmentID = e.EnrollmentID
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

SELECT c.CourseName, AVG(m.MarksObtained) AS AverageMark
FROM Marks m
JOIN Enrollments e ON m.EnrollmentID = e.EnrollmentID
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

SELECT s.StudentName, c.CourseName, m.MarksObtained
FROM Marks m
JOIN Enrollments e ON m.EnrollmentID = e.EnrollmentID
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE m.MarksObtained < 50;
