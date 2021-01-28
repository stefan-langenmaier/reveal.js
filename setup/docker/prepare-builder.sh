#!/bin/bash

docker cp host-portage/package.use/nextcloud gentoo-builder:/etc/portage/package.use/
docker cp host-portage/package.accept_keywords gentoo-builder:/etc/portage/

docker exec -i gentoo-builder emerge webapp-config eselect-php sys-libs/libcap
docker exec -i gentoo-builder emerge -O nextcloud


docker exec -i gentoo-builder bash -c "rm /var/build-root/rootfs/* -R" # to avoid an early expansion
docker exec -i gentoo-builder mkdir -p /var/build-root/rootfs/usr/share/webapps
docker exec -i gentoo-builder ln -sf /usr/share/webapps/nextcloud /var/build-root/rootfs/usr/share/webapps/nextcloud
docker exec -i gentoo-builder mkdir -p /var/build-root/rootfs/var/db/webapps
