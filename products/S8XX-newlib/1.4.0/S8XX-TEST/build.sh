#!/bin/bash

. ./.config

export PATH=$TOOLCHAIN_PATH/bin:$PATH

$TARGET-gcc -g -mcpu=arcem -I$TOOLCHAIN_PATH/$TARGET/include -c -o main.o main.c
$TARGET-gcc -mcpu=arcem -o main main.o -lc -lnosys

$TARGET-objdump -x main > main.map

$TARGET-strip main -o main.elf

$TARGET-objcopy -O srec main.elf main.srec
$TARGET-objcopy -O ihex main.elf main.hex
$TARGET-objdump -S -d main.o > main.asm
$TARGET-objdump -S -d main > full.program.asm
