#!/bin/sh

VERSION=2016.09.17

tar --files-from=file.list -xJvf ../binutils-gdb-arc-$VERSION.tar.xz
mv binutils-gdb-arc-$VERSION binutils-gdb-arc-$VERSION-orig

cp -rf ./binutils-gdb-arc-$VERSION-new ./binutils-gdb-arc-$VERSION

diff -b --unified -Nr  binutils-gdb-arc-$VERSION-orig  binutils-gdb-arc-$VERSION > binutils-gdb-arc-$VERSION-flex-2.6.3.patch

mv binutils-gdb-arc-$VERSION-flex-2.6.3.patch ../patches

rm -rf ./binutils-gdb-arc-$VERSION
rm -rf ./binutils-gdb-arc-$VERSION-orig
