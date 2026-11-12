SELECT 
    r.sales_id,
    d.date, 
    s.store_name,
    s.city,
    s.country,
    p.product_code,
    p.product_name,
    p.department,
    p.category,
    r.returned_qty AS quantity,
    r.return_reason AS reason,
    r.refund_amount
FROM 
    {{ ref('bronze_returns') }} AS r
LEFT JOIN 
    {{ ref('bronze_store') }} AS s
    ON r.store_sk = s.store_sk
LEFT JOIN 
    {{ ref('bronze_date') }} AS d 
    ON r.date_sk = d.date_sk
LEFT JOIN 
    {{ ref('bronze_product') }} AS p
    ON r.product_sk = p.product_sk