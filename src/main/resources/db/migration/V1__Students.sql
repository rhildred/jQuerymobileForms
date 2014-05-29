CREATE TABLE IF NOT EXISTS students(id integer PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64),
address VARCHAR(256), city VARCHAR(256), state VARCHAR(32), post_code VARCHAR(32));

INSERT IGNORE INTO students(id, name, address, city, state, post_code) VALUES
(1, 'Frodo', 'Bag End', 'Shire', 'Middle Earth', '123456'), 
(2, 'Bilbo', 'Bag End', 'Shire', 'Middle Earth', '123456'),
(3, 'Drogo', 'Brandy Hall', 'Shire', 'Middle Earth', '123456');
