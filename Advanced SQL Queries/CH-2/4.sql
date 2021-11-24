-- Code 1: SELECT text 'Plural' || 'sight';
SELECT text 'Plural' || 'sight' AS MyAnswer;

-- Code 2: SELECT @ '-4.5' AS "abs";
SELECT @ '-5.5' AS MyAnswer;

SELECT @ '-5.5e500' AS MyAnswer;

-- Code 3: SELECT 1.2 AS "numeric" UNION SELECT 1;

SELECT 1.2 AS MyAnswer UNION SELECT 1; 

