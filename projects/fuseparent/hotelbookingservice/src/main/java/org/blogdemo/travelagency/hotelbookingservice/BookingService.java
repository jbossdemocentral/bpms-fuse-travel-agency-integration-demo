package org.blogdemo.travelagency.hotelbookingservice;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.Random;

public class BookingService {
	
	private SecureRandom secureRandom = new SecureRandom();

	public Booking createBooking(String someStringFromBPMS){
		Calendar cal = Calendar.getInstance();
		
		Booking booking = new Booking();
		booking.setBookingid(genBookingId());
		booking.setRecieveDate(cal.getTime());
		
		return booking;
	}
	
	public CancelBooking createCancelBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		CancelBooking cancelbooking = new CancelBooking();
		cancelbooking.setBookingid(id);
		cancelbooking.setRecieveDate(cal.getTime());
		
		return cancelbooking;
	}
	
	private String genBookingId(){
		
		return new BigInteger(130, secureRandom).toString(32);
		
	}
	
	public int cancelCharge(){
		
		final Random random = new Random();
		return random.nextInt((10-5)+1) + 5;
		
	}
}
