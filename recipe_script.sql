-- script to initialize normalized recipe database --

CREATE DATABASE IF NOT EXISTS myrecipes;

USE myrecipes;

-- administrator --
CREATE TABLE administrator  (
	id          	int(11) AUTO_INCREMENT NOT NULL,
	username   	varchar(100) NOT NULL,
	password    	varchar(200) NOT NULL,
	salt        	varchar(200) NULL,
	PRIMARY KEY  (`id`)
	);
INSERT INTO administrator(id, username, password, salt)
  VALUES(1, 'admin', 'admin', '');

-- recipes --
CREATE TABLE recipes  (
	recipe_id  int(11) AUTO_INCREMENT NOT NULL,
	recipe_title  varchar(50) NOT NULL,
	recipe_summary	text NULL,
	recipe_time	varchar(30) NULL,
	recipe_image  	varchar(45) NULL,
	PRIMARY KEY  (`recipe_id`),
	UNIQUE (`recipe_title`)
	);
INSERT INTO recipes(recipe_id, recipe_title, recipe_summary, recipe_time, recipe_image)
  VALUES(1, 'Waffles', 'Delicious waffles', '20 minutes', '');
INSERT INTO recipes(recipe_id, recipe_title, recipe_summary, recipe_time, recipe_image)
  VALUES(2, 'Toast', 'Everyone likes toast', '2 minutes', '');
INSERT INTO recipes(recipe_id, recipe_title, recipe_summary, recipe_time, recipe_image)
  VALUES(3, 'Jam', 'To put on your toast and waffles', '1 hour', '');

-- ingredients --
CREATE TABLE ingredients  (
	ingredient_id              	int(11) AUTO_INCREMENT NOT NULL,
	ingredient_name           	varchar(50) NOT NULL,
	PRIMARY KEY  (`ingredient_id`),
	UNIQUE (`ingredient_name`)
	);
INSERT INTO ingredients(ingredient_id, ingredient_name)
  VALUES(1, 'Bread');
INSERT INTO ingredients(ingredient_id, ingredient_name)
  VALUES(2, 'Flour');
INSERT INTO ingredients(ingredient_id, ingredient_name)
  VALUES(3, 'Sugar');
INSERT INTO ingredients(ingredient_id, ingredient_name)
	 VALUES(4, 'Salt');
INSERT INTO ingredients(ingredient_id, ingredient_name)
	 VALUES(5, 'Eggs');
INSERT INTO ingredients(ingredient_id, ingredient_name)
   VALUES(6, 'Blueberries');
INSERT INTO ingredients(ingredient_id, ingredient_name)
	 VALUES(7, 'Milk');
INSERT INTO ingredients(ingredient_id, ingredient_name)
	  VALUES(8, 'Banana');
INSERT INTO ingredients(ingredient_id, ingredient_name)
		 VALUES(9, 'Ice');
INSERT INTO ingredients(ingredient_id, ingredient_name)
		  VALUES(10, 'Water');
INSERT INTO ingredients(ingredient_id, ingredient_name)
		VALUES(11, 'Lemon');
INSERT INTO ingredients(ingredient_id, ingredient_name)
		 VALUES(12, 'Vanilla');
INSERT INTO ingredients(ingredient_id, ingredient_name)
			VALUES(13, 'Butter');


-- steps --
CREATE TABLE steps  (
	recipe_id    	int(11) NOT NULL,
	step_number  	int(3) NOT NULL,
	step_summary  	varchar(500) NOT NULL,
	FOREIGN KEY  (`recipe_id`)
	REFERENCES recipes(`recipe_id`)
	);
INSERT INTO steps(recipe_id, step_number, step_summary)
  VALUES(1, 1, "Beat wet ingredients together");
INSERT INTO steps(recipe_id, step_number, step_summary)
	 VALUES(1, 2, "Mix dry ingredients together");
INSERT INTO steps(recipe_id, step_number, step_summary)
   VALUES(1, 3, "Combine wet and dry until smooth");
INSERT INTO steps(recipe_id, step_number, step_summary)
   VALUES(1, 4, "Cook on a waffle iron");
INSERT INTO steps(recipe_id, step_number, step_summary)
	 VALUES(2, 1, "Place bread in toaster until browned");
INSERT INTO steps(recipe_id, step_number, step_summary)
   VALUES(2, 2, "Spread butter on hot toast");
INSERT INTO steps(recipe_id, step_number, step_summary)
  VALUES(3, 1, "Place all ingredients in large pot and heat on stove");
INSERT INTO steps(recipe_id, step_number, step_summary)
	 VALUES(3, 2, "Stir and cook until thickened");
INSERT INTO steps(recipe_id, step_number, step_summary)
  VALUES(3, 3, "Store in jars or eat immediately");

-- measurements --
CREATE TABLE measurements  (
	measurement_id  	int(11) AUTO_INCREMENT NOT NULL,
	measurement_name	varchar(45) NOT NULL,
	PRIMARY KEY  (`measurement_id`)
	);
INSERT INTO measurements(measurement_id, measurement_name)
  VALUES(1, 'cup');
INSERT INTO measurements(measurement_id, measurement_name)
  VALUES(2, 'tablespoon');
INSERT INTO measurements(measurement_id, measurement_name)
  VALUES(3, 'teaspoon');
INSERT INTO measurements(measurement_id, measurement_name)
  VALUES(4, 'gram');
INSERT INTO measurements(measurement_id, measurement_name)
  VALUES(5, 'ounce');
  
  -- Amounts --
CREATE TABLE amounts  (
	amount_id    	int(11) AUTO_INCREMENT NOT NULL,
	recipe_id	int(11) NOT NULL,
	ingredient_id int(11) NOT NULL,
	measurement_id int(11) NULL,
	ingredient_amount float NULL,
	PRIMARY KEY (`amount_id`),
	FOREIGN KEY (`recipe_id`) REFERENCES recipes(`recipe_id`),
	FOREIGN KEY (`ingredient_id`) REFERENCES ingredients(`ingredient_id`),
	FOREIGN KEY (`measurement_id`) REFERENCES measurements(`measurement_id`)
);
INSERT INTO amounts(amount_id, recipe_id, ingredient_id, measurement_id, ingredient_amount)
  VALUES (1, 1, 2, 1, 3),
	(2, 1, 3, 1, .25),
	(3, 1, 5, NULL, 2),
	(4, 1, 7, 1, 3),
	(5, 1, 12, 3, 1),
	(6, 1, 13, 4, 50),
	(7, 2, 1, NULL, 2),
	(8, 2, 13, 2, 1),
	(9, 3, 6, 1, 6),
	(10,3, 3, 1, 4),
	(11, 3, 10, 1, 3);

