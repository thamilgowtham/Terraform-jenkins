FROM openjdk:8-alpine

# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /usr/share/maven
ENV PROJECT_HOME /usr/share/maven

COPY target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME
EXPOSE 8080
CMD ["java" ,"-jar","./spring-boot-mongo.jar"]
