#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/keycloak/keycloak/tags?per_page=1" | # Get latest release from GitHub api
    grep '"name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}


keycloak_version=$(get_latest_release "keycloak/keycloak")

echo $keycloak_version
