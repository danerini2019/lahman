SELECT 
	p.playerID,
	COUNT(DISTINCT f.POS) AS positions,
	CONCAT(p.nameFirst, ' ', p.nameLast) AS name, 
	SUM(AB) AS AB,
	SUM(H) AS H,
	SUM(2B) AS 2B,
	SUM(3B) AS 3B,
	SUM(BB) AS BB,
	SUM(SO) AS SO,
	SUM(b.HR) AS HR
FROM people p 
JOIN batting b 
	ON p.playerID = b.playerID
JOIN fielding f
	ON p.playerID = f.playerID 
WHERE b.yearID > 2000
GROUP BY p.playerID
ORDER BY AB DESC
AS table1
-- JOIN (
SELECT * FROM fielding f
LIMIT 100;