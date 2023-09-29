#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/KyleGospo/jupiter-fan-control
git clone https://github.com/KyleGospo/jupiter-hw-support -b btrfs
mkdir -p ./steamdeck-jupiter-driver-btrfs
cp -rvf ./jupiter-fan-control/usr ./steamdeck-jupiter-driver-btrfs
cp -rvf ./jupiter-hw-support/etc ./steamdeck-jupiter-driver-btrfs
cp -rvf ./jupiter-hw-support/usr ./steamdeck-jupiter-driver-btrfs
cp -rvf ./debian ./steamdeck-jupiter-driver-btrfs
cd ./steamdeck-jupiter-driver-btrfs

# Get build deps
apt-get build-dep ./ -y

# Patch
for i in ../patches/*.patch; do patch -Np1 -i $i;done
rm -rfv ./usr/lib/systemd/system/multi-user.target.wants

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
