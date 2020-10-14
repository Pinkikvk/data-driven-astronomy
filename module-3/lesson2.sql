--             Table "public.star"
-- +-----------+------------------+-----------+
-- |  Column   |       Type       | Modifiers |
-- +-----------+------------------+-----------+
-- | kepler_id | integer          | not null  |
-- | t_eff     | integer          | not null  |
-- | radius    | double precision | not null  |
-- +-----------+------------------+-----------+
-- Indexes:
--     "star_pkey" PRIMARY KEY, btree (kepler_id)
-- Referenced by:
--     TABLE "planet" CONSTRAINT "planet_kepler_id_fkey" FOREIGN KEY (kepler_id) REFERENCES star(kepler_id)

--                Table "public.planet"
-- +-------------+-----------------------+-----------+
-- |   Column    |         Type          | Modifiers |
-- +-------------+-----------------------+-----------+
-- | kepler_id   | integer               | not null  |
-- | koi_name    | character varying(20) | not null  |
-- | kepler_name | character varying(20) |           |
-- | status      | character varying(20) | not null  |
-- | period      | double precision      | not null  |
-- | radius      | double precision      | not null  |
-- | t_eq        | integer               | not null  |
-- +-------------+-----------------------+-----------+
-- Indexes:
--     "planet_pkey" PRIMARY KEY, btree (koi_name)
-- Foreign-key constraints:
--     "planet_kepler_id_fkey" FOREIGN KEY (kepler_id) REFERENCES star(kepler_id)

SELECT s.radius AS sun_radius, p.radius AS planet_radius
FROM Star AS s
JOIN Planet AS p ON s.kepler_id = p.kepler_id
WHERE s.radius > p.radius
ORDER BY s.radius DESC

SELECT s.radius AS radius, count(*)
FROM Star AS s
JOIN Planet AS p ON s.kepler_id = p.kepler_id
GROUP BY s.kepler_id
ORDER BY s.radius DESC

SELECT s.radius AS radius, count(*) as count
FROM Star AS s
JOIN Planet AS p ON s.kepler_id = p.kepler_id
WHERE s.radius > 1
GROUP BY s.kepler_id
HAVING count(*) > 1
ORDER BY s.radius DESC

SELECT s.kepler_id, s.t_eff, s.radius
FROM Star AS s
LEFT OUTER JOIN Planet AS p ON s.kepler_id = p.kepler_id
WHERE p.kepler_id IS NULL
ORDER BY s.t_eff DESC

SELECT ROUND(AVG(p.t_eq),1), MIN(s.t_eff), MAX(s.t_eff)
FROM Star AS s
JOIN Planet AS p ON s.kepler_id = p.kepler_id
WHERE s.t_eff > (SELECT AVG(t_eff) FROM Star)

SELECT p.koi_name, p.radius, s.radius
FROM Star AS s
JOIN Planet AS p ON s.kepler_id = p.kepler_id
WHERE s.kepler_id IN (
    SELECT kepler_id FROM Star
    ORDER BY radius DESC
    LIMIT 5
)