# Use the official Maven image as a base image
FROM maven:3.8.5-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Copy the source code to the container
COPY src ./src

# Package the application
RUN mvn clean package

# Use the official OpenJDK image as a base image for the runtime
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/javemaven-0.0.1-SNAPSHOT.jar ./javemaven-0.0.1-SNAPSHOT.jar

# Expose the application port (change if necessary)
EXPOSE 8080

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "javemaven-0.0.1-SNAPSHOT.jar"]
