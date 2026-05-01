{{ config(materialized='table') }}

with sales as (
    select * from {{ ref('fct_sales') }}
),

aggregated as (
    select
        date_trunc('month', order_date)  as sale_month,
        customer_country,
        product_category,
        count(distinct order_id)         as order_count,
        count(distinct customer_id)      as unique_customers,
        sum(completed_amount)            as total_revenue,
        avg(completed_amount)            as avg_order_value
    from sales
    where status = 'completed'
    group by 1, 2, 3
)

select * from aggregated