#!/bin/bash

set +e
set -x

ROOTFS=/var/build-root/rootfs

chroot ${ROOTFS} rc-update del cgroups sysinit
chroot ${ROOTFS} rc-update del devfs sysinit
chroot ${ROOTFS} rc-update del dmesg sysinit
chroot ${ROOTFS} rc-update del fsck boot
chroot ${ROOTFS} rc-update del hostname boot
chroot ${ROOTFS} rc-update del hwclock boot
chroot ${ROOTFS} rc-update del keymaps boot
chroot ${ROOTFS} rc-update del loopback boot
chroot ${ROOTFS} rc-update del modules boot
chroot ${ROOTFS} rc-update del sysctl boot
chroot ${ROOTFS} rc-update add php-fpm default
chroot ${ROOTFS} rc-update add nginx default


chroot ${ROOTFS} sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i /etc/rc.conf
chroot ${ROOTFS} sed -i '/tty/d' /etc/inittab

#sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i ${ROOTFS}/etc/rc.conf
echo 'rc_provide="loopback net"' >> ${ROOTFS}/etc/rc.conf
#sed -i '/tty/d' ${ROOTFS}/etc/inittab

cp /var/build-root/portage-configroot/nginx.conf ${ROOTFS}/etc/nginx/
cp /var/build-root/portage-configroot/www.conf ${ROOTFS}/etc/php/fpm-php7.3/fpm.d/www.conf
chroot ${ROOTFS} groupadd -g 249 -r nginx
chroot ${ROOTFS} useradd -u 999 -g 249 -r -M -d /var/lib/nginx -c "added by portage for nginx" -s /sbin/nologin nginx
echo "en_US.UTF-8 UTF-8" > ${ROOTFS}/etc/locale.gen
ROOT= chroot ${ROOTFS} locale-gen

exit 0
#emerge -C nextcloud

#ROOT=/var/build-root/rootfs/ PORTAGE_CONFIGROOT=/var/build-root/portage-configroot/ emerge gcc -1
#ROOT=/var/build-root/rootfs/ PORTAGE_CONFIGROOT=/var/build-root/portage-configroot/ emerge -C gcc
#ROOT=/var/build-root/rootfs/ PORTAGE_CONFIGROOT=/var/build-root/portage-configroot/ emerge --depclean

find /var/build-root/rootfs/ -type d -iname "include" -exec rm {} -R \;
find /var/build-root/rootfs/ -type d -iname "man" -exec rm {} -R \;
find /var/build-root/rootfs/ -type d -iname "info" -exec rm {} -R \;
#find /var/build-root/rootfs/ -maxdepth 5 -type d -iname "locale" -exec rm {} -R \;
find /var/build-root/rootfs/ -maxdepth 5 -type d -iname "doc" -exec rm {} -R \;
#find /var/build-root/rootfs/ -type d -iname "i18n" -exec rm {} -R \;
find /var/build-root/rootfs/ -type d -iname "gtk-doc" -exec rm {} -R \;
rm /var/build-root/rootfs/var/db -R
rm /var/build-root/rootfs/usr/libexec -R
rm /var/build-root/rootfs/usr/x86_64-pc-linux-gnu -R
rm /var/build-root/rootfs/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/32 -R
rm /var/build-root/rootfs/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/finclude -R
rm /var/build-root/rootfs/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include-fixed -R
rm /var/build-root/rootfs/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/plugin -R
rm /var/build-root/rootfs/usr/share/gcc-data -R
#find /var/build-root/rootfs/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/* -mindepth 2 -type d -exec rm {} -R \;

find /var/build-root/rootfs/ -type f -iname "*.a" -exec rm {} -R \;
find /var/build-root/rootfs/ -type f -iname "*.la" -exec rm {} -R \;
find /var/build-root/rootfs/ -type f -iname "*.o" -exec rm {} -R \;
find /var/build-root/rootfs/ -type f -iname "*.m4" -exec rm {} -R \;
