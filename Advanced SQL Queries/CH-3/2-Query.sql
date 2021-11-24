SELECT *
FROM "Accounts";

UPDATE "Accounts"
SET "Amount" = "Amount" - 100
WHERE "Name" = 'Beth';

SELECT *
FROM "Accounts";

UPDATE "Accounts"
SET "Amount" = "Amount" + 100
WHERE "Name" = 'Troy';

SELECT *
FROM "Accounts";















-- Reset Script
UPDATE "Accounts"
SET "Amount" = 100
WHERE "Name" = 'Beth';
UPDATE "Accounts"
SET "Amount" = 200
WHERE "Name" = 'Troy';