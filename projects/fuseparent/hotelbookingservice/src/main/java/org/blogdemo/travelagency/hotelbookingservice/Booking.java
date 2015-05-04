package org.blogdemo.travelagency.hotelbookingservice;

import static javax.persistence.LockModeType.PESSIMISTIC_WRITE;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQuery(name = "queryHotelBookingById", query = "select hotelbooking from Booking hotelbooking where hotelbooking.bookingid=:bookingid " , lockMode = PESSIMISTIC_WRITE)
@Table(name = "hotelbooking")
public class Booking {
	
	@Column(name = "bookingid")
	@Id
	String bookingid;
	
	@Column(name = "recieveDate")
	Date recieveDate;

	public String getBookingid() {
		return bookingid;
	}

	public void setBookingid(String bookingid) {
		this.bookingid = bookingid;
	}

	public Date getRecieveDate() {
		return recieveDate;
	}

	public void setRecieveDate(Date recieveDate) {
		this.recieveDate = recieveDate;
	}

}