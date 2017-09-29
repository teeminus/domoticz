#!/bin/bash

rm -rf opt
mkdir -p opt/domoticz
cd  opt/domoticz

git clone -b master https://github.com/domoticz/domoticz.git git
cd git
__v_domoticz=$(awk '/Version/ { print $2; }' History.txt | head -n1)
echo "domoticz (${__v_domoticz}) stable; urgency=low" > ../../../debian/changelog
echo "  * Update to ${__v_domoticz}" >> ../../../debian/changelog
echo " -- OpenMediaVault Plugin Developers <plugins@omv-extras.org>  $(date -R)"  >> ../../../debian/changelog

cmake -DCMAKE_BUILD_TYPE=Release .
make

cp -r Config scripts www domoticz domoticz.sh server_cert.pem updatebeta updaterelease ../
cd ..

rm -rf git
cd ../../

__v=$(./opt/domoticz/domoticz --help | awk '/Domoticz V/ { print $4; }');
#__v=${__v:1};
echo "domoticz (${__v:1}) stable; urgency=low" > debian/changelog
echo "  * Update to ${__v:1}" >> debian/changelog
echo " -- OpenMediaVault Plugin Developers <plugins@omv-extras.org>  $(date -R)"  >> debian/changelog

fakeroot debian/rules clean binary
