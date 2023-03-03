/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
 id SERIAL PRIMARY KEY,
 name TEXT,
 date_of_birth DATE,
 escape_attempts INT,
 neutered BOOLEAN,
 weight_kg NUMERIC
);

ALTER TABLE animals ADD species TEXT;


CREATE TABLE owners(
id SERIAL NOT NULL PRIMARY KEY,
full_name VARCHAR,
age INT)

CREATE TABLE species(
id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR);


ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);