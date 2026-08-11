--Business Expansion
select month(record_date) month,
  max(case when data_type = 'max' then data_value end) monthly_maximum,
  min(case when data_type = 'min' then data_value end) monthly_minimum,
  round(avg(case when data_type = 'avg' then data_value end)) monthly_average
from temperature_records
group by month(record_date);

--Customer Spending
select c.customer_name,
cast(round(sum(i.total_price),6) as 
decimal(20,6)) amount_spent
from customer c
join invoice i
on c.id = i.customer_id
group by c.id, c.customer_name
having sum(i.total_price) <= (
  select avg(total_price) * 0.25
  from invoice
)
order by amount_spent desc;
