package org.blogdemo.travelagency.promotionhotel;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ResortDataConvertor {

	/**
	 * Will be a lot easier in Fuse 6.2 with Camel 2.15 
	 * */
	public List<ResortInfo> processResultSet(List<Map<String, Object>> resultset){
		List<ResortInfo> avaliableResorts = new ArrayList<ResortInfo>();
		System.out.println("resultset:["+resultset.size()+"]");
		for(Map<String, Object> obj:resultset){
			
			ResortInfo resortInfo = new ResortInfo();
			resortInfo.setHotelId((Integer)obj.get("HOTELID"));
			resortInfo.setHotelName((String)obj.get("HOTELNAME"));
			resortInfo.setHotelCity((String)obj.get("HOTELCITY"));
			resortInfo.setAvailableFrom(new SimpleDateFormat("MM-dd-yyyy HH:mm:ss").format(obj.get("AVAILABLEFROM")));
			resortInfo.setAvailableTo(new SimpleDateFormat("MM-dd-yyyy HH:mm:ss").format(obj.get("AVAILABLETO")));
			resortInfo.setRatePerPerson((BigDecimal)obj.get("RATEPERPERSON"));
			
			avaliableResorts.add(resortInfo);
		}
		
		System.out.println("avaliableFlights:["+avaliableResorts.size()+"]");
		return avaliableResorts;
	}
	
	
	
}
