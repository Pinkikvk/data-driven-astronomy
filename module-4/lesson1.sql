INSERT INTO Star (kepler_id, t_eff, radius) VALUES
(7115384,3789,27.384),
(8106973,5810,0.811),
(9391817,6200,0.958);

--
UPDATE Planet
SET kepler_name = NULL
WHERE status != 'CONFIRMED';

DELETE FROM Planet
WHERE radius < 0;


--
-- SMALLINT	Signed two-byte integer
-- INTEGER	Signed four-byte integer
-- FLOAT	Eight-byte floating-point number
-- CHAR(n)	Fixed-length string with n characters
-- VARCHAR(n)	Variable-length string with maximum n characters

-- NOT NULL	Value cannot be NULL
-- UNIQUE	Value must be unique in the table
-- DEFAULT	Specifies a default if the field is left blank
-- CHECK	Ensures that the value meets a specific condition
-- PRIMARY KEY	Combination of NOT NULL and UNIQUE
-- FOREIGN KEY	Ensures the data matches the specified attribute in another table

CREATE TABLE Planet (
  kepler_id INTEGER NOT NULL,
  koi_name VARCHAR(15) NOT NULL UNIQUE,
  kepler_name VARCHAR(15) ,
  status VARCHAR(20) NOT NULL,
  radius FLOAT NOT NULL
);

INSERT INTO Planet (kepler_id, koi_name, kepler_name, status, radius) VALUES
(6862328,'K00865.01',NULL,'CANDIDATE',119.021),
(10187017,'K00082.05','Kepler-102 b','CONFIRMED',5.286),
(10187017,'K00082.04','Kepler-102 c','CONFIRMED',7.071)

--
CREATE TABLE Star (
  kepler_id INTEGER PRIMARY KEY,
  t_eff INTEGER NOT NULL,
  radius FLOAT NOT NULL
);

CREATE TABLE Planet (
  kepler_id INTEGER REFERENCES Star (kepler_id),
  koi_name VARCHAR(20) PRIMARY KEY,
  kepler_name VARCHAR(20),
  status VARCHAR(20) NOT NULL,
  period FLOAT,
  radius FLOAT,
  t_eq INTEGER
);

COPY Star (kepler_id, t_eff, radius) FROM 'stars.csv' CSV;

COPY Planet (kepler_id, koi_name, kepler_name, status, period, radius, t_eq) FROM 'planets.csv' CSV;

--
DELETE FROM Star;

ALTER TABLE Star
ADD COLUMN ra FLOAT,
ADD COLUMN decl FLOAT;

COPY Star (kepler_id, t_eff, radius, ra, decl) FROM 'stars_full.csv' CSV;