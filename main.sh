DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports

# Clone Upstream
git clone https://github.com/KyleGospo/jupiter-fan-control
git clone https://github.com/KyleGospo/jupiter-hw-support
mkdir -p ./steamdeck-jupiter-driver
cp -rvf ./jupiter-hw-support/usr ./jupiter-fan-control
cp -rvf ./jupiter-hw-support/etc ./steamdeck-jupiter-driver
cp -rvf ./jupiter-hw-support/usr ./steamdeck-jupiter-driver
cp -rvf ./debian ./steamdeck-jupiter-driver
cd ./steamdeck-jupiter-driver

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
