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

-- Join tables
-- Vets table
CREATE TABLE vets(
id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR,
age INT,
date_of_graduation DATE
);
-- specialization table join table between species and vets
CREATE TABLE specializations(
species_id INT REFERENCES species(id),
vet_id INT REFERENCES vets(id));

-- visits table join table between animals and vets
CREATE TABLE visits(
animal_id INT REFERENCES animals(id),
vet_id INT REFERENCES vets(id),
date_of_visit DATE);