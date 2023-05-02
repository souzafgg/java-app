FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

ENV DATASOURCE_URL=jdbc:mysql://localhost/vollmed_api
ENV DATASOURCE_USERNAME=root
ENV DATASOURCE_PASSWORD=Root@123

COPY ./target/*.jar app.jar

CMD ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]



