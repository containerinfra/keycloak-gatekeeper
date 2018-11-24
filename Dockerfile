FROM centos:latest as build

ENV KEYCLOAK_VERSION 4.6.0.Final

RUN yum install -y ca-certificates curl tar
RUN curl -fssL "https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/gatekeeper/keycloak-gatekeeper-linux-amd64.tar.gz" | tar -xz && chmod +x /usr/local/bin/keycloak-gatekeeper

# Resulting image
FROM scratch 
COPY --from=build /usr/local/bin/keycloak-gatekeeper /usr/local/bin/keycloak-gatekeeper
ENTRYPOINT [ "/usr/local/bin/keycloak-gatekeeper" ]
