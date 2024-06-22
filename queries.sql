USE SPAI2317933

--QN1

SELECT
    COUNT(*) - COUNT(Parent_Model_ID) AS FreshModel, -- COUNTS NULL
    COUNT(Parent_Model_ID) AS FinetunedModel  --COUNTS NOT NULL

FROM Models;

--QN2  

SELECT
    mt.ModelType, -- Select ModelType
    COUNT(m.Model_ID) AS NumberUnassigned, -- Count unassigned models
    FORMAT(AVG(m.Accuracy), '0.0') AS MeanAccuracy, -- Average accuracy
    MAX(m.Accuracy) AS MaxAccuracy -- Maximum accuracy
FROM
    Models m -- From Models table
JOIN (
    -- Subquery to count unassigned models
    SELECT
        a.ModelCode,
        SUM(CASE WHEN b.Model_ID IS NULL THEN 1 ELSE 0 END) AS NumberUnassigned
    FROM
        Models a
    LEFT JOIN ModelAssignments b ON a.Model_ID = b.Model_ID -- Left join with ModelAssignments
    GROUP BY
        a.ModelCode
) AS u ON m.ModelCode = u.ModelCode -- Join subquery result
INNER JOIN
    ModelTypes mt ON mt.ModelCode = m.ModelCode -- Inner join with ModelTypes
WHERE
    NumberUnassigned > 0 -- Filter to include unassigned models
GROUP BY
    m.ModelCode,
    mt.ModelType
ORDER BY
    mt.ModelType; -- Order by ModelType





--QN3

SELECT CONCAT(E.First_Name, ' ', E.Last_Name) AS Full_Name, E.Contact, E.Gender
FROM Employees E
JOIN (
    -- Subquery to find employees assigned multiple models

    SELECT MA.Employee_ID
    FROM ModelAssignments MA
    GROUP BY MA.Employee_ID, MA.Order_ID
    HAVING COUNT(DISTINCT MA.Model_ID) > 1
) M ON E.Employee_ID = M.Employee_ID -- Join with Employees table
ORDER BY Full_Name; -- Order by full name



--QN4

SELECT COUNT(*) AS NumberAccepted
FROM ModelAssignments AS ma
INNER JOIN Models AS m ON ma.Model_ID = m.Model_ID	
INNER JOIN Orders AS o ON ma.Order_ID = o.Order_ID
LEFT JOIN OrderModelTypes as omt on omt.Order_ID = o.Order_ID
WHERE 

-- Condition 1: Check if the model was assigned before or on the completion date of the order
    ma.Date_Assigned <= o.Completion_Date

-- Condition 2: Verify if the assigned model's code is among the accepted types specified by the order
	AND ((omt.ModelCode is NULL) or omt.ModelCode=m.ModelCode)

-- Condition 3: Ensure that the assigned model's testing accuracy is equal to or greater than the order’s accuracy requirement
    AND m.Accuracy >= o.Required_Accuracy;

