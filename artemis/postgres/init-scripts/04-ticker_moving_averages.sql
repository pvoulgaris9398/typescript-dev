create or replace view :"schema_name".view_ticker_moving_averages AS
select 
    pd.id as [id]
    pd.profile_id as [profile_id],
    pd.ticker as [ticker],
    pd.price as [price],
    pd.volume as [volume],
    pd.timestamp as [timestamp],
    avg(pd.price) over(
        partition by profile_id, ticker 
        order by timestamp 
        range between interval '20 days' preceding and current row
    ) as [moving_average_20_day]
from price_data pd
