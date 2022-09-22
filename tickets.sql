select * from tickets
select * from holidays

/*
SELECT ticket_id ,
DATEDIFF(day,create_date,resolved_date) as Number_days ,
--DATENAME(DW,create_date)   create_date_week_name,
--DATENAME(DW,resolved_date) reolved_date_week_name,
DATEPART(week,create_date)   created_date_week_number,
DATEPART(week,resolved_date) resolved_date_week_number,
DATEDIFF(DAY,DATEPART(week,create_date) , DATEPART(week,resolved_date)),
DATEDIFF(day,create_date,resolved_date) - 2 * DATEDIFF(DAY,DATEPART(week,create_date) , DATEPART(week,resolved_date))
FROM tickets
*/


	/*SELECT ticket_id ,create_date,resolved_date,count(h.holiday_date) as num_holidays,
	DATEDIFF(day,create_date,resolved_date) as Number_days ,
	DATEDIFF(day,create_date,resolved_date) - 2 * DATEDIFF(DAY,DATEPART(week,create_date) , DATEPART(week,resolved_date))  as number_businessDays
	FROM tickets t left join holidays h
    on h.holiday_date between t.create_date and t.resolved_date*/

	SELECT ticket_id ,
	       a.create_date,
		   resolved_date,
		   DATEDIFF(day,create_date,resolved_date) as Number_days,
		   DATEDIFF(day,create_date,resolved_date) - 
		   2 * DATEDIFF(DAY,DATEPART(week,create_date) , DATEPART(week,resolved_date))  - number_holidays
		   as number_businessDays
    FROM(
	select count(h.holiday_date) number_holidays , t.ticket_id , create_date , resolved_date from tickets t left outer join holidays h
	on h.holiday_date between t.create_date and t.resolved_date group by t.ticket_id , create_date , resolved_date) as a

