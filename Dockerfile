FROM centos:7 as build

ARG KEYCLOAK_GATEKEEPER_VERSION=5.0.0
ARG KEYCLOAK_GATEKEEPER_SHA256=4314695d28d83652cef494549e4a068ef8c9fa285c67a3358fbe6ae4d96a3c2c

RUN curl -L -O https://downloads.jboss.org/keycloak/${KEYCLOAK_GATEKEEPER_VERSION}/gatekeeper/keycloak-gatekeeper-linux-amd64.tar.gz \
    \
    && sha256sum keycloak-gatekeeper-linux-amd64.tar.gz \
    && echo "${KEYCLOAK_GATEKEEPER_SHA256} keycloak-gatekeeper-linux-amd64.tar.gz" | sha256sum -c \
    && tar -zxvf keycloak-gatekeeper-linux-amd64.tar.gz  \
    \
    && mv keycloak-gatekeeper /usr/local/bin/keycloak-gatekeeper \
    && rm -rf keycloak-gatekeeper-linux-amd64.tar.gz

# Resulting image
FROM scratch 
COPY --from=build /usr/local/bin/keycloak-gatekeeper /usr/local/bin/keycloak-gatekeeper
ENTRYPOINT [ "/usr/local/bin/keycloak-gatekeeper" ]
