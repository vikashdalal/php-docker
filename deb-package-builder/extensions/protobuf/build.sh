#!/bin/bash

set -ex

source ${DEB_BUILDER_DIR}/extensions/functions.sh

echo "Building protobuf for gcp-php${SHORT_VERSION}"

PNAME="gcp-php${SHORT_VERSION}-protobuf"

# Download the source
download_from_pecl protobuf
build_package protobuf
