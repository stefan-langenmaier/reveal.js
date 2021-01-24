#!/bin/bash

docker cp host-portage/package.use/nextcloud gentoo-builder:/etc/portage/package.use/
docker cp host-portage/package.accept_keywords gentoo-builder:/etc/portage/

docker exec -i gentoo-builder emerge webapp-config eselect-php sys-libs/libcap
docker exec -i gentoo-builder emerge -O nextcloud
