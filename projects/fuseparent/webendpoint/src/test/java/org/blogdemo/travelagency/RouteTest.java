package org.blogdemo.travelagency;

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
    	String out = template.requestBody("direct://bookFlights", "123", String.class);
    	
    	assertEquals("123", out);
    	
    }

}
