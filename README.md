Here’s an improved and well-formatted version of your README:

---

# **Database Assignment**

## **Overview**
This project demonstrates the process of normalizing an unstructured dataset into **First Normal Form (1NF)**, **Second Normal Form (2NF)**, and finally **Third Normal Form (3NF)**. The goal is to reduce redundancy, eliminate anomalies, and improve database efficiency and integrity. Each normalization step involves restructuring the data into separate, logically connected tables.

---

## **Steps of Normalization**

### **1. Initial Setup**
- **Unnormalized Data**: The initial dataset includes columns such as `CRN`, `ISBN`, `Title`, `Authors`, `Publisher`, and `Course Name`.
- Created the table `normalized_data` to hold atomic values after splitting the `Authors` column (1NF).

---

### **2. First Normal Form (1NF)**
- Ensured each column contains atomic values by splitting multi-valued attributes in the `Authors` column.
- Used the `string_to_array` and `unnest` functions to separate `Authors` into individual rows.
- Populated the `normalized_data` table with atomic values.

---

### **3. Second Normal Form (2NF)**
#### **Removed Partial Dependencies:**
1. **`Course Name`** moved to a separate `NF2_Courses` table linked by `CRN`.
2. **`Authors`** moved to an `NF2_Authors` table, with an `AuthorID` as the primary key.
3. Established relationships:
   - Books and Authors relationship managed through a mapping table `Book_Authors_NF2`.
   - Books and Courses relationship managed through a mapping table `Course_Books_NF2`.

#### **Tables Created:**
- **NF2_Courses**: Stores course-related data.
- **NF2_Books**: Stores book-related data.
- **NF2_Authors**: Stores unique author names with a generated `AuthorID`.
- **Book_Authors_NF2**: Links books (`ISBN`) to authors (`AuthorID`).
- **Course_Books_NF2**: Links books (`ISBN`) to courses (`CRN`).

---

### **4. Third Normal Form (3NF)**
#### **Removed Transitive Dependencies:**
1. Created a `NF3_Publisher` table to store publisher-related details (`publisher_name` and `publisher_address`), linked by `publisher_id`.
2. Removed `publisher` and `publisher_address` from `NF2_Books` and stored only `publisher_id`.

#### **Tables Created:**
- **NF3_Publisher**: Stores unique publisher details (`publisher_name`, `publisher_address`).
- **NF3_Books**: Stores book-specific details excluding publisher information.
- **Book_Publisher_NF3**: Links books (`ISBN`) to publishers (`publisher_id`).

---

## **Benefits of Normalization**
- **Reduced Redundancy**: Data is stored in separate tables, avoiding duplication.
- **Improved Data Integrity**: Referential integrity is enforced through primary and foreign keys.
- **Efficient Querying**: Smaller, logically connected tables make querying faster and more efficient.
- **Scalability**: A properly normalized database is easier to maintain and scale.

---
## **Conclusion**
Normalization ensures data consistency, eliminates redundancy, and improves database efficiency. By transforming the dataset into **Third Normal Form (3NF)**, we achieved a structured design that supports accurate, scalable, and efficient queries. This project highlights the importance of normalization in maintaining a clean and maintainable database.
