USE [HospitalDataBase];


--To Find Bill
select 
	M.Patient_ID,
	CONCAT(P. First_Name,' ',P.Last_Name) AS Name,
	M.Record_ID,
	M.Cost AS Examination_Cost
from
	Medical_Record M
left join
	Patient P
	ON M.Patient_ID=P.Patient_ID;

--show doctor name, id  and departments
SELECT 
    Doctor.Doctor_ID, 
    CONCAT(Doctor.First_Name, ' ', Doctor.Last_Name) AS Doctor_Name, 
    Department.Dep_Name AS Department_Name
FROM 
    Doctor
INNER JOIN 
    Department 
ON 
    Doctor.Dep_ID = Department.Dep_ID;

--number of patients in each department
SELECT 
    Department.Dep_Name AS Department_Name, 
    COUNT(Medical_Record.Patient_ID) AS Patient_Count
FROM 
    Medical_Record
INNER JOIN 
    Room 
ON 
    Medical_Record.Room_ID = Room.Room_ID
INNER JOIN 
    Department 
ON 
    Room.Dep_ID = Department.Dep_ID
GROUP BY 
    Department.Dep_Name;


-- show nurse name with thier supervisor name
SELECT 
    Nurse.Nurse_ID, 
    CONCAT(Nurse.First_Name, ' ', Nurse.Last_Name) AS Nurse_Name, 
    CONCAT(Supervisor.First_Name, ' ', Supervisor.Last_Name) AS Supervisor_Name
FROM 
    Nurse_Supervision
INNER JOIN 
    Nurse 
ON 
    Nurse_Supervision.Nurse_ID = Nurse.Nurse_ID
INNER JOIN 
    Nurse AS Supervisor 
ON 
    Nurse_Supervision.Supervisor_ID = Supervisor.Nurse_ID;


--number of available rooms
SELECT 
    Room.Room_Type, 
    COUNT(Room.Room_ID) AS Available_Rooms
FROM 
    Room
WHERE 
    Room.AvailabilityStatus = 1
GROUP BY 
    Room.Room_Type;


--some details for patient with age > 40 or married
SELECT 
    Patient_ID, 
    CONCAT(First_Name, ' ', Last_Name) AS Patient_Name, 
    Age, 
    Social_Status
FROM 
    Patient
WHERE 
    Age > 40 OR Social_Status = 'Married';


	SELECT MR.*, EC.Emergency_ID
FROM Medical_Record MR
JOIN Emergency_Center EC
    ON MR.Record_ID = EC.Record_ID;