/*
Perform CROSS JOINING using dataset user1 and groups
*/
SELECT * FROM join_dataset.users1 TABLE1
CROSS JOIN join_dataset.groups TABLE2;
/*
Perform INNER JOINING using dataset membership->TABLE1 and user1->TABLE2
for each row R1 in TABLE1
	for each row R2 in TABLE2
		if R1.common_column==R2.common_column
        add combined row to Result
*/
SELECT * FROM join_dataset.membership TABLE1
INNER JOIN join_dataset.users1 TABLE2
ON TABLE1.user_id=TABLE2.user_id;

/*
Perform LEFT JOINING using dataset membership->TABLE1 and user1->TABLE2
for each row R1 in TABLE1
	set matched_in_flag to FALSH
	for each row R2 in TABLE2
		if R1.common_column==R2.common_column
        add combined row to Result
        set matched_in_flag to TRUE
	if matched_in_flag is FALSH
        add TABLE1 row in result        
*/
SELECT * FROM join_dataset.membership TABLE1
LEFT JOIN join_dataset.users1 TABLE2
ON TABLE1.user_id=TABLE2.user_id;

#Perform RIGHT JOINING using dataset membership->TABLE1 and user1->TABLE2
SELECT * FROM join_dataset.membership TABLE1
RIGHT JOIN join_dataset.users1 TABLE2
ON TABLE1.user_id=TABLE2.user_id;

/*
Perform SET OPERATIONS using dataset person1 and person2
UNION/UNION ALL/INTERSECT/EXCEPT
*/
/*
UNION - The UNION operator is used to combine the results of two/more SELECT statements into a single result set.
The UNION operator removes duplicate rows between the various SELECT statements
*/
SELECT * FROM join_dataset.person1
UNION
SELECT * FROM join_dataset.person2;
/*
UNION ALL -  This operator worked same as UNION operator but does not removes duplicate values
*/
SELECT * FROM join_dataset.person1
UNION ALL
SELECT * FROM join_dataset.person2;

SELECT * FROM join_dataset.person1
INTERSECT
SELECT * FROM join_dataset.person2;

SELECT * FROM join_dataset.person1
EXCEPT
SELECT * FROM join_dataset.person2;

#Perform FULL OUTER JOINING using dataset membership->TABLE1 and user1->TABLE2
SELECT * FROM join_dataset.membership TABLE1
LEFT JOIN join_dataset.users1 TABLE2
ON TABLE1.user_id=TABLE2.user_id
UNION
SELECT * FROM join_dataset.membership TABLE1
RIGHT JOIN join_dataset.users1 TABLE2
ON TABLE1.user_id=TABLE2.user_id;

#Perform SELF JOINING using dataset user1
SELECT * FROM join_dataset.users1 TABLE1
JOIN join_dataset.users1 TABLE2
ON TABLE1.emergency_contact=TABLE2.user_id;

/*Performing JOINING on the basis of two different columns
using students and class datasets
*/
SELECT * FROM join_dataset.students TABLE1
JOIN join_dataset.class TABLE2
ON TABLE1.class_id=TABLE2.class_id
AND TABLE1.enrollment_year=TABLE2.class_year;



