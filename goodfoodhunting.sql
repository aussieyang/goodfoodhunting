-- this is run on local database via psql on bash, these are just a record of what was typed into bash

CREATE DATABASE goodfoodhunting;

CREATE TABLE dishes (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  image_url VARCHAR(200)
);

-- line 5 variable character max 100 characters and not allowed to be empty

INSERT INTO dishes (name, image_url) VALUES ('breakfast sandwich', 'http://s3.amazonaws.com/foodspotting-ec2/reviews/5714970/thumb_600.jpg?1453068911?1453075070');

INSERT INTO dishes (name, image_url) VALUES ('xiao long bao', 'http://s3.amazonaws.com/foodspotting-ec2/reviews/1270161/thumb_275.jpg?1327975061');

ALTER TABLE dishes ADD venues VARCHAR(200);

UPDATE dishes SET venues='The Knife' WHERE id=1;

UPDATE dishes SET venues='Hu''s Kitchen' WHERE id=2;


-- New table for dish types (e.g lunch, dinner etc) in order to relate to dishes table.

CREATE TABLE dish_types (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

INSERT INTO dish_types (name) VALUES ('snack');
INSERT INTO dish_types (name) VALUES ('breakfast');
INSERT INTO dish_types (name) VALUES ('lunch');
INSERT INTO dish_types (name) VALUES ('dinner');
INSERT INTO dish_types (name) VALUES ('dessert');

ALTER TABLE dishes ADD dish_type_id INTEGER;

-- New table storing users for login

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(200) NOT NULL,
  password_digest VARCHAR(400) NOT NULL
);

-- New table to store relationship between users and dishes to display likes

CREATE TABLE likes (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER NOT NULL,
  dish_id INTEGER NOT NULL
);

-- dish to users many to many; likes to users/dish many to one

-- Not yet executed on PSQL
-- =============================



-- use JOIN to create virtual table with both sets of data from the tables
