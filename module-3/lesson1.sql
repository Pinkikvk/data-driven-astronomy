--\d Star
-- +-----------+-----------------------+-----------+
-- |  Column   |         Type          | Modifiers |
-- +-----------+-----------------------+-----------+
-- | kepler_id | integer               | not null  |
-- | koi_name  | character varying(20) | not null  |
-- | t_eff     | integer               |           |
-- | radius    | real                  |           |
-- +-----------+-----------------------+-----------+
-- Indexes:
--     "star_pkey" PRIMARY KEY, btree (koi_name)

--\d Planet
--+-------------+-----------------------+-----------+
--| kepler_id   | integer               | not null  |
--| koi_name    | character varying(20) | not null  |
--| kepler_name | character varying(20) |           |
--| status      | character varying(20) | not null  |
--| period      | double precision      |           |
--| radius      | double precision      |           |
--| t_eq        | integer               |           |
--+-------------+-----------------------+-----------+
--Indexes:
--    "planet_pkey" PRIMARY KEY, btree (koi_name)

-- Large stars
SELECT radius, t_eff
FROM Star
WHERE radius > 1

-- A range of hot stats
SELECT kepler_id, t_eff
FROM Star
WHERE t_eff BETWEEN 5000 AND 6000

-- Confirmed exoplantes
SELECT kepler_name, radius
FROM Planet
WHERE status = 'CONFIRMED' AND radius BETWEEN 1 AND 3

-- Planet statistics
SELECT MIN(radius), MAX(radius), AVG(radius), STDDEV(radius)
FROM Planet
WHERE kepler_name IS NULL

-- Multi-planet systems
SELECT kepler_id, COUNT(*)
FROM Planet
GROUP BY kepler_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC