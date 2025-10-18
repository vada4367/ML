
#!/bin/sh

mkdir -p .trash

nasm -f elf64 main.asm -o ./.trash/main.o
gcc -no-pie ./.trash/main.o -o main

