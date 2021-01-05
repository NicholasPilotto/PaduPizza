# Variabile CC è il comando che invoca il compilatore
CC = g++
# CCFLAGS: flags per il compilatore
CCFLAGS = -std=c++17 -Wall

compile:
	$(CC) $(CCFLAGS) main.cpp -L dependencies/lib -lpq -o main.o
clean:
	rm -f -v *.o