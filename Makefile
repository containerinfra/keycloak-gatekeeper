
IMAGE?=keycloak-gatekeeper
REGISTRY?=ghcr.io/containerinfra
VERSION	?=local

docker:
	docker build -t ${REGISTRY}/${IMAGE}:${VERSION} .

publish-docker:
	docker push ${REGISTRY}/${IMAGE}:${VERSION}
