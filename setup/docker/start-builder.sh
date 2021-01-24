#!/bin/bash

docker run \
	-it \
	--rm \
	--cap-add=SYS_PTRACE \
	-v /home/stefan/.gentoo/portage:/var/db/repos/gentoo \
	-v /home/stefan/.gentoo/packages:/var/cache/binpkgs \
	-v /home/stefan/.gentoo/distfiles:/var/cache/distfiles \
	-v /home/stefan/.gentoo/build-root/rootfs:/var/build-root/rootfs \
	-v /home/stefan/git/docker-composability-presentation/setup/docker/portage-configroot:/var/build-root/portage-configroot \
	-v /home/stefan/.gentoo/container-profiles:/usr/local/portage/container-profiles \
	-v /home/stefan/.gentoo/config/repos.conf/container-profiles.conf:/etc/portage/repos.conf/container-profiles.conf \
	--name gentoo-builder \
	gentoo-builder \
		/bin/bash \

