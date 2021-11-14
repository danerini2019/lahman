WITH tA AS (
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
	GROUP BY p.playerID)
JOIN (
	SELECT t1.playerID, t1.POS, t2.errors
	FROM fielding
	AS t1
	JOIN (
		SELECT playerID, MAX(G) AS games, SUM(E) AS errors
		FROM fielding
		GROUP BY playerID
	) AS t2
	ON t1.playerID = t2.playerID AND t1.G = t2.games
	ORDER BY playerID
) AS tB
ON tA.playerID = tB.playerID;
	
	
	
	