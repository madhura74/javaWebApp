FROM openjdk:17
# Base image for running the Spring Boot application
ADD target/sample_webapp-0.0.1-SNAPSHOT.jar sample_webapp-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "sample_webapp-0.0.1-SNAPSHOT.jar"]