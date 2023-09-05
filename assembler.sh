#!/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <input_file.s> [-g]"
    exit 1
fi

fileName="${1%%.*}"

nasm -f elf64 "$1"

if [ $? -ne 0 ]; then
    echo "Assembly failed."
    exit 1
fi

ld "${fileName}.o" -o "$fileName"

if [ $? -ne 0 ]; then
    echo "Linking failed."
    exit 1
fi

if [ "$2" == "-g" ]; then
    gdb -q "$fileName"
else
    ./"$fileName"
fi

