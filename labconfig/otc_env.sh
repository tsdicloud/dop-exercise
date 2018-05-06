#!/bin/bash

export OS_AUTH_TYPE="password"
export OS_USERNAME="<otc-username>"
export OS_USER_DOMAIN_NAME="EU-DE-OTC00000000001000023731"
export OS_PASSWORD="<otc-password>"
# Only change these for a different region
export OS_TENANT_NAME=eu-de
export OS_PROJECT_NAME=eu-de
export OS_AUTH_URL=https://iam.eu-de.otc.t-systems.com/v3
export OS_CACERT=$HOME/otc_certs.pem
# No changes needed beyond this point
export OS_ENDPOINT_TYPE=publicURL
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_VOLUME_API_VERSION=2

