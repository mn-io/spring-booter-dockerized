FROM openjdk:12-alpine

RUN apk --no-cache add curl git

# based on https://github.com/carlossg/docker-maven/blob/master/openjdk-8/Dockerfile
ARG MAVEN_VERSION=3.6.3
ARG MAVEN_SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG MAVEN_BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${MAVEN_SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

COPY assets/wait-for.sh /opt/wait-for.sh

WORKDIR /spring-booter
COPY spring-booter-submodule/pom.xml ./
COPY spring-booter-submodule/src ./src

RUN mvn -B dependency:resolve
RUN mvn -B compile

EXPOSE 8080

# https://phoenixnap.com/kb/docker-cmd-vs-entrypoint
# executable is defined with ENTRYPOINT, while CMD specifies the default parameter.
# see README.md > FAQ
# ENTRYPOINT ["mvn"]
# CMD ["spring-boot:run"]
