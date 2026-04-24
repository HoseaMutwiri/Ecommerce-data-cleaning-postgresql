## Ecommerce Data Cleaning Project (PostgreSQL)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge&logo=database&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

### Project Overview
This project demonstrates end-to-end data cleaning and transformation of a messy e-commerce dataset using PostgreSQL. The workflow includes data inspection, validation, cleaning, and preparation for analytics.

### Objectives
- Standardize ecommerce data
- Fix inconsistent formats (dates, phones, text)
- Remove duplicates and invalid records
- Prepare dataset for analytics

### Folder Structure
```
ecommerce-data-cleaning/
│
├── data/
│   ├── raw_data/                # Original dataset
│   └── clean_dataset/            # Cleaned output dataset
│
├── sql/
│   ├── 01_data_creation.sql     # Data loading script
│   ├── 02_data_inspection.sql   # Data quality checks/Data exploration queries
│   ├── 03_data_cleaning.sql     # Data cleaning script
│   └── 04_data_validation.sql   # Final Data quality checks
│
├── images/                 # Screenshots 
│   ├── cleaned table info-datatypes.PNG/ 
│   └── order_id_rep.PNG/
├── README.md               # Project documentation
```

### 🔄 Workflow
#### 1. Inspection
- Null values, duplicates, data types
#### 2. Validation
- Emails, phone numbers, date formats
#### 3. Cleaning
- Text standardization
- Regex cleaning for phone numbers
- Fixed mixed date formats
- Removed duplicates
##### 4. Transformation
- Converted data types
- Created final clean dataset(CTAS)

### Result
A clean, structured ecommerce dataset ready for analysis and reporting.

### Future Improvements
- Build dashboard (Power BI)

  
