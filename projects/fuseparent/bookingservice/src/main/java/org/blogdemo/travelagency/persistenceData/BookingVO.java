package org.blogdemo.travelagency.persistenceData;

import static javax.persistence.LockModeType.PESSIMISTIC_WRITE;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQuery(name = "queryById", query = "select booking from BookingVO booking where booking.bookingid=:bookingid " , lockMode = PESSIMISTIC_WRITE)
@Table(name = "booking")
public class BookingVO {
	
	@Column(name = "bookingid")
	@Id
	protected String bookingid;
	
	@Column(name = "recieveDate")
	protected Date recieveDate;

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
