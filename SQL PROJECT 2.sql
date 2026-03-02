CREATE TABLE hospital (
    hospital_name VARCHAR(100),
    location VARCHAR(100),
    department VARCHAR(100),
    doctors_count INT,
    patients_count INT,
    admission_date DATE,
    discharge_date DATE,
    medical_expenses NUMERIC(10,2)
);


COPY hospital
FROM 'C:/Users/himes/Downloads/Hospital_Data.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM HOSPITAL;

--SOME BASIC AND ADVANCE QUESTION ANSWER

--Q1 TOTAL NUMBER OF PATIENTS:

SELECT SUM(PATIENTS_COUNT) FROM HOSPITAL AS TOTAL_PATIENTS;

--Q2 AVERAGE NUMBER OF DOCTOR PER HOSPITAL:

SELECT hospital_name, AVG(doctors_count) AS average_doctors
FROM hospital
GROUP BY hospital_name;

--Q3 TOP 3 DEPARTMENT WITH THE HIGHEST NUMBER OF PATIENTS:

 SELECT DEPARTMENT, PATIENTS_COUNT
 FROM HOSPITAL
 ORDER BY PATIENTS_COUNT DESC LIMIT 3;

 --Q4 HOSPITAL WITH THE MAXIMUM MEDICAL EXPENSES:

SELECT HOSPITAL_NAME, MEDICAL_EXPENSES
FROM HOSPITAL
ORDER BY MEDICAL_EXPENSES DESC LIMIT 1;

--Q5 CALCULATE THE AVERAGE MAXIMUM EXPENSES PER DAY FOR EACH HOSPITAL:

SELECT hospital_name,
       AVG(daily_max_expense) AS average_max_expense_per_day
FROM (
      SELECT hospital_name,
             admission_date,
             MAX(medical_expenses) AS daily_max_expense
      FROM hospital
      GROUP BY hospital_name, admission_date
     ) sub
GROUP BY hospital_name;

--Q6 FIND THE PATIENTS WITH THE LONGEST STAY BY  CALCULATTING THE DIFFRENCE BETWEEN DISCHARGE DATE AND ADDMISION DATE

SELECT hospital_name,
       admission_date,
       discharge_date,
       (discharge_date - admission_date) AS stay_days
FROM hospital
ORDER BY stay_days DESC
LIMIT 1;
 
--Q7 CALUCLATE THE TOTAL NUMBER OF PATIENTS TREATED IN EACH CITY:

 SELECT DISTINCT LOCATION, SUM(PATIENTS_COUNT)
 FROM HOSPITAL
 GROUP BY LOCATION;

 --Q8 CALCULATE AVERAGE NUMBER OF PATIENTS SPEND IN EACH DEPARTMENT:

SELECT DEPARTMENT, AVG(PATIENTS_COUNT) AS EACH_DEPARTMENT
FROM HOSPITAL
GROUP BY DEPARTMENT;

--Q9 FIND THE DEPARTMENT WITH THE LEAST NUMBER OF PATIENTS:

SELECT department, SUM(patients_count) AS total_patients
FROM hospital
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

--Q10 GROUP THE DATA BY MONTH AND CALCULATE THE  TOTAL MEDICAL EXPENSES IN EACH MONTH:

SELECT 
    EXTRACT(MONTH FROM admission_date) AS month,
    SUM(medical_expenses) AS total_expense
FROM hospital
GROUP BY EXTRACT(MONTH FROM admission_date)
ORDER BY month;



