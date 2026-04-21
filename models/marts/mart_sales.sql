with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

final as (
    select
        o.order_id,
        o.order_date,
        o.status,
        o.amount,
        o.completed_amount,
        c.full_name as customer_name,
        c.country,
        c.email
    from orders o
    left join customers c on o.customer_id = c.customer_id
)

select * from final