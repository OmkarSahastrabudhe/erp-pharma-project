FROM  maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
ARG SERVICE_NAME
COPY ./${SERVICE_NAME}/POM.xml  .
RUN mvn dependency:go-offline -B
COPY ./${SERVICE_NAME}/src/ ./src/
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
ARG PORT
EXPOSE ${PORT}
ENTRYPOINT [ "java", "-jar", "app.jar" ]



