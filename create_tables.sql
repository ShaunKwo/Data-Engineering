USE SPAI2317933;

DROP TABLE IF EXISTS Customers, Employees, ModelTypes, Datasets, Orders, OrderModelTypes, ModelAssignments, Models;

CREATE TABLE Customers
(
    Customer_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Contact INT NOT NULL,
    Company_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees
(
    Employee_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Contact INT NOT NULL,
    Gender CHAR(1) NOT NULL
);

CREATE TABLE ModelTypes
(
    ModelCode VARCHAR(10) NOT NULL PRIMARY KEY,
    ModelType VARCHAR(100) NOT NULL
);

CREATE TABLE Datasets
(
    Dataset_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    Dataset_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders
(
    Order_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    Customer_ID VARCHAR(10) NOT NULL,
    Order_Date DATE NOT NULL,
    Completion_Date DATE NOT NULL,
    Required_Accuracy DECIMAL(5,1) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Models
(
    Model_ID VARCHAR(10) NOT NULL PRIMARY KEY,
    ModelCode VARCHAR(10) NOT NULL,
    Training_Date DATE NOT NULL,
    Accuracy DECIMAL(5,1) NOT NULL,
    Parent_Model_ID VARCHAR(10) NULL,
    Dataset_ID VARCHAR(10) NOT NULL,
    FOREIGN KEY (ModelCode) REFERENCES ModelTypes(ModelCode),
    FOREIGN KEY (Dataset_ID) REFERENCES Datasets(Dataset_ID),
    FOREIGN KEY (Parent_Model_ID) REFERENCES Models(Model_ID) -- Self-referencing foreign key
);


CREATE TABLE OrderModelTypes
(
    Order_ID VARCHAR(10) NOT NULL,
    ModelCode VARCHAR(10),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (ModelCode) REFERENCES ModelTypes(ModelCode)
);

CREATE TABLE ModelAssignments
(
    Order_ID VARCHAR(10) NOT NULL,
    Model_ID VARCHAR(10) NOT NULL,
    Employee_ID VARCHAR(10) NOT NULL,
    Date_Assigned DATE NOT NULL,
    PRIMARY KEY (Order_ID, Model_ID, Employee_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Model_ID) REFERENCES Models(Model_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);


INSERT INTO Customers VALUES
    ('c1231','Macie','Chew',21313445,'Power AI Ltd.'),
    ('c2231', 'June', 'Gu', 23591312, 'Fish and Dogs'),
    ('c3231', 'Miller',' Wu', 34513265, 'Smart Commute'),
    ('c4231', 'Paul', 'Halim', 11390442, 'B&C Furniture'),
    ('c5231', 'Bella', 'Tan', 75813435, 'City Drainage'),
    ('c6231', 'Kiara', 'Sakura', 24634521, 'City Power'),
    ('c7231' ,'Bowen', 'Han', 75643524, 'Country Development');

INSERT INTO Employees VALUES
    ('s1111', 'Peter', 'Phua', 142524124, 'M'),
    ('s2222', 'George', 'Mason', 344324251, 'M'),
    ('s3333', 'Francis', 'Lee', 234235246, 'M'),
    ('s4444', 'Alice', 'Wong', 324567342, 'F'),
    ('s5555', 'William', 'Chong', 893456114, 'M'),
    ('s6666', 'Brilliant', 'Dior', 907456251, 'F');

INSERT INTO ModelTypes VALUES
    ('DT', 'Decision Tree'),
    ('RF', 'Random Forest'),
    ('LR', 'Linear Regression'),
    ('NN', 'Neural Network'),
    ('SVM', 'Support Vector Machine'),
    ('kNN', 'k-Nearest Neighbour'),
    ('LogR', 'Logistic Regression'),
    ('NB', 'Naive Bayes');

INSERT INTO Datasets VALUES
    ('d1','Adult'),
    ('d2','River'),
    ('d3','Arizona'),
    ('d4','Vermont'),
    ('d5','Covertype'),
    ('d6','Iris');

INSERT INTO Orders VALUES
    ('o080214', 'c5231','2024-04-21', '2024-04-22', 70.0),
    ('o241134', 'c7231','2024-05-01', '2024-07-01', 99.9),
    ('o214132', 'c7231','2024-04-08', '2024-05-01', 50.0),
    ('o174143', 'c7231','2024-04-14', '2024-04-18', 70.0),
    ('o22031', 'c2231','2024-04-05', '2024-04-27', 50.0),
    ('o31421', 'c6231','2024-04-11', '2025-01-01', 1.0),
    ('o00001', 'c1231','2024-05-02', '2024-05-31', 60.0),
    ('o11213', 'c1231','2024-04-03', '2024-04-11', 80.0),
    ('o12345', 'c3231','2024-04-05', '2024-06-30', 77.0),
    ('o12346', 'c3231','2024-04-05', '2024-04-30', 56.0);


INSERT INTO Models VALUES
	('m1000', 'DT', '2024-01-01', 95.6, NULL, 'd1'),
	('m1001', 'LR','2024-01-05', 60.4, NULL, 'd2'),
	('m1002', 'RF','2024-01-07', 95.3, NULL, 'd3'),
	('m1003', 'DT','2024-01-08', 53.2, NULL, 'd4'),
	('m1004', 'LR','2024-01-11', 52.9, NULL, 'd2'),
	('m1005', 'LR','2024-01-15', 91.7, 'm1001', 'd5'),
	('m1006', 'RF','2024-01-17', 85.7, NULL, 'd3'),
	('m1007', 'kNN','2024-01-22', 85.7, NULL, 'd5'),
	('m1008', 'SVM','2024-01-23', 50.6, NULL, 'd3'),
	('m1009', 'kNN','2024-01-24', 51.9, 'm1007', 'd2'),
	('m1010', 'DT','2024-01-27', 93.7, 'm1003', 'd2'),
	('m1011', 'SVM','2024-01-30', 83.1, NULL, 'd4'),
	('m1012', 'SVM','2024-02-06', 97.6, 'm1011', 'd2'),
	('m1013', 'kNN','2024-02-07', 90.3, 'm1009', 'd2'),
	('m1014', 'kNN','2024-02-08', 59.3, NULL, 'd2'),
	('m1015', 'RF','2024-02-12', 59.4, 'm1006', 'd6'),
	('m1016', 'NB','2024-03-04', 70.6, NULL, 'd3'),
	('m1017', 'NN','2024-03-06', 95.5, NULL, 'd6'),
	('m1018', 'LogR','2024-03-12', 54.1, NULL, 'd2'),
	('m1019', 'NN','2024-03-15', 96.8, NULL, 'd6'),
	('m1020', 'NN','2024-03-17', 85.5, 'm1019', 'd4'),
	('m1021', 'LogR','2024-03-21', 60.2, NULL, 'd5'),
	('m1022', 'RF','2024-03-22', 67.1, NULL, 'd4'),
	('m1023', 'NN','2024-03-27', 90.5, 'm1020', 'd6'),
	('m1024', 'RF','2024-03-28', 85.9, 'm1015', 'd3');

INSERT INTO OrderModelTypes (Order_ID, ModelCode) VALUES
    ('o080214', 'DT'),
	('o241134',NULL),
	('o214132',NULL),
	('o174143',NULL),
	('o22031',NULL),
	('o31421',NULL),
    ('o00001', 'SVM'), 
    ('o00001', 'RF'),
    ('o11213', 'SVM'),
	('o12345',NULL),
	('o12346', NULL);


INSERT INTO ModelAssignments VALUES
    ('o080214', 'm1018', 's2222', '2024-04-22'),
    ('o080214', 'm1003', 's3333', '2024-04-22'),
    ('o080214', 'm1010', 's4444', '2024-04-22'),
    ('o241134', 'm1021', 's5555', '2024-04-09'),
    ('o214132', 'm1021', 's5555', '2024-04-09'),
    ('o174143', 'm1008', 's4444', '2024-04-14'),
    ('o22031', 'm1013', 's1111', '2024-04-11'),
    ('o22031', 'm1013', 's3333', '2024-04-12'),
    ('o22031', 'm1013', 's2222', '2024-04-15'),
    ('o22031', 'm1013', 's4444', '2024-04-07'),
    ('o22031', 'm1013', 's6666', '2024-04-27'),
    ('o22031', 'm1013', 's5555', '2024-04-28'),
    ('o31421', 'm1001', 's2222', '2024-04-15'),
    ('o31421', 'm1002', 's2222', '2024-04-15'),
    ('o00001', 'm1012', 's1111', '2024-05-02'),
    ('o00001', 'm1022', 's6666', '2024-05-02'),
    ('o00001', 'm1013', 's5555', '2024-05-02'),
    ('o11213', 'm1003', 's3333', '2024-04-10'),
    ('o11213', 'm1011', 's3333', '2024-04-08'),
    ('o11213', 'm1012', 's3333', '2024-04-09'),
    ('o11213', 'm1012', 's4444', '2024-04-04'),
    ('o12345', 'm1018', 's1111', '2024-05-31'),
    ('o12345', 'm1019', 's3333', '2024-05-31'),
    ('o12346', 'm1015', 's2222', '2024-05-31'),
    ('o12346', 'm1023', 's4444', '2024-05-31'),
    ('o12346', 'm1021', 's6666', '2024-05-31'),
	('o22031', 'm1022', 's1111', '2024-04-19');