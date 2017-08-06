#!/bin/sh

case "$(/usr/bin/arch)" in
  *arm*)
    arch="armv7l"
    ;;
  *)
    arch="x86_64"
    ;;
esac
url="https://releases.domoticz.com/releases/release/domoticz_linux_${arch}.tgz"

rm -rfv opt
mkdir -p opt/domoticz
cd  opt/domoticz

tmp_file="domoticz.tgz"

wget "${url}" -O ${tmp_file}
tar xvzf "${tmp_file}"

rm -f ${tmp_file}
cd ../../
fakeroot debian/rules clean binary