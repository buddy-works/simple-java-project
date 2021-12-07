FROM tomcat:8
EXPOSE 8080
ADD target\works-with-heroku-1.0.war works-with-heroku-1.0.war
CMD ["catalina.sh","run"]
