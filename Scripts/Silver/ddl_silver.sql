--## Creating Tables in silver layer

IF OBJECT_ID('Silver.crm_cust_info','U') IS NOT NULL
DROP TABLE Silver.crm_cust_info;
Create Table Silver.crm_cust_info(
cst_id int,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_Lastname NVARCHAR(50),
cst_Material_status NVARCHAR(50),
Cst_gndr NVARCHAR(50),
Cst_create_date DATE,
dwh_Create_date Date Default getdate()
);

IF OBJECT_ID('Silver.crm_prod_info','U') IS NOT NULL
DROP TABLE Silver.crm_prod_info;
Create Table Silver.crm_prod_info(
prd_id INT,
cat_id NVARCHAR(50),
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_date Date,
prd_end_date Date,
dwh_Create_date Date Default getdate()

);

IF OBJECT_ID('Silver.crm_sales_details','U') IS NOT NULL
DROP TABLE Silver.crm_sales_details;
Create table Silver.crm_sales_details(
sls_order_numb NVARCHAR(50),
sls_prod_key NVARCHAR(50),
sls_cust_id INT,
sls_order_date date,
sls_ship_date date,
sls_due_date date,
sls_sales int,
sls_quantity int,
sls_price int,
dwh_Create_date Date Default getdate()

);


IF OBJECT_ID('Silver.erp_loc_a101','U') IS NOT NULL
DROP TABLE Silver.erp_loc_a101;
Create table Silver.erp_loc_a101(
cid NVARCHAR(50),
Country NVARCHAR(50),
dwh_Create_date Date Default getdate()
);


IF OBJECT_ID('Silver.erp_cust_az12','U') IS NOT NULL
DROP TABLE Silver.erp_cust_az12;
Create table Silver.erp_cust_az12(
Cid NVARCHAR(50),
bdate date,
gen NVARCHAR(50),
dwh_Create_date Date Default getdate()
);


IF OBJECT_ID('Silver.erp_px_cat_g1v1','U') IS NOT NULL
DROP TABLE Silver.erp_px_cat_g1v1;
Create table Silver.erp_px_cat_g1v1(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
Maintainance NVARCHAR(50),
dwh_Create_date Date Default getdate()
);

