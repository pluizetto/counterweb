
#Build stage
FROM maven:3.8-jdk-8 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#Deploy stage
FROM openshift/ubi8-openjdk8-wildfly:24.0
COPY --from=build /home/app/target/CounterWebApp.war /opt/wildfly-24.0.0.Final/standalone/deployments/CounterWebApp.war


#FROM default-route-openshift-image-registry.apps.pac.gruposc.local/openshift/gsc-openjdk8-wildfly:24.0
#RUN pwd; ls -lh
#COPY target/CounterWebApp.war /opt/wildfly-24.0.0.Final/standalone/deployments/CounterWebApp.war
