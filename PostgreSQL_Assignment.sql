-- Active: 1754086457971@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;

CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(30)
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP DEFAULT NOW(),
    location VARCHAR(30) NOT NULL,
    notes TEXT

);

-- Insert data to rangers table
INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


-- Insert data to species table
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


-- Insert data to sightings table
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-05 07:45:00', 'Camera trap image captured'),
(1, 1, 'Peak Ridge', '2024-05-10 07:40:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


SELECT * from rangers;
SELECT * from species;
SELECT * from sightings;


-- Prob - 1
INSERT INTO rangers(name, region) VALUES('Derek Fox', 'Coastal Plains');

-- Prob - 2
SELECT count(DISTINCT species_id) as unique_species_count  FROM sightings;

-- Prob - 3 
SELECT * FROM sightings WHERE location ILIKE '%Pass';

-- Prob - 4
SELECT name, count(sighting_id) as total_sightings FROM rangers JOIN sightings USING(ranger_id) GROUP BY name;

-- Prob - 6
SELECT common_name, sighting_time, name  FROM sightings JOIN rangers USING(ranger_id) JOIN species USING(species_id) ORDER BY sighting_time  DESC LIMIT 2;

-- Problem 7
UPDATE species SET conservation_status = 'Historic' WHERE extract(year FROM discovery_date) < 1800;