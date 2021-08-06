/*
 *
 *  * Copyright (c) 2021 Manoj Randeni. All rights reserved.
 *  * Licensed under the Apache license. See License.txt in the project root for license information
 *
 */

DROP DATABASE IF EXISTS dep7;

CREATE DATABASE dep7;

USE dep7;

CREATE TABLE student
(
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(450) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE contact
(
    contact    VARCHAR(12) NOT NULL,
    student_id INT         NOT NULL,
    CONSTRAINT PRIMARY KEY (contact, student_id),
    CONSTRAINT fk_contact FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE ON UPDATE CASCADE
);

# Parent table cannot be truncated when there is a foreign key constraint with a child table. (Even child table don't have data)
TRUNCATE student;

#  Delete all the data from a parent table
DELETE
FROM student
WHERE TRUE;

# Delete all the data from a child table
TRUNCATE contact;

# Reset auto increment to 1
ALTER TABLE student
    AUTO_INCREMENT = 1;


INSERT INTO student (name)
VALUES ('Wanidu Hasaranga');
INSERT INTO student (name)
VALUES ('Lasith Malinga');
INSERT INTO student (name)
VALUES ('Nuwan Pradeep');
INSERT INTO student (name)
VALUES ('Nuwan Kulasekara');
INSERT INTO student (name)
VALUES ('Rangana Herath');
INSERT INTO student (name)
VALUES ('Sanath Jayasuriya');

INSERT INTO contact
VALUES ('071 152 1458', 1);
INSERT INTO contact
VALUES ('074 359 1589', 1);
INSERT INTO contact
VALUES ('185 369 2578', 2);
INSERT INTO contact
VALUES ('359 268 2578', 2);
INSERT INTO contact
VALUES ('157 486 2589', 2);
INSERT INTO contact
VALUES ('174 258 3698', 3);
INSERT INTO contact
VALUES ('157 248 2685', 4);
INSERT INTO contact
VALUES ('357 158 7596', 4);
INSERT INTO contact
VALUES ('145 258 1452', 4);
INSERT INTO contact
VALUES ('952 122 1436', 5);

# CROSS JOIN
SELECT *
FROM student,
     contact;
SELECT *
FROM student
         CROSS JOIN contact;

#INNER JOIN
SELECT *
FROM student
         INNER JOIN contact;

#INNER JOIN (Can be consider as an Equi Join since there is an = sign)
SELECT *
FROM student
         INNER JOIN contact ON student.id = contact.student_id;

# RIGHT Join
SELECT *
FROM student
         RIGHT OUTER JOIN contact ON student.id = contact.student_id;

# LEFT Join
SELECT *
FROM student
         LEFT OUTER JOIN contact ON student.id = contact.student_id;


# FULL OUTER in standard SQL
# SELECT * FROM student FULL OUTER JOIN contact;

#Full outer is not implemented in MySQL yet so need to do the following work around to get full outer join in MySQL
SELECT *
FROM student
         LEFT OUTER JOIN contact on student.id = contact.student_id
UNION
SELECT *
FROM student
         RIGHT OUTER JOIN contact on student.id = contact.student_id;

# NATURAL JOIN
SELECT *
FROM student
         NATURAL JOIN contact;

ALTER TABLE contact
    ADD COLUMN provider_id INT NOT NULL;

ALTER TABLE contact
    ADD CONSTRAINT FOREIGN KEY (provider_id) REFERENCES provider (id);


DROP TABLE IF EXISTS contact;

CREATE TABLE provider
(
    id       INT PRIMARY KEY,
    provider VARCHAR(50) NOT NULL
);

INSERT INTO provider (id, provider)
VALUES (1, 'Dialog');
INSERT INTO provider (id, provider)
VALUES (2, 'Mobitel');
INSERT INTO provider (id, provider)
VALUES (3, 'Hutch');
INSERT INTO provider (id, provider)
VALUES (4, 'SLT');


ALTER table provider
    ADD CONSTRAINT UNIQUE (provider);

SHOW INDEXES FROM provider;


SELECT s.id, s.name, CONCAT(c.contact, ' - ', p.provider) AS contact FROM student s LEFT OUTER JOIN contact c on s.id = c.student_id LEFT OUTER JOIN provider p ON c.provider_id = p.id;