WITH customers AS (
    SELECT id as customer_id, first_name, last_name
    FROM dbt_demo.my_schema.customers
)

SELECT * 
FROM customers