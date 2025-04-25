CREATE DATABASE HospitalDataBase;

USE [HospitalDataBase];

-- Table Department
CREATE TABLE Department (
    Dep_ID INT PRIMARY KEY,
    Dep_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(200)
);

-- Table Doctor
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(50),
    Email VARCHAR(255) UNIQUE,
    Salary DECIMAL(10, 2),
    Graduation_Year INT,
	Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID) 
);
-- phone number multi valued attribute
CREATE TABLE Dr_Phone (
	Dr_ID INT,
	Phone_Number VARCHAR(50),
	PRIMARY KEY (Dr_ID, Phone_Number),
	FOREIGN KEY (Dr_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE Dept_Manager (
	Dep_ID INT,
	Doctor_ID INT,
	Start_Date DATE,
	PRIMARY KEY (Dep_ID, Doctor_ID),
	FOREIGN KEY (Dep_ID) references Department(Dep_ID),
	FOREIGN KEY (Doctor_ID) references Doctor(Doctor_ID)
);

-- Create Staff table
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(50),
	Age INT,
    Email VARCHAR(255) UNIQUE,
    Salary DECIMAL(10, 2),
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

-- phone number multi valued attribute
CREATE TABLE Staff_Phone (
	Staff_ID INT,
	Phone_Number VARCHAR(50),
	PRIMARY KEY (Staff_ID, Phone_Number),
	FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);


-- Table Nurse
CREATE TABLE Nurse (
    Nurse_ID INT PRIMARY KEY,
	First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(50),
    Email VARCHAR(255) UNIQUE,
    Salary DECIMAL(10, 2),
	Graduation_Year INT,
    Dep_ID INT, 
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID) ON DELETE SET NULL,
);

-- phone number multi valued attribute
CREATE TABLE Nurse_Phone (
	Nurse_ID INT,
	Phone_Number VARCHAR(50),
	PRIMARY KEY (Nurse_ID, Phone_Number),
	FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID)
);

CREATE TABLE Nurse_Supervision (
    Nurse_ID INT,
    Supervisor_ID INT,
    Start_Date DATE,
    PRIMARY KEY (Nurse_ID, Supervisor_ID),
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) ON DELETE CASCADE,
    FOREIGN KEY (Supervisor_ID) REFERENCES Nurse(Nurse_ID) 
);

CREATE TABLE Related_Entity (
    Related_ID INT,
    Entity_Type VARCHAR(50), 
    Entity_ID INT,           
    PRIMARY KEY (Related_ID, Entity_Type), 
    FOREIGN KEY (Entity_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Entity_ID) REFERENCES Nurse(Nurse_ID) ON DELETE CASCADE,
    FOREIGN KEY (Entity_ID) REFERENCES Staff(Staff_ID) ON DELETE CASCADE
);

-- Creat Dependent Table
CREATE TABLE Dependent (
    Dependent_ID INT PRIMARY KEY, 
    Related_ID INT,
    Entity_Type VARCHAR(50),
    Dependent_Name VARCHAR(100),
    Relationship VARCHAR(50),
    BirthDate DATE,
    Gender VARCHAR(50),
    FOREIGN KEY (Related_ID, Entity_Type) REFERENCES Related_Entity(Related_ID, Entity_Type) ON DELETE CASCADE
);

-- Create Patient table
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(50),
    Social_Status VARCHAR(50),
    Address VARCHAR(100),
);

