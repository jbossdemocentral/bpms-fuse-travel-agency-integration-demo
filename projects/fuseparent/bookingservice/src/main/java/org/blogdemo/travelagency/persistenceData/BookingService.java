package org.blogdemo.travelagency.persistenceData;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class BookingService {
	private SecureRandom secureRandom = new SecureRandom();


	public BookingVO createBooking(String someStringFromBPMS){
		Calendar cal = Calendar.getInstance();
		
		BookingVO booking = new BookingVO();
		booking.setBookingid(genBookingId());
		booking.setRecieveDate(cal.getTime());
		
		return booking;
	}
	
	public Map<String, Object> setBookingIdParam(String id){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bookingid", id);
		
		return param;
	}
	
	public CancelBookingVO createCancelBooking(String id){
		Calendar cal = Calendar.getInstance();
		
		CancelBookingVO cancelbooking = new CancelBookingVO();
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
