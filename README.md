JBoss BPM Suite & JBoss Fuse Travel Agency Integration Demo
===========================================================
Demo based on JBoss BPM Suite and JBoss Fuse products to highlight migration to micro-services.


Install on your machine
-----------------------
1. [Download and unzip.](https://github.com/jbossdemocentral/brms-fuse-integration-demo/archive/master.zip). If running on Windows(No FUSE), it is recommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.

2. Add products to installs directory.

3. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

4. Start the JBoss BPM Suite server, login, build and deploy JBoss BPM Suite process project at http://localhost:8080/business-central (u:erics/p:bpmsuite1!).

5. Add fabric server passwords for Maven Plugin to your ~/.m2/settings.xml file the fabric server's user and password so that the maven plugin can login to the fabric.

     ```
     <!-- Server login to upload to fabric. -->
     <servers>
         <server>
             <id>fabric8.upload.repo</id>
             <username>admin</username>
             <password>admin</password>
         </server>
     </servers> 
     ```

6. Start Fuse Server, by running 'fuse' or 'fuse.bat': 

7. Login to Fuse management console at:  http://localhost:8181    (u:admin/p:admin).

8. Under Runtime tab, you will see 6 containers, select and start them all.  
![Fuse Under Runtime](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse01-underruntime.png?raw=true)

9. Check if web services are avaiable under APIs tab.
![Fuse WS APIs](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse02-underapis.png?raw=true)

10. Enjoy the demo!


Supporting Articles
-------------------
None yet...


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - JBoss BPM Suite 6.1 and JBoss Fuse 6.1 running travel agency demo with micro-services.


![Agency Process](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/demo-images/agency-process.png?raw=true)

![Calculate Process](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/demo-images/calculate-process.png?raw=true)

![Compensation](https://raw.githubusercontent.com/eschabell/bpms-fuse-travel-agency-integration-demo/master/docs/demo-images/compensation-process.png?raw=true)

![Special Trips UI Form](https://raw.githubusercontent.com/eschabell/bpms-fuse-travel-agency-integration-demo/master/docs/demo-images/SpecialTripsUIform.png)

![Started Process](https://raw.githubusercontent.com/eschabell/bpms-fuse-travel-agency-integration-demo/master/docs/demo-images/started-process.png?raw=true)

![BPM Suite BAM](https://raw.githubusercontent.com/eschabell/bpms-fuse-travel-agency-integration-demo/master/docs/demo-images/mock-bpm-data.png?raw=true)

![Fuse Under MQ Tab](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse03-unsermq.png?raw=true)

![Fuse Message Broker Statistics](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse04-msgbroker.png?raw=true)

![Fuse Booking Route](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse05-bookingroute.png?raw=true)

![Fuse Cancel Booking Route](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse06-cancelbookingroute.png?raw=true)

![Fuse Promotion FLight Route](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse07-promotionflightroute.png?raw=true)

![Fuse Web Service Route](https://github.com/eschabell/bpms-fuse-travel-agency-integration-demo/blob/master/docs/fuse-images/fuse08-wsroute.png?raw=true)