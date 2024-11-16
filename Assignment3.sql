DROP TABLE IF EXISTS unnormalized_data;


CREATE TABLE unnormalized_data (
    CRN INT,
    ISBN VARCHAR(20),
    Title VARCHAR(255),
    Authors TEXT,
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_address TEXT,
    Pages INT,
    Year INT,
    Course_name VARCHAR(255)
);
