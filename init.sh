#!/bin/sh 
DEMO="JBoss BPM Suite & Fuse Travel Agency Integration Demo"
AUTHORS="Christina Lin, Eric D. Schabell"
PROJECT="git@github.com:jbossdemocentral/bpms-fuse-travel-agency-integration-demo.git"

#BPM env
JBOSS_HOME=./target/jboss-eap-6.4
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
SRC_DIR=./installs
PRJ_DIR=./projects
SUPPORT_DIR=./support
BPMS=jboss-bpmsuite-6.1.0.GA-installer.jar
EAP=jboss-eap-6.4.0-installer.jar
BPM_VERSION=6.1

#Fuse env 
DEMO_HOME=./target
FUSE_ZIP=jboss-fuse-full-6.2.0.redhat-133.zip
FUSE_HOME=$DEMO_HOME/jboss-fuse-6.2.0.redhat-133
FUSE_PROJECT=projects/fuseparent
FUSE_SERVER_CONF=$FUSE_HOME/etc
FUSE_SERVER_SYSTEM=$FUSE_HOME/system
FUSE_SERVER_BIN=$FUSE_HOME/bin
FUSE_VERSION=6.2.0



# wipe screen.
clear 

# add executeable in installs
chmod +x installs/*.zip

echo
echo "#####################################################################################"
echo "##                                                                                 ##"   
echo "##  Setting up the                                                                 ##"
echo "##                                                                                 ##"   
echo "##            ${DEMO}                ##"
echo "##                                                                                 ##"   
echo "##                                                                                 ##"   
echo "##        ####   ####    #   #    ###             ####  #  #   ###  ####           ##"
echo "##        #   #  #   #  # # # #  #         #      #     #  #  #     #              ##"
echo "##        ####   ####   #  #  #   ##      ###     ###   #  #   ##   ###            ##"
echo "##        #   #  #      #     #     #      #      #     #  #     #  #              ##"
echo "##        ####   #      #     #  ###              #     ####  ###   ####           ##"
echo "##                                                                                 ##"   
echo "##                                                                                 ##"   
echo "##  brought to you by,                                                             ##"   
echo "##                     ${AUTHORS}                             ##"
echo "##                                                                                 ##"   
echo "##  ${PROJECT}   ##"
echo "##                                                                                 ##"   
echo "#####################################################################################"
echo

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# Check mvn version must be in 3.1.1 to 3.2.4	
verone=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $1}')
vertwo=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $2}')
verthree=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $3}')     
     
if [[ $verone -eq 3 ]] && [[ $vertwo -eq 1 ]] && [[ $verthree -ge 1 ]]; then
		echo  Correct Maven version $verone.$vertwo.$verthree
		echo
elif [[ $verone -eq 3 ]] && [[ $vertwo -eq 2 ]] && [[ $verthree -le 4 ]]; then
		echo  Correct Maven version $verone.$vertwo.$verthree
		echo
else
		echo Please make sure you have Maven 3.1.1 - 3.2.4 installed in order to use fabric maven plugin.
		echo
		echo We are unable to run with current installed maven version: $verone.$vertwo.$verthree
		echo	
		exit
fi

# make some checks first before proceeding.	
if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
	echo Product sources are present...
	echo
else
	echo Need to download $EAP package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

if [ -r $SRC_DIR/$BPMS ] || [ -L $SRC_DIR/$BPMS ]; then
	echo Product sources BPM are present...
	echo
else
	echo Need to download $BPMS package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

if [[ -r $SRC_DIR/$FUSE_ZIP || -L $SRC_DIR/$FUSE_ZIP ]]; then
		echo Product sources FUSE are present...
		echo
else
		echo Need to download $FUSE_ZIP package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Remove JBoss product installation if exists.
if [ -x target ]; then
	echo "  - existing JBoss product installation detected..."
	echo
	echo "  - removing existing JBoss product installation..."
	echo
	rm -rf target
fi

# Run installers.
echo "JBoss EAP installer running now..."
echo
java -jar $SRC_DIR/$EAP $SUPPORT_DIR/installation-eap -variablefile $SUPPORT_DIR/installation-eap.variables

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during JBoss EAP installation!
	exit
fi

echo
echo "JBoss BPM Suite installer running now..."
echo
java -jar $SRC_DIR/$BPMS $SUPPORT_DIR/installation-bpms -variablefile $SUPPORT_DIR/installation-bpms.variables

if [ $? -ne 0 ]; then
	echo Error occurred during BPMS installation!
	exit
fi

echo "  - enabling demo accounts role setup in application-roles.properties file..."
echo
cp $SUPPORT_DIR/application-roles.properties $SERVER_CONF

echo "  - setting up demo projects..."
echo
cp -r $SUPPORT_DIR/bpm-suite-demo-niogit $SERVER_BIN/.niogit

echo "  - setting up web services..."
echo
mvn clean install -f $PRJ_DIR/pom.xml

# Not copying original web serivces as building new Fuse microservices instead.
#
#cp -r $PRJ_DIR/acme-demo-flight-service/target/acme-flight-service-1.0.war $SERVER_DIR
#cp -r $PRJ_DIR/acme-demo-hotel-service/target/acme-hotel-service-1.0.war $SERVER_DIR

echo
echo "  - adding acmeDataModel-1.0.jar to business-central.war/WEB-INF/lib"
echo
cp -r $PRJ_DIR/acme-data-model/target/acmeDataModel-1.0.jar $SERVER_DIR/business-central.war/WEB-INF/lib

echo "  - deploying external-client-ui-form-1.0.war to EAP deployments directory"
echo
cp -r $PRJ_DIR/external-client-ui-form/target/external-client-ui-form-1.0.war $SERVER_DIR/

echo "  - setting up standalone.xml configuration adjustments..."
echo
cp $SUPPORT_DIR/standalone.xml $SERVER_CONF

echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "  - setup email task notification users..."
echo
cp $SUPPORT_DIR/userinfo.properties $SERVER_DIR/business-central.war/WEB-INF/classes/

echo "  - updating the CustomWorkItemHandler.conf file to use the appropriate email server..."
echo
cp -f $SUPPORT_DIR/CustomWorkItemHandlers.conf $SERVER_DIR/business-central.war/WEB-INF/classes/META-INF

# Optional: uncomment this to install mock data for BPM Suite.
#
#echo - setting up mock bpm dashboard data...
#cp $SUPPORT_DIR/1000_jbpm_demo_h2.sql $SERVER_DIR/dashbuilder.war/WEB-INF/etc/sql
#echo



#Start Fuse installation
if [ -x target ]; then
  # Unzip the JBoss FUSE instance.
	echo
  echo Installing JBoss FUSE $FUSE_VERSION
  echo
  unzip -q -d target $SRC_DIR/$FUSE_ZIP
else
	echo
	echo Missing target directory, stopping installation.
	echo 
	exit
fi

#SETUP and INSTALL FUSE services
echo "  - enabling demo accounts logins in users.properties file..."
echo
cp $SUPPORT_DIR/fuse/users.properties $FUSE_SERVER_CONF



if [ -x ~/h2 ]; then
	rm -rf ~/h2/travelagency.mv.db
else
	mkdir ~/h2
fi

cp $SUPPORT_DIR/fuse/data/travelagency.mv.db ~/h2/


echo "  - making sure 'FUSE' for server is executable..."
echo
chmod u+x $FUSE_HOME/bin/start



echo "  - Start up Fuse in the background"
echo
sh $FUSE_SERVER_BIN/start



echo "  - Create Fabric in Fuse"
echo
sh $FUSE_SERVER_BIN/client -r 3 -d 10 -u admin -p admin 'fabric:create'
     
sleep 15

#===Test if the fabric is ready=====================================
echo Testing fabric,retry when not ready
while true; do
    if [ $(sh $FUSE_SERVER_BIN/client 'fabric:status'| grep "100%" | wc -l ) -ge 3 ]; then
        break
    fi
    sleep 2
done
#===================================================================

cd $FUSE_PROJECT     


echo "Start compile and deploy 3 travel agency camel demo project to fuse"
echo         
#mvn fabric8:deploy 
mvn clean install

cd ../.. 

#Creating profiles without using fabric maven plugin

#Create Flight Web Endpoint Porfile
echo "  - Create Flight Web Endpoint Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-webendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-webendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature webendpoint-service/0.0.0 demo-travelagency-webendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/webendpoint/1.0 demo-travelagency-webendpoint' &> /dev/null

#Create Hotel Web Endpoint Porfile
echo "  - Create Hotel Web Endpoint Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-hotelwsendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-hotelwsendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature webendpoint-service/0.0.0 demo-travelagency-hotelwsendpoint' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/hotelwsendpoint/1.0 demo-travelagency-hotelwsendpoint' &> /dev/null

#Create Flight Booking Service Porfile
echo "  - Create Flight Booking Service Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-bookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-bookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature booking-service/0.0.0 demo-travelagency-bookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/bookingservice/1.0 demo-travelagency-bookingservice' &> /dev/null

#Create Hotel Booking Service Porfile
echo "  - Create Hotel Booking Service Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-hotelbookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-hotelbookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature booking-service/0.0.0 demo-travelagency-hotelbookingservice' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/hotelbookingservice/1.0 demo-travelagency-hotelbookingservice' &> /dev/null

#Create Flight Promotion Service Porfile
echo "  - Create Flight Promotion Service Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-promotionflight' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-promotionflight' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature promotion-service/0.0.0 demo-travelagency-promotionflight' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle wrap:mvn:commons-dbcp/commons-dbcp/1.4 demo-travelagency-promotionflight' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/promotionflights/1.0 demo-travelagency-promotionflight' &> /dev/null


#Create Flight Hotel Service Porfile
echo "  - Create Flight Hotel Service Porfile"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-create --parents feature-camel --parents mq-client demo-travelagency-promotionhotel' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle wrap:mvn:commons-dbcp/commons-dbcp/1.4 demo-travelagency-promotionhotel' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --bundle mvn:org.blogdemo.travelagency/promotionhotel/1.0 demo-travelagency-promotionhotel' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --repository mvn:org.blogdemo.travelagency/features/1.0/xml/features demo-travelagency-promotionhotel' &> /dev/null
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'fabric:profile-edit --feature promotion-service/0.0.0 demo-travelagency-promotionhotel' &> /dev/null





#===Test if the fabric is ready=====================================
echo Testing profiles,retry when not ready
while true; do
    if [ $(sh $FUSE_SERVER_BIN/client 'profile-list'| grep "demo-travelagency" | wc -l ) -ge 6 ]; then
        break
    fi
    sleep 2
done
#===================================================================




echo "  - Create containers and add profiles for Flight web service endpoint"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-webendpoint root wsflightcon' &> /dev/null

echo "  - Create containers and add profiles for Hotel web service endpoint"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-hotelwsendpoint root wshotelcon' &> /dev/null

echo "  - Create containers and add profiles for flight booking service"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-bookingservice root bookingflightcon' &> /dev/null

echo "  - Create containers and add profiles for hotel booking service"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-hotelbookingservice root bookinhotelgcon' &> /dev/null

echo "  - Create containers and add profiles flight promotion"
echo
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-promotionflight root promoflightcon' &> /dev/null

echo "Create containers and add profiles hotel promotion"
echo
sh $FUSE_SERVER_BIN/client -r 2 -d 5 'container-create-child --profile demo-travelagency-promotionhotel root promohotelcon' &> /dev/null



#===Test if the fabric is ready=====================================
echo Testing containers startd, retry when not ready, please be patient, it will take a while
while true; do
    if [ $(sh $FUSE_SERVER_BIN/client 'container-list'| grep "success" | wc -l ) -ge 7 ]; then
        break
    fi
    sleep 10
done
#===================================================================


echo "Stop all containers"
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop wsflightcon'
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop wshotelcon'
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop bookingflightcon'
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop bookinhotelgcon'
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop promoflightcon'
sh $FUSE_SERVER_BIN/client -r 2 -d 3 'container-stop promohotelcon'

echo "Stoping Root Container (Fabric)"
sh $FUSE_SERVER_BIN/stop



echo
echo "==========================================================================================="
echo "=                                                                                         ="
echo "=  You can now start the JBoss BPM Suite with:                                            ="
echo "=                                                                                         ="
echo "=        $SERVER_BIN/standalone.sh                                         ="
echo "=                                                                                         ="
echo "=    - login, build and deploy JBoss BPM Suite process project at:                        ="
echo "=                                                                                         ="
echo "=        http://localhost:8080/business-central (u:erics/p:bpmsuite1!)                    ="
echo "=                                                                                         ="
echo "=  Starting the camel route in JBoss Fuse as follows:                                     ="
echo "=                                                                                         ="
echo "=    - add fabric server passwords for Maven Plugin to your ~/.m2/settings.xml            =" 
echo "=      file the fabric server's user and password so that the maven plugin can            ="
echo "=      login to the fabric. fabric8.upload.repo admin admin                               ="
echo "=                                                                                         ="
echo "=    - Start JBoss Fuse server with                                                       ="
echo "=                                                                                         ="
echo "=        $FUSE_SERVER_BIN/fuse                                   ="
echo "=                                                                                         ="
echo "=    - login to Fuse management console at:                                               ="
echo "=                                                                                         ="
echo "=        http://localhost:8181    (u:admin/p:admin)                                       ="
echo "=                                                                                         ="
echo "=    - Go to Runtime Tab, start all 6 containers                                          ="
echo "=                                                                                         ="
echo "=   $DEMO Setup Complete.                 ="
echo "==========================================================================================="
echo
