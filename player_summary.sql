WITH tA AS (
	SELECT 
		p.playerID,
		CONCAT(p.nameFirst, ' ', p.nameLast) AS name, 
		YEAR(p.debut),
		YEAR(p.finalgame_date),
		SUM(AB) AS AB,
		SUM(H) AS H,
		SUM(2B) AS 2B,
		SUM(3B) AS 3B,
		SUM(BB) AS BB,
		SUM(SO) AS SO,
		SUM(b.HR) AS HR,
		SUM(b.HBP) AS HBP,
		SUM(b.IBB) AS IBB,
		COUNT(DISTINCT f.POS) AS no_of_positions
	FROM people p 
	JOIN batting b 
		ON p.playerID = b.playerID
	JOIN fielding f
		ON p.playerID = f.playerID 
	WHERE YEAR(p.debut) > 2000
	GROUP BY p.playerID)
	SELECT 
		tA.*, 
		tA.H / tA.AB AS BA,
		(tA.H + tA.BB + tA.IBB + tA.HBP)/ tA.AB AS OBP,
		(tA.2B + tA.3B + tA.HR) / tA.H AS SLG,
-- 		OBP + SLG AS OPS,
		tB.main_pos, 
		tB.main_team,
		tB.errors
	FROM tA
	JOIN (
		SELECT t1.playerID, t1.teamID AS main_team, t1.POS AS main_pos, t2.errors
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
	ON tA.playerID = tB.playerID
	WHERE tA.AB > 500
	ORDER BY OBP DESC;


	