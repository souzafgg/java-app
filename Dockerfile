FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY ./target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]



