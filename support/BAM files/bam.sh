#!/bin/sh 
JBOSS_HOME=./target/jboss-eap-6.4
BAM_FILES=./support/bam/
SERVER_DIR=$JBOSS_HOME/standalone/deployments/

command -v curl http://localhost:8080/external-client-ui-form-1.0/SimpleServlet?applicantName=Tito+Nova&emailAddress=test%40email.com&numberOfTravelers=2&fromDestination=London&toDestination=Edinburgh&preferredDateOfArrival=2014-02-31&preferredDateOfDeparture=2014-12-16&otherDetails=N%2FA -q >/dev/null 2>&1 || { echo >&2 "Please ensure both BPMS and FUSE are running... aborting this command now."; exit 1; }


