# Variabile CC è il comando che invoca il compilatore
CC = clang++
# CCFLAGS: flags per il compilatore
CCFLAGS = -std=c++17 -Wall -march=x86-64

compile: main.o 
        $(CC) $(CCFLAGS) main.o -o compile.o

main.o: main.cpp
        $(CC) $(CCFLAGS) -c main.cpp

clean:
        rm -f -v *.o