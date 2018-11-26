#!/bin/bash

VERSION=2016.09.17

tar --files-from=file.list -xJvf ../newlib-arc-$VERSION.tar.xz
mv newlib-arc-$VERSION newlib-arc-$VERSION-orig

cp -rf ./newlib-arc-$VERSION-new ./newlib-arc-$VERSION

diff -b --unified -Nr  newlib-arc-$VERSION-orig  newlib-arc-$VERSION > newlib-arc-$VERSION-doc.patch

mv newlib-arc-$VERSION-doc.patch ../patches

rm -rf ./newlib-arc-$VERSION
rm -rf ./newlib-arc-$VERSION-orig
