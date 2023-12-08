use practice ;
--Top Months Ranked by the Number of Orders
select DATENAME(MONTH,order_date)as Month_,COUNT(Order_ID) as Order_Count  from sales_data group by  DATENAME(MONTH,order_date) order by  Order_Count DESC

--Descending Order of Monthly Orders, Grouped by Week Number
with week_number as (select *,
case when DAY(order_date)  between 1 and 7 then 'week1' 
      when  DAY(order_date) between 7 and 14 then 'week2'
		when DAY(order_date) between 14 and 21 then 'week3'
		  else 'week4' end as W_number
from Sales_Data
)

select DATEname(month,order_date) as Month_number,W_number,COUNT(order_id) as Total_number_of_Orders,
DENSE_RANK() over (partition by DATEname(month,order_date) order by COUNT(order_id) desc  ) as Rank_
from week_number group by w_number,DATEname(month,order_date)
order by Month_number asc ,Total_number_of_Orders desc

-- Top 10 products based upon Total amount of Sales

select top 10 product,round(sum(Quantity_Ordered*Price_Each),2) as Total_Sales 
from Sales_Data group by Product order by Total_Sales DESC

-- Top 10 products based upon number of Products sold
select top 10 product,COUNT(order_id) as Total_number_of_orders from Sales_Data group by product order by Total_number_of_orders desc

select DATEname(month,order_date) from Sales_Data

--In Which Hour of the Day Are Most Sales Occurring?
select top 10 datepart(HOUR,order_date) as order_Hour,COUNT(order_id) as No_of_orders 
from Sales_Data group by datepart(HOUR,order_date) order by No_of_orders desc

--Top cities based upon Number of Orders
select City, COUNT(order_id) as Number_of_orders from Sales_Data group by City order by Number_of_orders desc
--Top cities based upon Total_sales amount
select City, round(sum(Quantity_Ordered*Price_Each),2) as Total_Sales from Sales_Data group by City order by Total_Sales desc