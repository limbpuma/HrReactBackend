# Stage 1: Build the application
FROM maven:3.8.4-jdk-21 AS build
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# Stage 2: Package the application
FROM openjdk:21-jre-slim
COPY --from=build /home/app/target/rh-0.0.1-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]
