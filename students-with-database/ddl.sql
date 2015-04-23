CREATE TABLE students (
    id          SERIAL PRIMARY KEY,
    pid         INTEGER,
    first_name  TEXT,
    middle_name TEXT,
    last_name   TEXT
);

INSERT INTO students (pid, first_name, middle_name, last_name) values (77777777, 'Mary', '', 'Doe');
INSERT INTO students (pid, first_name, middle_name, last_name) values (88888888, 'John', 'T', 'Smith');

