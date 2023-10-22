/* 1.	Enter, modify or delete candidates.

•	List candidate details (candidate ID, last name, first name, street address, suburb, phone number, and status) by first name within last name. */
SELECT * FROM CANDIDATE 
ORDER BY LASTNAME, FIRSTNAME; 
/* •	List certification details (notes and certification date) for a selected candidate. */
SELECT NOTES, CERTIFICATIONDATE FROM CERTIFICATION
WHERE CANDIDATEID =2;
/* 
2.	Enter, modify or delete vacancies. */

--•	List vacancy details (vacancy ID, description, type, status, hourly rate, employer name, and category name) by description.
SELECT 
    V.VacancyID,
    V.Description,
    V.Type,
    V.Status,
    V.HourlyRate,
    E.EMPLOYERNAME,
    C.CATEGORYNAME 
FROM 
    VACANCY V
INNER JOIN 
    EMPLOYER E ON V.EMPLOYERID = E.EMPLOYERID 
INNER JOIN 
    CATEGORY C ON C.CATEGORYID = V.CATEGORYID;

--List employers (employer ID, employer name) by employer name.
SELECT EMPLOYERID, EMPLOYERNAME FROM EMPLOYER
ORDER BY EMPLOYERNAME;

--List categories (category ID, category name) by category name.
SELECT * FROM CATEGORY
ORDER BY CATEGORYNAME;

--3.	Add or remove skills or qualifications to or from a candidate.

--List candidate details (candidate ID, last name, and first name) by first name within last name.
SELECT CANDIDATEID, LASTNAME, FIRSTNAME FROM CANDIDATE
ORDER BY LASTNAME, FIRSTNAME;	
--List skills (skill id and description) by description.
SELECT * FROM SKILL
ORDER BY DESCRIPTION;
--List skills (skill id, description, and years) by description for a selected candidate.
SELECT CS.SKILLID, S.DESCRIPTION, CS.YEARS FROM CANDIDATESKILL CS
INNER JOIN SKILL S ON CS.SKILLID=S.SKILLID
WHERE CANDIDATEID = 2 
ORDER BY DESCRIPTION;
--List qualifications (qualification id, level and description) by description.
SELECT * FROM qualification
ORDER BY DESCRIPTION;
--List qualifications (qualification id, level and description) by description for a selected candidate.
SELECT CQ.QUALIFICATIONID, Q.QUAL_LEVEL, Q.DESCRIPTION FROM CANDIDATEQUALIFICATION CQ
INNER JOIN QUALIFICATION Q ON Q.QUALIFICATIONID = CQ.QUALIFICATIONID
WHERE CQ.CANDIDATEID = 4;
--4.	Add or remove skills or qualifications to or from a candidate.

--List vacancy details (vacancy ID, description, and employer name) for unfilled vacancies only by description.
SELECT
    V.VACANCYID,
    V.DESCRIPTION,
    E.EMPLOYERNAME
FROM
    VACANCY V
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
WHERE STATUS = 'Unfilled'
ORDER BY DESCRIPTION;
--List skills (skill id and description) by description.
SELECT * FROM SKILL
ORDER BY DESCRIPTION;
--List skills (skill id, description, and years) by description for a selected vacancy.
SELECT 
    VS.SKILLID, 
    S.DESCRIPTION, 
    VS.YEARS 
FROM 
    VACANCYSKILL VS
INNER JOIN SKILL S ON S.SKILLID = VS.SKILLID
WHERE VS.VACANCYID = 16
ORDER BY S.DESCRIPTION;
--List qualifications (qualification id, level and description) by description.
SELECT * FROM qualification
ORDER BY DESCRIPTION;
--List qualifications (qualification id, level and description) by description for a selected vacancy.
SELECT
    VQ.QUALIFICATIONID,
    Q.QUAL_LEVEL,
    Q.DESCRIPTION
FROM 
    VACANCYQUALIFICATION VQ
INNER JOIN QUALIFICATION Q ON Q.QUALIFICATIONID = VQ.QUALIFICATIONID
WHERE VQ.VACANCYID = 2
ORDER BY DESCRIPTION;

