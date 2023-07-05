-- Recursive SQL query
--Syntex
WITH [RECURSIVE] CET_NAME AS
(
	SELECT query (Non recursive sql base query)
	UNION[ALL]
	SELECT query (recursive query (With a terminating condition))
)
SELECT * FROM CET_NAME;

CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );
INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');

SELECT * FROM emp_details;

--  Find the hierarchy of employees under a given manager

WITH RECURSIVE emp_hierarchy AS 
(
	SELECT id,name,manager_id,designation,1 as lvl
	FROM emp_details  WHERE name='Asha'
	UNION
	SELECT E.id,E.name,E.manager_id,E.designation,H.lvl+1 AS lvl
	FROM emp_hierarchy H 
	JOIN emp_details E
	ON  H.id = E.manager_id
)
SELECT H2.id AS emp_id,H2.name AS emp_name,E2.name AS manager_name,H2.lvl AS lvl 
FROM emp_hierarchy H2
JOIN emp_details E2
ON E2.id=H2.manager_id;

-- Find the hierarchy of managers for a given employee

WITH RECURSIVE emp_hierarchy AS 
(
	SELECT id,name,manager_id,designation,1 as lvl
	FROM emp_details  WHERE name='David'
	UNION
	SELECT E.id,E.name,E.manager_id,E.designation,H.lvl+1 AS lvl
	FROM emp_hierarchy H 
	JOIN emp_details E
	ON  H.manager_id = E.id
)
SELECT H2.id AS emp_id,H2.name AS emp_name,E2.name AS manager_name,H2.lvl AS lvl 
FROM emp_hierarchy H2
JOIN emp_details E2
ON E2.id=H2.manager_id;












