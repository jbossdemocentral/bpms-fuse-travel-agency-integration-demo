package org.blogdemo.travelagency.hotelwsendpoint;

import java.util.Map;

import acme.service.soap.hotelws.Resort;

public class ListHotelBean {
	
	public Resort getResort(Map<String, Object> promotedResorts){
		Resort resort = new Resort();
		resort.setHotelId((Integer)promotedResorts.get("hotelId"));
		resort.setHotelName((String)promotedResorts.get("hotelName"));
		resort.setHotelCity((String)promotedResorts.get("hotelCity"));
		resort.setAvailableFrom((String)promotedResorts.get("availableFrom"));
		resort.setAvailableTo((String)promotedResorts.get("availableTo"));
		resort.setRatePerPerson(((Double)promotedResorts.get("ratePerPerson")));
		
		return resort;
	}
	
	

}