--5.	Apply a candidate to a vacancy.

--List vacancy details (vacancy ID, description, type, and employer name) for unfilled vacancies only by description.
SELECT
    V.VACANCYID,
    V.DESCRIPTION,
    E.EMPLOYERNAME
FROM
    VACANCY V
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
WHERE STATUS = 'Unfilled'
ORDER BY DESCRIPTION;

--List applications (candidate’s last name and first name) for a selected vacancy by candidate’s last name
SELECT
    C.LASTNAME,
    C.FIRSTNAME
FROM CANDIDATE C
INNER JOIN APPLICATION A ON C.CANDIDATEID = A.CANDIDATEID
WHERE A.VACANCYID = 8
ORDER BY C.LASTNAME;

--List candidate details (candidate ID, last name, and first name) by first name within last name.
SELECT CANDIDATEID, LASTNAME, FIRSTNAME FROM CANDIDATE
ORDER BY LASTNAME, FIRSTNAME;

--List skills (skill id, description, and years) by description for a selected vacancy.
SELECT 
    VS.SKILLID, 
    S.DESCRIPTION, 
    VS.YEARS 
FROM 
    VACANCYSKILL VS
INNER JOIN SKILL S ON S.SKILLID = VS.SKILLID
WHERE VS.VACANCYID = 16
ORDER BY S.DESCRIPTION;
--List qualifications (qualification id, level and description) by description for a selected vacancy.
SELECT
    VQ.QUALIFICATIONID,
    Q.QUAL_LEVEL,
    Q.DESCRIPTION
FROM 
    VACANCYQUALIFICATION VQ
INNER JOIN QUALIFICATION Q ON Q.QUALIFICATIONID = VQ.QUALIFICATIONID
WHERE VQ.VACANCYID = 2
ORDER BY DESCRIPTION;

--List skills (skill id, description, and years) by description for a selected candidate.
SELECT CS.SKILLID, S.DESCRIPTION, CS.YEARS FROM CANDIDATESKILL CS
INNER JOIN SKILL S ON CS.SKILLID=S.SKILLID
WHERE CANDIDATEID = 2 
ORDER BY DESCRIPTION;

--List qualifications (qualification id, level and description) by description for a selected candidate.
SELECT CQ.QUALIFICATIONID, Q.QUAL_LEVEL, Q.DESCRIPTION FROM CANDIDATEQUALIFICATION CQ
INNER JOIN QUALIFICATION Q ON Q.QUALIFICATIONID = CQ.QUALIFICATIONID
WHERE CQ.CANDIDATEID = 4;

--6.	Mark a vacancy as filled.

--List vacancy details (vacancy ID, description, type, hourly rate and employer name) for unfilled vacancies only by description.
SELECT
    V.VACANCYID,
    V.DESCRIPTION,
    V.TYPE,
    V.STATUS,
    V.HOURLYRATE,
    E.EMPLOYERNAME
FROM
    VACANCY V
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
WHERE STATUS = 'Unfilled'
ORDER BY DESCRIPTION;
--List applications (status, candidate’s last name and first name) for a selected vacancy by candidate’s last name
SELECT
    C.LASTNAME,
    C.FIRSTNAME
FROM CANDIDATE C
INNER JOIN APPLICATION A ON C.CANDIDATEID = A.CANDIDATEID
WHERE A.VACANCYID = 8
ORDER BY C.LASTNAME;
--7.	All filled vacancies.

--For each filled vacancy list the vacancy id, description, type, status, category name, employer name, employer street address, employer suburb, descriptions of skills, and descriptions of qualifications.
SELECT
	V.VACANCYID,
	V.Description,
	V.TYPE,
	V.STATUS,
	C.CATEGORYNAME,
	E.EMPLOYERNAME,
	E.STREETADDRESS,
	E.SUBURB,
	S.Description AS SKILL_QUALIFICATION
