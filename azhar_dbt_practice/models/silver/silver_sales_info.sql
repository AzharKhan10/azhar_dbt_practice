WITH sales AS 
(
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} AS gross_amount,
        payment_method
    FROM
        {{ ref('bronze_sales') }}
),

product AS 
(
    SELECT
        product_sk,
        product_name,
        department,
        category,
        uom
    FROM 
        {{ ref('bronze_product') }}
),

customer AS 
(
    SELECT 
        customer_sk,
        {{ full_name('first_name', 'last_name') }} AS customer_name,
        loyalty_tier
    FROM 
        {{ ref('bronze_customer') }}
)

SELECT 
    s.sales_id,
    c.customer_name,
    p.product_name,
    p.department,
    p.category,
    p.uom,
    s.gross_amount,
    s.payment_method,
    c.loyalty_tier 
FROM 
    sales AS s 
INNER JOIN customer AS c ON s.customer_sk = c.customer_sk
INNER JOIN product  AS p ON s.product_sk  = p.product_sk