-- phone number multi valued attribute
CREATE TABLE Patient_Phone (
	Patient_ID INT,
	Phone_Number VARCHAR(50),
	PRIMARY KEY (Patient_ID, Phone_Number),
	FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- Create Room table
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Type VARCHAR(100),
    AvailabilityStatus BIT DEFAULT 1,
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

-- Create Medical Record table with details 
CREATE TABLE Medical_Record (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT,
	Doctor_ID INT,
	Nurse_ID INT,
    Room_ID INT,
	Date DATE,
    Examination VARCHAR(255),
	Cost decimal(30,10),
	FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
	FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);


-- Create Ambulance table
CREATE TABLE Ambulance (
    Ambulance_ID INT PRIMARY KEY,
    Plate_Number VARCHAR(50) UNIQUE,
    Availability BIT DEFAULT 1,
);
-- Create Emergency Center table
CREATE TABLE Emergency_Center (
    Emergency_ID INT PRIMARY KEY,
    Record_ID INT,
    Emergency_Type VARCHAR(100),
    Arrival_Time DATETIME,
    Discharge_Time DATETIME,
    Ambulance_ID INT,
    FOREIGN KEY (Record_ID) REFERENCES Medical_Record(Record_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Ambulance_ID) REFERENCES Ambulance(Ambulance_ID)ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Medical_Drugs (
    Record_ID INT,
    Drug_Name VARCHAR(255),
    PRIMARY KEY (Record_ID, Drug_Name),
    FOREIGN KEY (Record_ID) REFERENCES Medical_Record(Record_ID)
);


INSERT INTO Department (Dep_ID, Dep_Name, Location) VALUES
(1, 'Cardiology', 'Building A'),
(2, 'Neurology', 'Building B'),
(3, 'Pediatrics', 'Building C'),
(4, 'Oncology', 'Building D'),
(5, 'Orthopedics', 'Building E'),
(6, 'Data Entry', 'Building F'),
(7, 'HR', 'Building G'),
(8, 'Security', 'Building H'),
(9,'Receptionist ','Building G');

INSERT INTO Doctor (Doctor_ID, First_Name, Last_Name, Gender, Email, Salary, Graduation_Year, Dep_ID) VALUES
(1, 'John', 'Doe', 'Male', 'johndoe@example.com', 150000.00, 2010, 1),
(2, 'Jane', 'Smith', 'Female', 'janesmith@example.com', 140000.00, 2012, 2),
(3, 'Michael', 'Brown', 'Male', 'michaelbrown@example.com', 130000.00, 2015, 3),
(4, 'Emily', 'White', 'Female', 'emilywhite@example.com', 125000.00, 2018, 4),
(5, 'David', 'Taylor', 'Male', 'davidtaylor@example.com', 120000.00,2014 ,5),
(6, 'Richard', 'Lee', 'Male', 'richardlee@example.com', 135000.00, 2011, 1), 
(7, 'Sophia', 'Kim', 'Female', 'sophiakim@example.com', 145000.00, 2013, 2),
(8, 'Henry', 'Choi', 'Male', 'henrychoi@example.com', 125000.00, 2016, 3), 
(9, 'Amelia', 'Nguyen', 'Female', 'amelia.nguyen@example.com', 130000.00, 2017, 4), 
(10, 'Ethan', 'Patel', 'Male', 'ethanpatel@example.com', 120000.00, 2019, 5);

INSERT INTO Nurse (Nurse_ID, First_Name, Last_Name, Gender, Email, Salary, Graduation_Year, Dep_ID) VALUES
(1, 'Laura', 'Evans', 'Female', 'lauraevans@example.com', 60000.00, 2016, 1),
(2, 'Peter', 'Lopez', 'Male', 'peterlopez@example.com', 59000.00, 2014, 2),
(3, 'Sophia', 'Hill', 'Female', 'sophiahill@example.com', 61000.00, 2017, 3),
(4, 'James', 'Scott', 'Male', 'jamesscott@example.com', 58000.00, 2015, 4),
(5, 'Olivia', 'King', 'Female', 'oliviaking@example.com', 62000.00, 2018, 5),
(6, 'Ella', 'Brooks', 'Female', 'ellabrooks@example.com', 61000.00, 2017, 1), 
(7, 'Noah', 'Reed', 'Male', 'noahreed@example.com', 62000.00, 2018, 2),      
(8, 'Liam', 'Morris', 'Male', 'liammorris@example.com', 60000.00, 2015, 3),   
(9, 'Ava', 'Mitchell', 'Female', 'avamitchell@example.com', 63000.00, 2016, 4), 
(10, 'Olivia', 'Stevens', 'Female', 'oliviastevens@example.com', 64000.00, 2019, 5),
(11, 'Jack', 'Turner', 'Male', 'jackturner@example.com', 59000.00, 2014, 1),   
(12, 'Sophia', 'Walker', 'Female', 'sophiawalker@example.com', 60000.00, 2016, 2),
(13, 'James', 'Baker', 'Male', 'jamesbaker@example.com', 58000.00, 2013, 3),   
(14, 'Emma', 'Harris', 'Female', 'emmaharris@example.com', 65000.00, 2018, 4),
(15, 'Lucas', 'Davis', 'Male', 'lucasdavis@example.com', 61000.00, 2017, 5);

INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Age, Gender, Social_Status, Address) VALUES
(1, 'Jacob', 'Miller', 45, 'Male', 'Married', '123 Main St'),
(2, 'Sophia', 'Clark', 30, 'Female', 'Single', '456 Elm St'),
(3, 'Emma', 'Lewis', 25, 'Female', 'Single', '789 Pine St'),
(4, 'William', 'Walker', 60, 'Male', 'Married', '101 Maple St'),
(5, 'Mason', 'Hall', 50, 'Male', 'Divorced', '202 Oak St'),
(6, 'Liam', 'Anderson', 34, 'Male', 'Single', '321 Cedar St'),
(7, 'Mia', 'Roberts', 27, 'Female', 'Married', '654 Birch St'),
(8, 'Ethan', 'Parker', 48, 'Male', 'Married', '987 Willow St'),
(9, 'Sophia', 'Green', 40, 'Female', 'Single', '111 Spruce St'),
(10, 'Oliver', 'Adams', 22, 'Male', 'Single', '222 Aspen St'),
(11, 'Emma', 'Clark', 31, 'Female', 'Married', '333 Elm St'),
(12, 'Mason', 'Lewis', 29, 'Male', 'Single', '444 Pine St'),
(13, 'Ava', 'Walker', 50, 'Female', 'Widowed', '555 Oak St'),
(14, 'James', 'Hall', 38, 'Male', 'Married', '666 Maple St'),
(15, 'Emily', 'Allen', 45, 'Female', 'Divorced', '777 Walnut St');

INSERT INTO Staff (Staff_ID, First_Name, Last_Name, Gender, Age, Email, Salary, Dep_ID) VALUES
(1, 'Sarah', 'Johnson', 'Female', 35, 'sarahjohnson@example.com', 50000.00, 6),
(2, 'Tom', 'Wilson', 'Male', 40, 'tomwilson@example.com', 52000.00, 8),
(3, 'Alice', 'Davis', 'Female', 29, 'alicedavis@example.com', 48000.00, 9),
(4, 'Jack', 'Martinez', 'Male', 50, 'jackmartinez@example.com', 55000.00,6),
(5, 'Anna', 'Garcia', 'Female', 32, 'annagarcia@example.com', 47000.00, 7),
(6, 'Emily', 'Adams', 'Female', 28, 'emilyadams@example.com', 35000.00, 6), 
(7, 'Mark', 'Harris', 'Male', 34, 'markharris@example.com', 40000.00, 9),  
(8, 'Lisa', 'Clarkson', 'Female', 45, 'lisaclarkson@example.com', 60000.00, 7), 
(9, 'Tom', 'Anderson', 'Male', 38, 'tomanderson@example.com', 62000.00, 6),
(10, 'James', 'Bond', 'Male', 50, 'jamesbond@example.com', 30000.00, 8),    
(11, 'Alice', 'Wright', 'Female', 29, 'alicewright@example.com', 28000.00, 9);

INSERT INTO Room (Room_ID, Room_Type, AvailabilityStatus, Dep_ID) VALUES
(1, 'ICU', 1, 1),
(2, 'General', 1, 2),
(3, 'Private', 0, 3),
(4, 'Semi-Private', 1, 4),
(5, 'ICU', 0, 5),
(6, 'ICU', 1, 1),
(7, 'Private Room', 1, 2),
(8, 'Shared Room', 1, 3),
(9, 'Private Room', 0, 4),
(10, 'Operating Room', 1, 5),
(11, 'Shared Room', 1, 1), 
(12, 'Private Room', 1, 2), 
(13, 'ICU', 0, 3), 
(14, 'Shared Room', 1, 4), 
(15, 'Operating Room', 1, 5);


INSERT INTO Medical_Record (Record_ID, Patient_ID, Doctor_ID, Room_ID, Date, Examination, Cost) VALUES
(1, 1, 1, 1, '2024-12-01', 'Heart Surgery', 10000.00),
(2, 2, 2, 2, '2024-12-02', 'Brain Scan', 5000.00),
(3, 3, 3, 3, '2024-12-03', 'Pediatric Checkup', 3000.00),
(4, 4, 4, 4, '2024-12-04', 'Chemotherapy', 8000.00),
(5, 5, 5, 5, '2024-12-05', 'Knee Replacement', 7000.00),
(6, 6, 6, 6, '2024-01-01', 'Cardiac Checkup', 200.00),
(7, 7, 7, 7, '2024-01-02', 'Neurological Exam', 250.00),
(8, 8, 8, 8, '2024-01-03', 'Pediatric Consultation', 150.00),
(9, 9, 9, 9, '2024-01-04', 'Oncology Screening', 300.00),
(10, 10, 10, 10, '2024-01-05', 'Orthopedic Surgery', 500.00),
(11, 11, 6, 11, '2024-01-06', 'Cardiac Follow-Up', 180.00),
(12, 12, 7, 12, '2024-01-07', 'Neurological Therapy', 400.00),
(13, 13, 8, 13, '2024-01-08', 'Pediatric Vaccination', 100.00),
(14, 14, 9, 14, '2024-01-09', 'Oncology Treatment', 450.00),
(15, 15, 10, 15, '2024-01-10', 'Orthopedic Consultation', 200.00);


UPDATE Medical_Record
SET Nurse_ID = CASE 
    WHEN Record_ID = 1 THEN 1
    WHEN Record_ID = 2 THEN 2
    WHEN Record_ID = 3 THEN 3
    WHEN Record_ID = 4 THEN 4
    WHEN Record_ID = 5 THEN 5
    WHEN Record_ID = 6 THEN 6
    WHEN Record_ID = 7 THEN 7
    WHEN Record_ID = 8 THEN 8
    WHEN Record_ID = 9 THEN 9
    WHEN Record_ID = 10 THEN 10
    WHEN Record_ID = 11 THEN 6
    WHEN Record_ID = 12 THEN 7
    WHEN Record_ID = 13 THEN 8
    WHEN Record_ID = 14 THEN 9
    WHEN Record_ID = 15 THEN 10
    ELSE NULL 
END
WHERE Record_ID BETWEEN 1 AND 15;


INSERT INTO Medical_Drugs (Record_ID, Drug_Name) VALUES
(1, 'Aspirin'),
(2, 'Paracetamol'),
(3, 'Ibuprofen'),
(4, 'Aspirin'),
(4, 'Metoprolol'),
(7, 'Gabapentin'),
(7, 'Paracetamol'),
(8, 'Amoxicillin'),
(8, 'Ibuprofen'),
(9, 'Cisplatin'),
(9, 'Ondansetron'),
(10, 'Ibuprofen'),
(10, 'Diclofenac'),
(11, 'Lisinopril'),
(11, 'Atorvastatin'),
(12, 'Diazepam'),
(12, 'Tramadol'),
(13, 'Paracetamol'),
(13, 'Multivitamin'),
(14, 'Doxorubicin'),
(14, 'Filgrastim'),
(15, 'Calcium Carbonate'),
(15, 'Vitamin D');

INSERT INTO Ambulance (Ambulance_ID, Plate_Number, Availability) VALUES
(1, 'AB123CD', 1),
(2, 'EF456GH', 1),
(3, 'IJ789KL', 0),
(6, 'ABC-5678', 1),
(7, 'XYZ-4321', 0),
(8, 'LMN-9876', 1),
(9, 'JKL-1234', 1),
(10, 'PQR-8765', 0);

INSERT INTO Ambulance (Ambulance_ID, Plate_Number, Availability)
VALUES
(4, 'MN456OP', 1),
(5, 'QR789ST', 1);

SELECT Record_ID FROM Medical_Record WHERE Record_ID IN (1, 2, 3, 4, 5, 6);

SELECT Ambulance_ID FROM Ambulance WHERE Ambulance_ID IN (1, 2, 3, 4, 5, 6);

INSERT INTO Emergency_Center (Emergency_ID, Record_ID, Emergency_Type, Arrival_Time, Discharge_Time, Ambulance_ID) VALUES
(1, 1, 'Cardiac Arrest', '2024-12-01 10:30', '2024-12-01 12:30', 1),
(2, 2, 'Seizure', '2024-12-02 14:00', '2024-12-02 15:30', 2),
(3, 3, 'Respiratory Distress', '2024-12-03 09:45', '2024-12-03 11:15', 3),
(4, 4, 'Severe Trauma', '2024-12-04 13:20', '2024-12-04 16:00', 4),
(5, 5, 'Stroke', '2024-12-05 08:10', '2024-12-05 10:30', 5),
(6, 6, 'Motor Vehicle Accident', '2024-12-06 19:00', '2024-12-06 22:00', 6);

-- Insert Nurse Supervision relationships
INSERT INTO Nurse_Supervision (Nurse_ID, Supervisor_ID, Start_Date) VALUES
(1, 5, '2024-01-01'), 
(2, 5, '2024-02-01'), 
(3, 6, '2024-03-01'), 
(4, 6, '2024-04-01');

INSERT INTO Related_Entity (Related_ID, Entity_Type, Entity_ID) VALUES
(1, 'Doctor', 1),
(2, 'Nurse', 2), 
(3, 'Staff', 6),  
(4, 'Doctor', 3);

INSERT INTO Dependent (Dependent_ID, Related_ID, Entity_Type, Dependent_Name, Relationship, BirthDate, Gender) VALUES
(1, 1, 'Doctor', 'Alice Smith', 'Daughter', '2010-05-15', 'Female'), 
(2, 2, 'Nurse', 'Bob Jones', 'Son', '2015-08-20', 'Male'),   
(3, 3, 'Staff', 'Charlie Brown', 'Spouse', '1985-03-10', 'Male'),  
(4, 4, 'Doctor', 'Daisy White', 'Mother', '1955-11-22', 'Female');
