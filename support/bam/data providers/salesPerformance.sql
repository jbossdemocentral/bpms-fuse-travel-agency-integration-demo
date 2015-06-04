select
	sum(sales.totalsales) as totSales,
	sum(costs.totalcosts) as totCosts,
	sum(sales.totalsales - costs.totalcosts) as margin, 
	sales.bookingstatus
from
	(select
		sum(b.totalprice) as totalsales, 
		count(b.bookingid) as numberofsales, 
		b.bookingstatus,
		b.bookingid,
		f.company,
        	h.location,
        	h.hotelname, 
        	t.fromdestination,
        	t.todestination,
        	b.bookingConfirmed,
        	a.name
	from		
				test.public.bookingobject b
		left join	test.public.applicant a
		on		b.applicant_appid=a.appid
		left join	test.public.flight f
		on		b.availableflights_fid=f.fid
		left join	test.public.hotel h
		on		b.availablehotels_hid=h.hid
		left join	test.public.traveldetails t
		on 		b.traveldetails_tdid=t.tdid
	where
                 b.bookingstatus='SUCCESS' and
		{sql_condition, optional, f.company, company} and
        	{sql_condition, optional, h.location, location} and
        	{sql_condition, optional, h.hotelname, hotelname} and
        	{sql_condition, optional, t.fromdestination, fromdestination} and
        	{sql_condition, optional, t.todestination, todestination} and
        	{sql_condition, optional, b.bookingConfirmed, bookingConfirmed} and
        	{sql_condition, optional, a.name, name} and
        	{sql_condition, optional, b.bookingstatus, bookingstatus}
	group by
		b.bookingstatus, 
		b.bookingid,
		f.company,
        	h.location,
        	h.hotelname, 
        	t.fromdestination,
        	t.todestination,
        	b.bookingConfirmed,
        	a.name) as sales,
	
	
	(select
		sum(((a.numberoftravelers * f.rateperperson) + (h.roomprice))*0.65) as totalcosts, 
		count(b.bookingid), 
		b.bookingstatus,
		b.bookingid,
		f.company,
        	h.location,
        	h.hotelname, 
        	t.fromdestination,
        	t.todestination,
        	b.bookingConfirmed,
        	a.name
	from
				test.public.bookingobject b
		left join	test.public.applicant a
		on		b.applicant_appid=a.appid
		left join	test.public.flight f
		on		b.availableflights_fid=f.fid
		left join 	test.public.hotel h
		on		b.availablehotels_hid=h.hid
		left join	test.public.traveldetails t
		on 		b.traveldetails_tdid=t.tdid
	where
                b.bookingstatus='SUCCESS' and
		{sql_condition, optional, f.company, company} and
        	{sql_condition, optional, h.location, location} and
        	{sql_condition, optional, h.hotelname, hotelname} and
        	{sql_condition, optional, t.fromdestination, fromdestination} and
        	{sql_condition, optional, t.todestination, todestination} and
        	{sql_condition, optional, b.bookingConfirmed, bookingConfirmed} and
        	{sql_condition, optional, a.name, name} and
        	{sql_condition, optional, b.bookingstatus, bookingstatus}
	group by
		b.bookingstatus, 
		b.bookingid,
		f.company,
        	h.location,
        	h.hotelname, 
        	t.fromdestination,
        	t.todestination,
        	b.bookingConfirmed,
        	a.name) as costs
where
	sales.bookingid = costs.bookingid
group by
	sales.bookingstatus
