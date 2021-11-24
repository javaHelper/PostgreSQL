-- Code 1: SELECT 30 !
SELECT 30 ! AS MyAnswer;

SELECT CAST(30 AS bigint) ! AS MyAnswer;

-- Code 2: SELECT ROUND (4,5)
SELECT ROUND (4,5) AS MyAnswer;

SELECT ROUND(CAST (4 AS numeric), 5) AS MyAnswer;

SELECT ROUND(4.0, 4) AS MyAnswer;

-- Code 3: SELECT SUBSTR(‘4321', 2);

SELECT SUBSTR('4321', 2) AS MyAnswer;

SELECT SUBSTR(varchar '4321', 2) AS MyAnswer;

SELECT substr(CAST ('4321' AS text), 2) AS MyAnswer;
