FROM centos:7 as build

ARG KEYCLOAK_GATEKEEPER_VERSION=4.8.1.Final
ARG KEYCLOAK_GATEKEEPER_SHA256=472c555677016da3a41ef052c5b9d82a78cd04c6db84a2067064d9475c6f9830

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
