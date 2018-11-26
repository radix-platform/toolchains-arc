#!/bin/bash

VERSION=2016.09.17

tar --files-from=file.list -xJvf ../gcc-arc-$VERSION.tar.xz
mv gcc-arc-$VERSION gcc-arc-$VERSION-orig

cp -rf ./gcc-arc-$VERSION-new ./gcc-arc-$VERSION

diff -b --unified -Nr  gcc-arc-$VERSION-orig  gcc-arc-$VERSION > gcc-arc-$VERSION-ubsan-c.patch

mv gcc-arc-$VERSION-ubsan-c.patch ../patches

rm -rf ./gcc-arc-$VERSION
rm -rf ./gcc-arc-$VERSION-orig
