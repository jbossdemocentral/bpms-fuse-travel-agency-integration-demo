drop table avaliablehotels;

Create table avaliablehotels(
hotelid int not null,
hotelname varchar(255) not null,
hotelcity varchar(255) not null,
availableFrom timestamp  not null,
availableTo timestamp  not null,
ratePerPerson DECIMAL(20, 2) not null
);

Insert into avaliablehotels VALUES (101,'The Hide London','London','2015-1-1 00:00:00','2015-12-31 00:00:00',140.00);
Insert into avaliablehotels VALUES (102,'Premier Inn London Edmonton','London','2015-1-1 00:00:00','2015-12-31 00:00:00',150.00);
Insert into avaliablehotels VALUES (103,'Travelodge London Wembley High Road','London','2015-1-1 00:00:00','2015-12-31 00:00:00',160.00);
Insert into avaliablehotels VALUES (104,'The Prescott Hotel','San Fransico','2015-1-1 00:00:00','2015-12-31 00:00:00',209.00);
Insert into avaliablehotels VALUES (105,'Old Mill Toronto','Toronto','2015-1-1 00:00:00','2015-12-31 00:00:00',235.00);
Insert into avaliablehotels VALUES (106,'The St. Regis Washington','Washinton','2015-1-1 00:00:00','2015-12-31 00:00:00',150.00);
Insert into avaliablehotels VALUES (107,'W TAIPEI','Taipei','2015-1-1 00:00:00','2015-12-31 00:00:00',120.00);
Insert into avaliablehotels VALUES (108,'Grand Pacific Le Daiba','Tokyo','2015-1-1 00:00:00','2015-12-31 00:00:00',350.00);


select * from avaliablehotels;


create table hotelbooking(
 bookingid varchar(255) not null,
 recieveDate timestamp  not null
);

select * from hotelbooking;

create table cancelhotelbooking(
 bookingid varchar(255) not null,
 recieveDate timestamp  not null
);

select * from cancelhotelbooking;