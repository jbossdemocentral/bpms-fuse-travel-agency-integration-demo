package org.blogdemo.travelagency;

import java.math.BigDecimal;
import java.util.Map;

import com.jboss.soap.service.acmedemo.Flight;

public class ListFlightBean {
	 
	
	public Flight getFlights(Map<String, Object> promotedflight){
		Flight flightFound = new Flight();
		
		flightFound.setPlaneId((Integer)promotedflight.get("flightid"));
		flightFound.setCompany((String)promotedflight.get("airline"));
		flightFound.setRatePerPerson(BigDecimal.valueOf((Double)promotedflight.get("price")));
		flightFound.setStartCity((String)promotedflight.get("departure"));
		flightFound.setTargetCity((String)promotedflight.get("destination"));
		flightFound.setTravelDate((String)promotedflight.get("departuretime"));
		
		return flightFound;
	}

	
	
}
