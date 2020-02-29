#!/bin/bash
cd ~/.gentoo/build-root/rootfs/
sudo tar -c . | pv | docker import - testimage
