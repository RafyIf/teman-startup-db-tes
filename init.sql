
CREATE DATABASE IF NOT EXISTS interview_teman_startup;

CREATE TABLE IF NOT EXISTS tb_user (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_created DATETIME NOT NULL,
    date_modified DATETIME NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_avatar (
    id INT NOT NULL AUTO_INCREMENT,
    content_type VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    date_created DATETIME NOT NULL,
    date_modified DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY file_name (file_name)
);

CREATE TABLE IF NOT EXISTS tb_user_profile (
    id_user INT UNSIGNED,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    birthdate DATE,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    id_avatar INT NOT NULL,
    date_created DATETIME NOT NULL,
    date_modified DATETIME NOT NULL,
    PRIMARY KEY (id_user),
    FOREIGN KEY (id_user)
        REFERENCES tb_user (id)
        ON UPDATE RESTRICT ON DELETE CASCADE,
    FOREIGN KEY (id_avatar)
        REFERENCES tb_avatar (id)
        ON UPDATE RESTRICT ON DELETE CASCADE
);

ALTER TABLE tb_user
  MODIFY password TEXT NOT NULL;

-- example insert
-- password with bcrypt
-- password: 12345
-- password_hash: $2a$12$q28MqtAaiXVACe8hwhRDXe6bC5F6uRbVjJhBZR4kXfy1cnI5IMJGu

START TRANSACTION;
INSERT INTO tb_avatar (content_type, file_name, date_created, date_modified)
  VALUES('image/jpeg', 'user-interviews.jpeg', now(), now());
SELECT LAST_INSERT_ID() INTO @v_id_avatar;
INSERT INTO tb_user (email, password, date_created, date_modified)
  VALUES('interview@gmail.com', '$2a$12$q28MqtAaiXVACe8hwhRDXe6bC5F6uRbVjJhBZR4kXfy1cnI5IMJGu', now(), now());
SELECT LAST_INSERT_ID() INTO @v_id_user;
INSERT INTO tb_user_profile (id_user, name, phone, gender, birthdate, country, city, address, id_avatar, date_created, date_modified) 
  VALUES(@v_id_user, 'User Interview', '+6281556781290', 'male', '1990-11-23', 'Indonesia', 'Jakarta', 'Jl Kb Pala I 17 RT 007/05, Dki Jakarta', @v_id_avatar, now(), now());
COMMIT;