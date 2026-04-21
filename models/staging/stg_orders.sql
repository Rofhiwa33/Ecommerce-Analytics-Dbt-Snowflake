with source as (
    select * from {{ source('raw', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        amount,
        case 
            when status = 'completed' then amount 
            else 0 
        end as completed_amount
    from source
)

select * from renamed