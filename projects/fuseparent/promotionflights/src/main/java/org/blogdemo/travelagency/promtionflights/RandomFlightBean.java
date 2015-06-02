package org.blogdemo.travelagency.promtionflights;

import java.math.BigDecimal;
import java.util.List;
import java.util.Random;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;



public class RandomFlightBean implements Processor{


	@Override
	public void process(Exchange exchange) throws Exception {
		List<FlightInfo> flights = (List<FlightInfo>)exchange.getIn().getBody();
		System.out.println("flights =>"+flights);
		FlightInfo flight;
		if(flights == null || flights.size() == 0){
			flight = new FlightInfo();
			flight.setFlightid(200001);
			flight.setAirline("The Grand Default Airline");
			flight.setDeparture((String)exchange.getIn().getHeader("requestDeparture"));
			flight.setDestination((String)exchange.getIn().getHeader("requestDestination"));
			flight.setDeparturetime((String)exchange.getIn().getHeader("requestDepartureDate"));
			flight.setPrice(new BigDecimal("888.88"));
			flight.setArrivaltime((String)exchange.getIn().getHeader("requestArrivalDate"));
		}else{
		
			Random rand = new Random();
			int  n = rand.nextInt(flights.size());
			flight = flights.get(n);
		}
		
		exchange.getOut().setBody(flight);
		
	}
	

}
