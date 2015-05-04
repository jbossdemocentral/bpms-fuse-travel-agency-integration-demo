package org.blogdemo.travelagency.promtionflights;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class FlightInfo implements Serializable {

	private static final long serialVersionUID = 7868156868993544851L;

	
	private int flightid;
	private String airline;
	private String departure;
	private String destination;
	private String departuretime;
	private String arrivaltime;
	private String flightclass;
	private BigDecimal price;

	public int getFlightid() {
		return flightid;
	}

	public void setFlightid(int flightid) {
		this.flightid = flightid;
	}

	public String getAirline() {
		return airline;
	}

	public void setAirline(String airline) {
		this.airline = airline;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getDeparturetime() {
		return departuretime;
	}

	public void setDeparturetime(String departuretime) {
		this.departuretime = departuretime;
	}

	public String getArrivaltime() {
		return arrivaltime;
	}

	public void setArrivaltime(String arrivaltime) {
		this.arrivaltime = arrivaltime;
	}

	public String getFlightclass() {
		return flightclass;
	}

	public void setFlightclass(String flightclass) {
		this.flightclass = flightclass;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
}
