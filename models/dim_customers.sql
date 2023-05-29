{{ config(
    materialized='table'
)}}


WITH customers AS (
    SELECT id as customer_id, first_name, last_name
    FROM dbt_demo.my_schema.customers
),
orders AS (
    SELECT id as order_id, user_id as customer_id, order_date, status, elt_loaded_at
    FROM dbt_demo.my_schema.orders
),
customer_orders AS (
    SELECT customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as number_of_orders
    FROM orders GROUP BY 1
),
FINAL AS (
    SELECT customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as                     number_of_orders
    FROM customers
    LEFT JOIN customer_orders using (customer_id)
)
SELECT * FROM FINAL