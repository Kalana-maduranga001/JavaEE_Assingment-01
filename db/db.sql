CREATE DATABASE IF NOT EXISTS CmpManSys_db;
USE CmpManSys_db;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       role ENUM('EMPLOYEE', 'ADMIN') NOT NULL
);

CREATE TABLE complaints (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            user_id INT,
                            title VARCHAR(255),
                            description TEXT,
                            status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED') DEFAULT 'PENDING',
                            remarks TEXT,
                            date DATE,
                            time TIME,
                            FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);
