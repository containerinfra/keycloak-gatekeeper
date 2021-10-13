FROM centos:7 as build

ARG KEYCLOAK_GATEKEEPER_VERSION=9.0.3
ARG KEYCLOAK_GATEKEEPER_SHA256=949638c9efcc6809a8058472ad5fecd126b4a8691013a5cee21761c15b3c1501

RUN curl -L -O https://downloads.jboss.org/keycloak/${KEYCLOAK_GATEKEEPER_VERSION}/gatekeeper/keycloak-gatekeeper-linux-amd64.tar.gz \
    \
    && sha256sum keycloak-gatekeeper-linux-amd64.tar.gz \
    && echo "${KEYCLOAK_GATEKEEPER_SHA256} keycloak-gatekeeper-linux-amd64.tar.gz" | sha256sum -c \
    && tar -zxvf keycloak-gatekeeper-linux-amd64.tar.gz  \
    \
    && mv keycloak-gatekeeper /usr/local/bin/keycloak-gatekeeper \
    && rm -rf keycloak-gatekeeper-linux-amd64.tar.gz

# Resulting image
FROM gcr.io/distroless/static 
COPY --from=build /usr/local/bin/keycloak-gatekeeper /usr/local/bin/keycloak-gatekeeper
ENTRYPOINT [ "/usr/local/bin/keycloak-gatekeeper" ]
