# Use Maven to build the application
FROM maven:3.9.4 AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# Use OpenJDK for running the application
FROM openjdk:21-jdk-slim
COPY --from=build /home/app/target/myapphr-0.0.1-SNAPSHOT.jar /usr/local/lib/myapphr.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/myapphr.jar"]
