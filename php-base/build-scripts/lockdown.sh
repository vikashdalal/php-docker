#!/bin/bash

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -xe

# Lock down the DOCUMENT_ROOT
chown -R root.www-data ${DOCUMENT_ROOT}
chmod -R 550 ${DOCUMENT_ROOT}

# Change the www-data's shell back to /usr/sbin/nologin
chsh -s /usr/sbin/nologin www-data

# Enable suhosin for PHP 5.6.x
if [ -x "${PHP56_DIR}/bin/php56-enmod" ]; then
    ${PHP56_DIR}/bin/php56-enmod suhosin
fi

# Whitelist functions
${PHP_DIR}/bin/php -d auto_prepend_file='' \
          /build-scripts/whitelist_functions.php

# Remove loose php-cli.ini
rm /opt/php/lib/php-cli.ini