FROM VACANCY V
INNER JOIN VACANCYSKILL VS ON V.VACANCYID = VS.VACANCYID
INNER JOIN SKILL S ON VS.SKILLID = S.SKILLID
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
INNER JOIN CATEGORY C ON C.CATEGORYID = V.CATEGORYID
WHERE V.STATUS = 'Filled'
UNION
SELECT
	V.VACANCYID,
	V.Description,
	V.TYPE,
	V.STATUS,
	C.CATEGORYNAME,
	E.EMPLOYERNAME,
	E.STREETADDRESS,
	E.SUBURB,
	Q.Description AS SKILL_QUALIFICATION
FROM VACANCY V
INNER JOIN VACANCYQUALIFICATION VQ ON V.VACANCYID = VQ.VACANCYID
INNER JOIN QUALIFICATION Q ON VQ.QUALIFICATIONID = Q.QUALIFICATIONID
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
INNER JOIN CATEGORY C ON C.CATEGORYID = V.CATEGORYID
WHERE V.STATUS = 'Filled'

--8.	All unfilled vacancies.

--For each unfilled vacancy list the vacancy id, description, type, status, category name, employer name, employer street address, employer suburb, descriptions of skills, and descriptions of qualifications.
SELECT
	V.VACANCYID,
	V.Description,
	V.TYPE,
	V.STATUS,
	C.CATEGORYNAME,
	E.EMPLOYERNAME,
	E.STREETADDRESS,
	E.SUBURB,
	S.Description AS SKILL_QUALIFICATION
FROM VACANCY V
INNER JOIN VACANCYSKILL VS ON V.VACANCYID = VS.VACANCYID
INNER JOIN SKILL S ON VS.SKILLID = S.SKILLID
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
INNER JOIN CATEGORY C ON C.CATEGORYID = V.CATEGORYID
WHERE V.STATUS = 'Unfilled'
UNION
SELECT
	V.VACANCYID,
	V.Description,
	V.TYPE,
	V.STATUS,
	C.CATEGORYNAME,
	E.EMPLOYERNAME,
	E.STREETADDRESS,
	E.SUBURB,
	Q.Description AS SKILL_QUALIFICATION
FROM VACANCY V
INNER JOIN VACANCYQUALIFICATION VQ ON V.VACANCYID = VQ.VACANCYID
INNER JOIN QUALIFICATION Q ON VQ.QUALIFICATIONID = Q.QUALIFICATIONID
INNER JOIN EMPLOYER E ON E.EMPLOYERID = V.EMPLOYERID
INNER JOIN CATEGORY C ON C.CATEGORYID = V.CATEGORYID
WHERE V.STATUS = 'Unilled'
--9.	All unfilled vacancies with candidates interested.
SELECT
    V.VACANCYID,
    V.DESCRIPTION,
    V.TYPE,
    V.STATUS,
    E.EMPLOYERNAME,
    S.DESCRIPTION AS SKILL_DESCRIPTION,
    VS.YEARS,
    Q.DESCRIPTION AS QUALIFICATION_DESCRIPTION,
    C.LASTNAME,
    C.FIRSTNAME
FROM VACANCY V
INNER JOIN VACANCYSKILL VS ON VS.VACANCYID = V.VACANCYID
INNER JOIN SKILL S ON S.SKILLID = VS.SKILLID
INNER JOIN VACANCYQUALIFICATION VQ ON VQ.VACANCYID = V.VACANCYID
INNER JOIN QUALIFICATION Q ON VQ.QUALIFICATIONID = Q.QUALIFICATIONID
INNER JOIN EMPLOYER E ON V.EMPLOYERID = E.EMPLOYERID
INNER JOIN APPLICATION A ON A.VACANCYID = V.VACANCYID
INNER JOIN CANDIDATE C ON A.CANDIDATEID = C.CANDIDATEID
WHERE V.STATUS = 'Unfilled'
--For each unfilled vacancy list the vacancy id, description, type, status, employer name, descriptions and years of skills, descriptions of qualifications and full names of the candidates.

--10.	Vacancies by Category.

--For each vacancy list the vacancy id, description, hourly rate, and category name. Sort by category name.

--11.	Vacancies by Employer.

--For each vacancy list the vacancy id, type, status, and employer name. Sort by employer name.

--12.	All Candidates.

--For each candidate list the candidate id, last name, first name, street address, suburb, phone number, status, and certification date (if applicable). Sort by first name within last name.
