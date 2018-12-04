SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `menu_category`;
CREATE TABLE IF NOT EXISTS `menu_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `top_level` BOOLEAN DEFAULT 1,
  `multiselect` BOOLEAN DEFAULT 1,
  PRIMARY KEY (`id`)
);

INSERT INTO `menu_category` (`name`, `top_level`, `multiselect`) values
("Pizza", 1, 1),
("Finger food", 1, 1),
("Drinks", 1, 1),

("Sause", 0, 1),
("Pizza Size", 0, 0),
("Cheese toppings", 0, 1),
("Meat toppings", 0, 1),
("Pasta type", 0, 0),
("Nuggets size", 0, 0);



DROP TABLE IF EXISTS `menu_item`;
CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `menu_category_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10, 2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`menu_category_id`) REFERENCES `menu_category`(`id`)
);

INSERT INTO `menu_item` (`menu_category_id`, `name`, `price`) values
(1, "Pizza Salami", 9.95),
(1, "Pizza Hawai", 10.45),

(2, "Chicken Nuggets", 5.55),
(2, "Chicken Fingers", 4.95),
(2, "Potato Wedges", 3.45),
(2, "Garlic Bread", 3.25),

(4, "Chilli Sause", 1.25),
(4, "BBQ Sause", 1.25),
(4, "Mayo", 1.25),

(5, "32cm", 0.00),
(5, "36cm", 4.00),
(5, "40cm", 8.00),

(6, "Cheese", 1.5),
(6, "Mozzarella", 1.5),
(6, "Gorgonzola", 1.5),

(7, "Paprika", 1.00),
(7, "Ananas", 1.00),
(7, "Kip", 1.00),
(7, "Salami", 1.00),

(8, "Penne", 0),
(8, "Spaghetti", 0),
(8, "Tagliatelle", 0),

(3, "Coke", 2.25),
(3, "Fanta", 2.25),

(9, "Chicken Nuggets", 0.00),
(9, "Chicken Nuggets x2", 9.55),
(9, "Chicken Nuggets x3", 12.55);


DROP TABLE IF EXISTS `menu_item_categories`;
CREATE TABLE IF NOT EXISTS `menu_item_categories` (
  `menu_item_id` INT NOT NULL,
  `menu_category_id` INT NOT NULL,
  PRIMARY KEY (`menu_item_id`, `menu_category_id`)
);

INSERT INTO `menu_item_categories` (`menu_item_id`, `menu_category_id`) values
(1, 5),
(1, 6),
(1, 7),

(2, 5),
(2, 6),

(3, 9),
(3, 4),

(4, 4),

(5, 4);


DROP TABLE IF EXISTS `basket_item`;
CREATE TABLE IF NOT EXISTS `basket_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `menu_item_id` INT NOT NULL,
  `qty` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item`(`id`)
);

DROP TABLE IF EXISTS `basket_item_modifier`;
CREATE TABLE IF NOT EXISTS `basket_item_modifier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `basket_item_id` INT NOT NULL,
  `menu_item_id`  INT NOT NULL,
  `qty` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`basket_item_id`) REFERENCES `basket_item`(`id`),
  FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item`(`id`)
);

SET FOREIGN_KEY_CHECKS=1;