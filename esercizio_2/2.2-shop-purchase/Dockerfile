FROM maven:3-jdk-12

COPY src /percorsoApp/src
COPY pom.xml /percorsoApp
RUN mvn -f /percorsoApp/pom.xml clean package --squash

EXPOSE 8080
