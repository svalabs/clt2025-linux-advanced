CREATE USER 'training'@'localhost' IDENTIFIED BY 'geffjeerling';
GRANT ALL PRIVILEGES ON training.* TO 'training'@localhost;
CREATE DATABASE training;
FLUSH PRIVILEGES;
