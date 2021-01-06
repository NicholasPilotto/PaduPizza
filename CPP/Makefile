# Variabile CC è il comando che invoca il compilatore
CC = g++
# CCFLAGS: flags per il compilatore
CCFLAGS = -std=c++17 -Wall

compile-o:
	$(CC) $(CCFLAGS) main.cpp -L dependencies/lib -lpq -o main.o

compile-exe:
	$(CC) $(CCFLAGS) main.cpp -L dependencies/lib -lpq -o main.exe
	
clean:
	rm -f -v *.o