with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

enriched as (
    select
        -- order attributes
        o.order_id,
        o.order_date,
        o.status,
        o.amount,
        o.completed_amount,

        -- customer attributes
        o.customer_id,
        c.full_name      as customer_name,
        c.email          as customer_email,
        c.country        as customer_country,

        -- product attributes
        o.product_id,
        p.product_name,
        p.category       as product_category,
        p.price          as product_price

    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join products  p on o.product_id  = p.product_id
)

select * from enriched