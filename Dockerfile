FROM centos:7 as build

ARG KEYCLOAK_GATEKEEPER_VERSION=8.0.0
ARG KEYCLOAK_GATEKEEPER_SHA256=e145fa743e4a051dadccd1fc23b0bfa98deff4b23e957ce20c020b4bdf3afa8e

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
