select
	sum(bo.totalprice) as totalsales, 
	count(bo.bookingid) as numberofbookings, 
	bo.bookingstatus,
	proc.status
from
			test.public.bookingobject bo 
	left join	(select  
				count(*) as numberofbookings,  
				p.status,  
				p.processinstanceid
			from 
						test.public.processinstancelog p
				left join	test.public.bookingobject b 
				on (b.bookingid = p.processinstanceid or b.bookingid = p.parentprocessinstanceid)
			where
				{sql_condition, optional, p.processname, processname} and
        			{sql_condition, optional, p.user_identity, userid} and
        			{sql_condition, optional, p.start_date, start_date} and
        			{sql_condition, optional, p.end_date, end_date} and
        			{sql_condition, optional, p.processversion, processversion} and
        			{sql_condition, optional, p.duration, duration} and
        			{sql_condition, optional, p.status, status} and
        			{sql_condition, optional, b.bookingid, bookingid}
				
		group by p.duration, p.start_date, p.end_date, p.user_identity, p.processname, p.status, p.processinstanceid, b.bookingid) as proc
where
	bo.bookingid = proc.processinstanceid
group by
	bo.bookingstatus
