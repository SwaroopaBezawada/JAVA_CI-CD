# Tomcat 9 + Java 21 (LTS). Pinned tag for repeatable builds.
FROM tomcat:9.0-jre21-temurin

# Optional: keep default ROOT + docs removed; use webapps.dist as base
RUN rm -rf /usr/local/tomcat/webapps/* \
 && cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps

# Copy the WAR built by Maven.
# If your WAR name differs, update the filename accordingly.
COPY webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
