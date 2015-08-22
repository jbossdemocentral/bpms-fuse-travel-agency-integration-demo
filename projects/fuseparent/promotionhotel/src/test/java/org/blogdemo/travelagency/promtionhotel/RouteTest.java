package org.blogdemo.travelagency.promtionhotel;

import javax.jms.ConnectionFactory;
import static org.apache.camel.component.jms.JmsComponent.jmsComponentAutoAcknowledge;


import org.apache.camel.CamelContext;
import org.apache.camel.test.blueprint.CamelBlueprintTestSupport;
import org.junit.Test;

public class RouteTest extends CamelBlueprintTestSupport {
	
	 protected String componentName = "activemq";
	
    @Override
    protected String getBlueprintDescriptor() {
        return "/OSGI-INF/blueprint/blueprint.xml";
    }
    
    protected CamelContext createCamelContext() throws Exception {
        CamelContext camelContext = super.createCamelContext();

        ConnectionFactory connectionFactory = CamelJmsTestHelper.createConnectionFactory();
        camelContext.addComponent(componentName, jmsComponentAutoAcknowledge(connectionFactory));

        return camelContext;
    }

    @Test
    public void testRoute() throws Exception {
    	String out = template.requestBody("activemq:queue:requestHotel", "{\"startCity\":\"London\",\"startDate\":\"2015-01-01\",\"endDate\":\"2015-03-01\"}", String.class);
    	
    	assertEquals("{\"hotelId\":201,\"hotelName\":\"The Grand Default Hotel\",\"ratePerPerson\":109.99,\"hotelCity\":null,\"availableFrom\":\"2015-01-01\",\"availableTo\":\"2015-03-01\"}", out);
    	
    }

}
