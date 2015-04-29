JBoss BPM Suite & JBoss Fuse Travel Agency Integration Demo
===========================================================
Demo based on JBoss BPM Suite and JBoss Fuse products to highlight migration to micro-services.


Install on your machine
-----------------------
1. [Download and unzip.](https://github.com/jbossdemocentral/brms-fuse-integration-demo/archive/master.zip). If running on Windows, it is recommended the project be extracted to a location near the root drive path due to limitations of length of file/path names.

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

6. Start Fuse Server and start up fabric in fuse console: 

     ```
     fabric:create --wait-for-provisioning 
     ```

7. Deploy simple route from projects/brms-fuse-integration/simpleRoute:

     ```
     mvn fabric8:deploy
     ```

8. Login to Fuse management console at:  http://localhost:8181    (u:admin/p:admin).

9. Connect to root container with login presented by console  (u:admin/p:admin)   

10. Create container name c1 and add bpmsuitefuse profile (see screenshot below)

11. Trigger camel route by placing support/data/message.xml files into target/jboss-fuse-6.1.0.redhat-379/instances/c1/src/data folder (see screenshot below)

12. Enjoy the demo!


Supporting Articles
-------------------
None yet...


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - JBoss BPM Suite 6.1 and JBoss Fuse 6.1 running travel agency demo with micro-services.


![BPM Suite Process] (https://raw.githubusercontent.com/jbossdemocentral/brms-fuse-integration-demo/master/docs/demo-images/customer-evaluation.png)
![BPM Suite BAM] (https://raw.githubusercontent.com/jbossdemocentral/brms-fuse-integration-demo/master/docs/demo-images/bam-dashboard.png)
