
DROP TABLE IF EXISTS normalized_data;
DROP TABLE IF EXISTS book_authors_nf2;
DROP TABLE IF EXISTS book_publisher_nf3;
DROP TABLE IF EXISTS course_books_nf2;
DROP TABLE IF EXISTS nf2_authors;
DROP TABLE IF EXISTS nf2_books;
DROP TABLE IF EXISTS nf2_courses;
DROP TABLE IF EXISTS nf3_books;
DROP TABLE IF EXISTS nf3_publisher;
DROP TABLE IF EXISTS unnormalized_data;


CREATE TABLE normalized_data (
    CRN INT,
    ISBN VARCHAR(20),
    Title VARCHAR(255),
    Author VARCHAR(255),
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_address TEXT,
    Pages INT,
    Year INT,
    Course_name VARCHAR(255)
);

--I wrote this in Command Prompt
--\COPY unnormalized_data FROM 'C:\Users\User\OneDrive\Documents\Unnormalized1.csv' DELIMITER ',' CSV HEADER;

--1NF


INSERT INTO normalized_data (CRN, ISBN, Title, Author, Edition, Publisher, Publisher_address, Pages, Year, Course_name)
SELECT
    CRN,
    ISBN,
    Title,
    TRIM(unnest(string_to_array(Authors, ','))) AS Author,
    Edition,
    Publisher,
    Publisher_address,
    Pages,
    Year,
    Course_name
FROM unnormalized_data;


--2NF


CREATE TABLE NF2_Courses (
    CRN INT PRIMARY KEY,
    course_name VARCHAR(255)
);

INSERT INTO NF2_Courses (CRN, course_name)
SELECT DISTINCT CRN, course_name
FROM normalized_data;

CREATE TABLE NF2_Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(255),
    Edition VARCHAR(50),
    Publisher VARCHAR(255),
    Publisher_address TEXT,
    Pages INT,
    Year INT
);

INSERT INTO NF2_Books (ISBN, Title, Edition, Publisher, Publisher_address, Pages, Year)
SELECT DISTINCT ISBN, Title, Edition, Publisher, Publisher_address, Pages, Year
FROM normalized_data;

CREATE TABLE NF2_Authors (
    AuthorID SERIAL PRIMARY KEY,
    Author_Name VARCHAR(255) UNIQUE
);

INSERT INTO NF2_Authors (Author_Name)
SELECT DISTINCT Author
FROM normalized_data;

CREATE TABLE Book_Authors_NF2 (
    ISBN VARCHAR(13),
    AuthorID INT
    
    
);

INSERT INTO Book_Authors_NF2 (ISBN, AuthorID)
SELECT DISTINCT
    f.ISBN,
    a.AuthorID
FROM normalized_data f
JOIN NF2_Authors a ON f.Author = a.Author_Name;

CREATE TABLE Course_Books_NF2 (
    ISBN VARCHAR(13),
    CRN INT
 
    
);

INSERT INTO Course_Books_NF2 (ISBN, CRN)
SELECT DISTINCT
    f.ISBN,
    c.CRN
FROM normalized_data f
JOIN NF2_Courses c ON f.course_name = c.course_name;

--3NF


CREATE TABLE NF3_Publisher (
    publisher_id SERIAL PRIMARY KEY,
    publisher_name VARCHAR(255),
    publisher_address TEXT
);

INSERT INTO NF3_Publisher (publisher_name, publisher_address)
SELECT DISTINCT publisher, publisher_address
FROM NF2_Books;

CREATE TABLE NF3_Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    title VARCHAR(255),
    edition VARCHAR(50),
    pages INT,
    year INT
);

INSERT INTO NF3_Books (ISBN, title, edition, pages, year)
SELECT DISTINCT ISBN, title, edition, pages, year
FROM NF2_Books;

CREATE TABLE Book_Publisher_NF3 (
    ISBN VARCHAR(13),
    publisher_id INT
    
  
);

INSERT INTO Book_Publisher_NF3 (ISBN, publisher_id)
SELECT DISTINCT
    b.ISBN,
    p.publisher_id
FROM NF2_Books b
JOIN NF3_Publisher p ON b.publisher = p.publisher_name;


 



