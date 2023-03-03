/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT first_delte;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT first_delte;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;




SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;



SELECT name FROM animals LEFT JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

SELECT * FROM animals LEFT JOIN species ON animals.species_id = species.id WHERE species.id = 1;

SELECT * FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM animals LEFT JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name AS "Animal", owners.full_name AS "Owner", species.name AS "Species" FROM animals LEFT JOIN owners ON animals.owner_id = owners.id LEFT JOIN species 
ON animals.species_id = species.id WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name AS "Animal", owners.full_name AS "Owner" FROM animals LEFT JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND 
full_name = 'Dean Winchester';

SELECT full_name, COUNT(*) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;


-- JOIN TABLES Queries

SELECT animals.name AS "Animal", vets.name AS "Vet", date_of_visit FROM visits LEFT JOIN vets ON
visits.vet_id = vets.id LEFT JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name AS "Vet",COUNT(*) FROM visits LEFT JOIN vets ON visits.vet_id = vets.id LEFT JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

SELECT * FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name AS "Animals", vets.name AS "Vet" FROM visits LEFT JOIN animals ON visits.animal_id = animals.id
LEFT JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' GROUP BY animals.name, vets.name;

SELECT animals.name AS "Animal", COUNT(*) FROM visits LEFT JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;

SELECT animals.name FROM visits LEFT JOIN animals ON visits.animal_id = animals.id 
LEFT JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

SELECT vets.name AS "Vet",animals.name AS "Animal", date_of_visit FROM visits LEFT JOIN animals ON visits.animal_id = animals.id 
LEFT JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

SELECT vets.name AS "Vet", COUNT(*) FROM visits LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.id WHERE specializations.species_id IS NULL OR specializations.species_id != species.id GROUP BY vets.name;


SELECT vets.name AS "Vet", species.name AS "Specie", COUNT(*) FROM visits LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN animals ON visits.animal_id = animals.id LEFT JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith' GROUP BY vets.name, species.name LIMIT 1;