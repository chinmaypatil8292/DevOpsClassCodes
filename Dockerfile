FROM tomcat:8.0-alpine

LABEL maintainer=”chinmaypatil08021992@yahoo.com”

COPY target/*.war /usr/local/tomcat/webapps/

EXPOSE 8085

CMD [“catalina.sh”, “run”]
