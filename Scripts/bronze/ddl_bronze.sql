IF OBJECT_ID('Bronze.crm_cust_info','U') IS NOT NULL
DROP TABLE Bronze.crm_cust_info;
Create Table Bronze.crm_cust_info(
cst_id int,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_Lastname NVARCHAR(50),
cst_Material_status NVARCHAR(50),
Cst_gndr NVARCHAR(50),
Cst_create_date DATE
);

IF OBJECT_ID('Bronze.crm_prod_info','U') IS NOT NULL
DROP TABLE Bronze.crm_prod_info;
Create Table Bronze.crm_prod_info(
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_date Date,
prd_end_date Date
);

IF OBJECT_ID('Bronze.crm_sales_details','U') IS NOT NULL
DROP TABLE Bronze.crm_sales_details;
Create table Bronze.crm_sales_details(
sls_order_numb NVARCHAR(50),
sls_prod_key NVARCHAR(50),
sls_cust_id INT,
sls_order_date int,
sls_ship_date date,
sls_due_date date,
sls_sales int,
sls_quantity int,
sls_price int

);


IF OBJECT_ID('Bronze.erp_loc_a101','U') IS NOT NULL
DROP TABLE Bronze.erp_loc_a101;
Create table Bronze.erp_loc_a101(
cid NVARCHAR(50),
Country NVARCHAR(50)
);


IF OBJECT_ID('Bronze.erp_cust_az12','U') IS NOT NULL
DROP TABLE Bronze.erp_cust_az12;
Create table Bronze.erp_cust_az12(
Cid NVARCHAR(50),
bdate date,
gen NVARCHAR(50)
);


IF OBJECT_ID('Bronze.erp_px_cat_g1v1','U') IS NOT NULL
DROP TABLE Bronze.erp_px_cat_g1v1;
Create table Bronze.erp_px_cat_g1v1(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
Maintainance NVARCHAR(50)
);

## 🥉 Bronze Layer — Table Creation

The above SQL script is used to create the required tables in the **Bronze layer** of the `DataWarehouse` database.

The Bronze layer is the **raw data layer** of the data warehouse. Its primary purpose is to store data extracted from different source systems with minimal or no transformation.

### Why Are We Creating These Tables?

The source data for this project comes from different business systems, such as **CRM** and **ERP**. Before the data can be cleaned, standardized, integrated, and used for reporting, we first need to load the raw data into dedicated Bronze layer tables.

The tables created in this script represent different source datasets:

| Table                      | Source | Purpose                                                              |
| -------------------------- | ------ | -------------------------------------------------------------------- |
| `Bronze.crm_cust_info`     | CRM    | Stores raw customer information                                      |
| `Bronze.crm_prod_info`     | CRM    | Stores raw product information                                       |
| `Bronze.crm_sales_details` | CRM    | Stores raw sales transaction details                                 |
| `Bronze.erp_loc_a101`      | ERP    | Stores customer location/country information                         |
| `Bronze.erp_cust_az12`     | ERP    | Stores additional customer information such as birth date and gender |
| `Bronze.erp_px_cat_g1v1`   | ERP    | Stores product category and subcategory information                  |

### 🔄 Why Do We Drop the Tables First?

Each table begins with:

```sql
IF OBJECT_ID('Bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE Bronze.crm_cust_info;
```

This checks whether the table already exists.

* `OBJECT_ID()` checks whether the specified database object exists.
* `'U'` specifies that we are checking for a **user table**.
* If the table exists, `DROP TABLE` removes the existing table.
* The table is then recreated with the required structure.

### Why Use This Approach?

During development, ETL pipelines may need to be executed multiple times. Dropping and recreating the Bronze tables ensures that we start with a **clean table structure** and avoid conflicts from previous development runs.

It is particularly useful when:

* Table definitions are changed.
* Data needs to be reloaded.
* The ETL process is being tested.
* Source data needs to be refreshed from scratch.

### 🗃️ Why the Bronze Layer?

The architecture follows a **Bronze → Silver → Gold** approach:

```text
Source Systems
      │
      ▼
┌───────────────┐
│    BRONZE     │
│   Raw Data    │
└───────────────┘
      │
      │ Cleaning & Transformation
      ▼
┌───────────────┐
│    SILVER     │
│ Cleaned Data  │
└───────────────┘
      │
      │ Business Transformation
      ▼
┌───────────────┐
│     GOLD      │
│ Analytical    │
│     Data      │
└───────────────┘
```

### 📌 Important Principle

The Bronze layer should generally preserve the **original structure and values of the source data** as much as possible.

Data quality improvements such as:

* Removing duplicates
* Handling NULL values
* Standardizing formats
* Correcting invalid values
* Converting data types
* Joining different sources
* Applying business rules

are typically performed in the **Silver layer**.

The **Gold layer** then contains business-ready data optimized for analytics, reporting, and dashboards.

### 🎯 Overall Purpose

Therefore, this script establishes the **raw data foundation of the Data Warehouse**. It creates separate tables for CRM and ERP datasets so that the data can subsequently be loaded, validated, transformed, integrated, and ultimately used to build analytical models and reports.

