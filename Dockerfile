FROM centos:7 as build

ARG KEYCLOAK_GATEKEEPER_VERSION=4.7.0.Final
ARG KEYCLOAK_GATEKEEPER_SHA256=2f1793e6b67a80a0cb1a253e2acc5f344e7997605a29871dfad617360940106e

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
