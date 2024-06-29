-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS chat_system;

-- Use the database
USE chat_system;

-- Create tables, modify as per your application's schema
-- Example table creation:
-- CREATE TABLE IF NOT EXISTS users (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   username VARCHAR(255) NOT NULL,
--   email VARCHAR(255) NOT NULL
-- );

-- Grant privileges to the database user
-- Replace 'user' and 'password' with your MySQL user and password
GRANT ALL PRIVILEGES ON chat_system.* TO 'user'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
