package org.blogdemo.travelagency.hotelbookingservice;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cancelhotelbooking")
public class CancelBooking {
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
