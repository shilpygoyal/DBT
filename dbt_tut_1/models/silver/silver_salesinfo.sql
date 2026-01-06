WITH bronze_sales as(
    SELECT 
        sales_id,
        product_sk,
        customer_sk,
        quantity,
        gross_amount,
        payment_method,
        {{ multiply('unit_price','quantity')}} as calc_gross_amount
    FROM
        {{ref("bronze_sales")}}
),
bronze_products as (
    SELECT 
        product_sk,
        category
    FROM
        {{ref("bronze_product")}}
),
bronze_customer as (
    SELECT
        customer_sk,
        gender
    FROM
        {{ref("bronze_customers")}}
),
joined_query as (
SELECT 
    bronze_sales.sales_id,
    bronze_sales.gross_amount,
    bronze_sales.payment_method,
    bronze_products.category,
    bronze_customer.gender
FROM 
    bronze_sales
JOIN
    bronze_products ON bronze_sales.product_sk=bronze_products.product_sk
JOIN bronze_customer ON bronze_sales.customer_sk=bronze_customer.customer_sk
)

SELECT 
    category,
    gender,
    round(sum(gross_amount),2) as total_sales
FROM
    joined_query
GROUP BY 
    category,
    gender
ORDER BY total_sales DESC