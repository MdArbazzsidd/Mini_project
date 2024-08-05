-- -- phpMyAdmin SQL Dump
-- -- version 5.1.0
-- -- https://www.phpmyadmin.net/
-- --
-- -- Host: 127.0.0.1
-- -- Generation Time: Sep 26, 2021 at 10:38 PM
-- -- Server version: 10.4.18-MariaDB
-- -- PHP Version: 8.0.3

-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- START TRANSACTION;
-- SET time_zone = "+00:00";


-- /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
-- /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
-- /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
-- /*!40101 SET NAMES utf8mb4 */;

-- --
-- -- Database: `online_book_store_db`
-- --

-- -- --------------------------------------------------------

-- --
-- -- Table structure for table `admin`
-- --

-- CREATE TABLE `admin` (
--   `id` int(11) NOT NULL,
--   `full_name` varchar(255) NOT NULL,
--   `email` varchar(255) NOT NULL,
--   `password` text NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --
-- -- Dumping data for table `admin`
-- --

-- INSERT INTO `admin` (`id`, `full_name`, `email`, `password`) VALUES
-- (1, 'Elias', 'eliasfsdev@gmail.com', '$2y$10$Nqq/y251QX2Ccvb1Ax7hUuMqQSkG3yRLCxN2KPdetnSP3oaXVH70a');

-- -- --------------------------------------------------------

-- --
-- -- Table structure for table `authors`
-- --

-- CREATE TABLE `authors` (
--   `id` int(11) NOT NULL,
--   `name` varchar(255) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -- --------------------------------------------------------

-- --
-- -- Table structure for table `books`
-- --

-- CREATE TABLE `books` (
--   `id` int(11) NOT NULL,
--   `title` varchar(255) NOT NULL,
--   `author_id` int(11) NOT NULL,
--   `description` text NOT NULL,
--   `category_id` int(11) NOT NULL,
--   `cover` varchar(255) NOT NULL,
--   `file` varchar(255) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -- --------------------------------------------------------

-- --
-- -- Table structure for table `categories`
-- --

-- CREATE TABLE `categories` (
--   `id` int(11) NOT NULL,
--   `name` varchar(255) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --
-- -- Indexes for dumped tables
-- --

-- --
-- -- Indexes for table `admin`
-- --
-- ALTER TABLE `admin`
--   ADD PRIMARY KEY (`id`);

-- --
-- -- Indexes for table `authors`
-- --
-- ALTER TABLE `authors`
--   ADD PRIMARY KEY (`id`);

-- --
-- -- Indexes for table `books`
-- --
-- ALTER TABLE `books`
--   ADD PRIMARY KEY (`id`);

-- --
-- -- Indexes for table `categories`
-- --
-- ALTER TABLE `categories`
--   ADD PRIMARY KEY (`id`);

-- --
-- -- AUTO_INCREMENT for dumped tables
-- --

-- --
-- -- AUTO_INCREMENT for table `admin`
-- --
-- ALTER TABLE `admin`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

-- --
-- -- AUTO_INCREMENT for table `authors`
-- --
-- ALTER TABLE `authors`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- --
-- -- AUTO_INCREMENT for table `books`
-- --
-- ALTER TABLE `books`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- --
-- -- AUTO_INCREMENT for table `categories`
-- --
-- ALTER TABLE `categories`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
-- COMMIT;

-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;






-- Create the database
CREATE DATABASE IF NOT EXISTS online_book_store_db;
USE online_book_store_db;

-- Table structure for table admin
CREATE TABLE IF NOT EXISTS admin (
  id int(11) NOT NULL AUTO_INCREMENT,
  full_name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data into admin
INSERT INTO admin (id, full_name, email, password) VALUES
(1, 'Elias', 'eliasfsdev@gmail.com', '$2y$10$Nqq/y251QX2Ccvb1Ax7hUuMqQSkG3yRLCxN2KPdetnSP3oaXVH70a');

-- Table structure for table authors
CREATE TABLE IF NOT EXISTS authors (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  bio text,
  date_of_birth date,
  nationality varchar(255),
  awards varchar(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data into authors
INSERT INTO authors (id, name, bio, date_of_birth, nationality, awards) VALUES
(1, 'J.K. Rowling', 'British author', '1965-07-31', 'British', 'Multiple Awards');

-- Table structure for table categories
CREATE TABLE IF NOT EXISTS categories (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  description text,
  created_at datetime NOT NULL,
  updated_at datetime,
  status varchar(50) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data into categories
INSERT INTO categories (id, name, description, created_at, updated_at, status) VALUES
(1, 'Fantasy', 'Fantasy books', NOW(), NOW(), 'active');

-- Table structure for table books
CREATE TABLE IF NOT EXISTS books (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  author_id int(11) NOT NULL,
  description text NOT NULL,
  category_id int(11) NOT NULL,
  cover varchar(255) NOT NULL,
  file varchar(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data into books
INSERT INTO books (id, title, author_id, description, category_id, cover, file) VALUES
(1, 'Harry Potter and the Philosopher\' 'Stone', 1, 'Fantasy novel', 1, 'cover.jpg', 'book.pdf' );

-- Table structure for table orders
CREATE TABLE IF NOT EXISTS orders (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  order_date datetime NOT NULL,
  total_amount decimal(10,2) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES admin(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table order_items
CREATE TABLE IF NOT EXISTS order_items (
  id int(11) NOT NULL AUTO_INCREMENT,
  order_id int(11) NOT NULL,
  book_id int(11) NOT NULL,
  quantity int(11) NOT NULL,
  price decimal(10,2) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (book_id) REFERENCES books(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create view to display book details
CREATE OR REPLACE VIEW book_details AS
SELECT 
    b.id as book_id,
    b.title,
    a.name as author,
    c.name as category,
    b.description,
    b.cover,
    b.file
FROM 
    books b
JOIN 
    authors a ON b.author_id = a.id
JOIN 
    categories c ON b.category_id = c.id;

-- Create trigger to update the updated_at field in categories table
DELIMITER //
CREATE TRIGGER before_category_update
BEFORE UPDATE ON categories
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END //
DELIMITER ;

COMMIT;
