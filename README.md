

# **Database Assignment**

## **Overview**
This project demonstrates the process of normalizing an unstructured dataset into **First Normal Form (1NF)**, **Second Normal Form (2NF)**, and finally **Third Normal Form (3NF)**. The objective is to minimize redundancy, eliminate anomalies, and enhance database efficiency and integrity. Each step of normalization restructures data into logically organized tables.

---

## **Steps of Normalization**

### **1. Initial Setup**
- **Unnormalized Data**: The initial dataset includes the following columns:
  - `CRN`
  - `ISBN`
  - `Title`
  - `Authors`
  - `Publisher`
  - `Course Name`
- The `normalized_data` table was created to hold atomic values after transforming the `Authors` column into 1NF.

---

### **2. First Normal Form (1NF)**
- Ensured atomic values for each column by splitting multi-valued attributes in the `Authors` column.
- Applied the `string_to_array` and `unnest` functions to split `Authors` into individual rows.
- Populated the `normalized_data` table with atomic values.

---

### **3. Second Normal Form (2NF)**
#### **Addressed Partial Dependencies:**
1. Extracted `Course Name` into a new table (`NF2_Courses`), linked by `CRN`.
2. Created a separate `NF2_Authors` table to manage author details, introducing a unique `AuthorID`.
3. Established relationships:
   - Books and Authors: Managed through the `Book_Authors_NF2` mapping table.
   - Books and Courses: Managed through the `Course_Books_NF2` mapping table.

#### **Tables Created:**
- **NF2_Courses**: Holds course details with a `CRN` as the primary key.
- **NF2_Books**: Contains book-specific information.
- **NF2_Authors**: Manages unique author names, identified by `AuthorID`.
- **Book_Authors_NF2**: Links books (`ISBN`) with authors (`AuthorID`).
- **Course_Books_NF2**: Links books (`ISBN`) with courses (`CRN`).

---

### **4. Third Normal Form (3NF)**
#### **Addressed Transitive Dependencies:**
1. Introduced the `NF3_Publisher` table for publisher details (`publisher_name` and `publisher_address`), identified by `publisher_id`.
2. Removed `publisher` and `publisher_address` from `NF2_Books` and replaced them with `publisher_id`.

#### **Tables Created:**
- **NF3_Publisher**: Contains unique publisher details (`publisher_name`, `publisher_address`).
- **NF3_Books**: Retains book-specific details without direct publisher data.
- **Book_Publisher_NF3**: Links books (`ISBN`) with publishers (`publisher_id`).

---

## **Benefits of Normalization**
- **Reduced Redundancy**: Data is divided into discrete tables, avoiding duplication.
- **Improved Data Integrity**: Referential integrity is upheld through primary and foreign key relationships.
- **Efficient Querying**: Streamlined and logically connected tables optimize query performance.
- **Scalability**: The normalized structure simplifies database maintenance and scalability.

---

## **Conclusion**
The normalization process transformed the dataset into **Third Normal Form (3NF)**, ensuring data consistency, eliminating redundancy, and enhancing efficiency. This project underscores the significance of normalization in creating a maintainable and scalable database design.

---

