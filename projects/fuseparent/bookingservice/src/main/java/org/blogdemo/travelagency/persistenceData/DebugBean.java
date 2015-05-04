package org.blogdemo.travelagency.persistenceData;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class DebugBean implements Processor{

	@Override
	public void process(Exchange exchange) throws Exception {
		//Object obj = exchange.getContext().getRegistry().lookupByName("entityManagerFactory");
		
		//Object objclass = exchange.getContext().getRegistry().lookupByName("javax.persistence.EntityManagerFactory");
		//LocalEntityManagerFactoryBean lemfb = (LocalEntityManagerFactoryBean) obj;
		//System.out.println("obj:["+lemfb+"]");
		//System.out.println("PersistenceUnitName:["+lemfb.getPersistenceUnitName()+"]");
		//System.out.println("PersistenceUnitInfo:["+lemfb.getPersistenceUnitInfo()+"]");
		//System.out.println("objclass:["+objclass+"]");	
	}

	public void processResult(List<Object> result){
		for(Object obj:result ){
			//FlightInfo flightInfo = (FlightInfo) obj;
			System.out.println("Value:["+obj+"]" );
			//System.out.println("flightInfo:["+flightInfo.getFlightid()+"] ["+flightInfo.getAirline()+"] ["+flightInfo.getDestination()+"]");
		}	
	}
	
	private Date getToday(){
		Calendar cal = Calendar.getInstance();	
		return cal.getTime();
	}
}
