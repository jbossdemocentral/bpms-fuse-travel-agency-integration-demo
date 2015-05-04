package org.blogdemo.travelagency.promotionhotel;

import java.math.BigDecimal;
import java.util.List;
import java.util.Random;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class RandomHotelBean implements Processor{

	@Override
	public void process(Exchange exchange) throws Exception {
		List<ResortInfo> resorts = (List<ResortInfo>)exchange.getIn().getBody();
		System.out.println("resorts =>"+resorts);
		
		ResortInfo resort;
		
		if(resorts == null || resorts.size() == 0){
			resort = new ResortInfo();
			resort.setHotelId(201);
			resort.setHotelName("The Grand Default Hotel");
			resort.setHotelCity((String)exchange.getIn().getHeader("requestCity"));
			resort.setAvailableFrom((String)exchange.getIn().getHeader("requestStartDate"));
			resort.setAvailableTo((String)exchange.getIn().getHeader("requestEndDate"));
			resort.setRatePerPerson(new BigDecimal("109.99"));
		}else{
		
			Random rand = new Random();
			int  n = rand.nextInt(resorts.size());
			resort = resorts.get(n);
		}
		exchange.getOut().setBody(resort);
	}
	
}
