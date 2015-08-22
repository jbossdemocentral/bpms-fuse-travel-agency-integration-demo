package org.blogdemo.travelagency.persistenceData;

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
    public void testBooking() throws Exception {
    	String out = template.requestBody("activemq:queue:booking", "12345", String.class);
    	System.out.println(out);
    	assertTrue(out.length()==26);    	
    }
    
    @Test
    public void testSuccessfulCancelBooking() throws Exception {
    	String bookingId = template.requestBody("activemq:queue:booking", "12345", String.class);
    	Integer out = template.requestBody("activemq:queue:cancelbooking", bookingId, Integer.class);
    	assertTrue(out > 0);    	
    }

    @Test
    public void testProblemCancelBooking() throws Exception {
    	Integer out = template.requestBody("activemq:queue:cancelbooking", "12345", Integer.class);
    	assertTrue(out==0);    	
    }
}
