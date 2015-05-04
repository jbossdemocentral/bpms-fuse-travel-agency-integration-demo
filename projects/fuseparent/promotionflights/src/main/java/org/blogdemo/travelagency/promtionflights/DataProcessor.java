package org.blogdemo.travelagency.promtionflights;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataProcessor {

	
	/**
	 * Will be a lot easier in Fuse 6.2 with Camel 2.15 
	 * */
	public List<FlightInfo> processResultSet(List<Map<String, Object>> resultset){
		List<FlightInfo> avaliableFlights = new ArrayList<FlightInfo>();
		System.out.println("resultset:["+resultset.size()+"]");
		for(Map<String, Object> obj:resultset){
			FlightInfo flightInfo = new FlightInfo();
			flightInfo.setFlightid((Integer)obj.get("FLIGHTID"));
			flightInfo.setDeparture((String)obj.get("DEPARTURE"));
			flightInfo.setDestination((String)obj.get("DESTINATION"));
			flightInfo.setDeparturetime(obj.get("DEPARTURETIME").toString());
			flightInfo.setArrivaltime(obj.get("ARRIVALTIME").toString());
			flightInfo.setPrice((BigDecimal)obj.get("PRICE"));
			flightInfo.setAirline((String)obj.get("AIRLINE"));
			flightInfo.setFlightclass((String)obj.get("FLIGHTCLASS"));
			avaliableFlights.add(flightInfo);
		}
		
		System.out.println("avaliableFlights:["+avaliableFlights.size()+"]");
		return avaliableFlights;
	}
	
	public HashMap<String,String> checkup(HashMap<String,String> input){
		
		System.out.println("input:["+input+"]");
		System.out.println("startcity:["+input.get("startcity")+"]");
		System.out.println("endcity:["+input.get("endcity")+"]");
		return input;
	}
}
