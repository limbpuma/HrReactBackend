# Build stage
FROM maven:3.8.4-jdk-11 AS build
WORKDIR /app
COPY . /app
RUN mvn clean package -DskipTests

# Package stage
FROM openjdk:11
COPY --from=build /app/target/*.jar /usr/app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/app/app.jar"]
