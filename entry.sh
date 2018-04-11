#! /bin/bash
# vim: set ts=4 sw=4 et :

# Copyright 2018 Red Hat, Inc. and/or its affiliates.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

#-- Migrate the data
DO_COPY=${DO_COPY:-1}

#-- Checksum the source & destination
DO_CHECKSUM=${DO_CHECKSUM:-1}


if [ "$DO_COPY" -gt 0 ]; then
    echo "===== Copying files ====="
    rsync -aHAXW --delete --stats /source/ /target
fi

if [ "$DO_CHECKSUM" -gt 0 ]; then
    echo
    echo
    echo "===== Generating checksums ====="
    cd /source && find . -type f -exec sha512sum --tag {} \; > /tmp/sums
    echo "Checksum count: $(wc -l /tmp/sums)"

    echo
    echo
    echo "===== Verifying checksums ====="
    cd /target && sha512sum --check --quiet /tmp/sums && echo "ALL OK"
fi
