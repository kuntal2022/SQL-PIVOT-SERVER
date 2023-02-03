with tx as (

select * from 
(select cust_id, format(sales_date, 'MMM-yy') as sales_date,
cast(replace(amount, '$', '') as int) as amount from prac
) as t1
pivot
(
sum(amount) for sales_date in ([jan-01], [jan-22], [feb-22],
[march-22], 
[april-22], 
[may-22], 
[june-22], 
[jul-22], 
[aug-22], 
[sep-22], 
[oct-22], 
[nov-22], 
[dec-22])     ) as t2

union

select * from 
(select 'Total' as customer , format(sales_date, 'MMM-yy') as sales_date,
cast(replace(amount, '$', '') as int) as amount from prac
) as t3


pivot
(sum(amount) for sales_date in 
([jan-01], [jan-22], [feb-22],
[march-22], [april-22], [may-22], 
[june-22], [jul-22], [aug-22], 
[sep-22], [oct-22], [nov-22], [dec-22]) 



) as t2),

 tn as (select cust_id,
coalesce([jan-01], 0) as [jan-01],
coalesce([jan-22], 0) as [jan-22],
coalesce([feb-22], 0) as [feb-22],
coalesce([march-22], 0) as [march-22],
coalesce([april-22], 0) as [april-22],
coalesce([may-22], 0) as [may-22],
coalesce([june-22], 0) as [june-22],
coalesce([jul-22], 0) as [jul-22],
coalesce([aug-22], 0) as [aug-22],
coalesce([sep-22], 0) as [sep-22],
coalesce([oct-22], 0) as [oct-22],
coalesce([nov-22], 0) as [nov-22],
coalesce([dec-22] , 0) as [dec-22]
from tx)

select * from tn



