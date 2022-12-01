FROM ubuntu
MAINTAINER "abhay10"
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y maven
WORKDIR /springbootapp
COPY . .
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN mvn clean install
EXPOSE 8090
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
