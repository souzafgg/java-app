FROM openjdk:17-jdk-alpine

WORKDIR /app

ENV DATASOURCE_URL=jdbc:mysql://localhost/vollmed_api
    DATASOURCE_USERNAME=root
    DATASOURCE_PASSWORD=Root@123

COPY ./target/*.jar app.jar

CMD ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]



