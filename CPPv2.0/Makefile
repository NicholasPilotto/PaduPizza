CC = g++
CFLAGS = -std=c++17
LDFLAGS = -lpq

compile: main.cpp pq.hpp
	$(CC) main.cpp $(CFLAGS) -L dependencies/lib $(LDFLAGS) -o main.o

.PHONY: clean
clean:
	rm -f example