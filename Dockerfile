FROM tomcat

LABEL maintainer=”chinmaypatil08021992@yahoo.com”

ADD target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [“catalina.sh”, “run”]
