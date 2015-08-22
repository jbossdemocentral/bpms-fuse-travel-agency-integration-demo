package org.blogdemo.travelagency.promtionflights;

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
    	String out = template.requestBody("activemq:queue:requestflight", "{\"startCity\":\"London\",\"endCity\":\"Taipei\",\"startDate\":\"2015-01-01\",\"endDate\":\"2015-03-01\"}", String.class);
    	
    	assertEquals("{\"flightid\":1007,\"airline\":\"Eva Air\",\"departure\":\"London\",\"destination\":\"Taipei\",\"departuretime\":\"2015-05-20 21:20:00.0\",\"arrivaltime\":\"2015-05-21 17:15:00.0\",\"flightclass\":\"E\",\"price\":900.00}", out);
    	
    }

}
