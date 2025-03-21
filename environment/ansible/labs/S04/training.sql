CREATE TABLE trainings(training_id int auto_increment, training_name tinytext not null, training_year int not null, PRIMARY KEY(training_id));

INSERT INTO trainings (training_name, training_year) VALUES ('Linux Advanced', 2025);
