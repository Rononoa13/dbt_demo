WITH orders AS (
    SELECT id as order_id, user_id as customer_id, order_date, status, elt_loaded_at
    FROM dbt_demo.my_schema.orders
)

SELECT * 
FROM orders