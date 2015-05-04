package org.blogdemo.travelagency.promotionhotel;

import java.io.Serializable;
import java.math.BigDecimal;

public class ResortInfo implements Serializable{

	private static final long serialVersionUID = 6313854994010205L;
	
	int hotelId;
    String hotelName;
    BigDecimal ratePerPerson;
    String hotelCity;
    String availableFrom;
    String availableTo;
	public int getHotelId() {
		return hotelId;
	}
	public void setHotelId(int hotelId) {
		this.hotelId = hotelId;
	}
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	public BigDecimal getRatePerPerson() {
		return ratePerPerson;
	}
	public void setRatePerPerson(BigDecimal ratePerPerson) {
		this.ratePerPerson = ratePerPerson;
	}
	public String getHotelCity() {
		return hotelCity;
	}
	public void setHotelCity(String hotelCity) {
		this.hotelCity = hotelCity;
	}
	public String getAvailableFrom() {
		return availableFrom;
	}
	public void setAvailableFrom(String availableFrom) {
		this.availableFrom = availableFrom;
	}
	public String getAvailableTo() {
		return availableTo;
	}
	public void setAvailableTo(String availableTo) {
		this.availableTo = availableTo;
	}
    
    
    
}
