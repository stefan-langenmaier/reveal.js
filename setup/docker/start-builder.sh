#!/bin/bash

docker run \
	-it \
	--rm \
	--cap-add=SYS_PTRACE \
	-v /home/stefan/.gentoo/portage:/var/db/repos/gentoo \
	-v /home/stefan/.gentoo/packages:/var/cache/binpkgs \
	-v /home/stefan/.gentoo/distfiles:/var/cache/distfiles \
	-v /home/stefan/.gentoo/build-root:/var/build-root \
	-v /home/stefan/.gentoo/container-profiles:/usr/local/portage/container-profiles \
	-v /home/stefan/.gentoo/config/repos.conf/container-profiles.conf:/etc/portage/repos.conf/container-profiles.conf \
	gentoo-builder \
		/bin/bash \
