select 
	sum(b.totalprice) as totalsales, 
	sum(a.numberoftravelers) as totaltravelers,
	count(b.availableflights_fid) totalflights,
	count(b.availablehotels_hid) totalhotels,
	b.bookingstatus,
	t.fromdestination, 
	t.todestination
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
	t.fromdestination, t.todestination, b.bookingstatus
