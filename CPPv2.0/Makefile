CC = g++
CFLAGS = -std=c++17
LDFLAGS = -lpq

ifeq ($(OS),Windows_NT)
    CCFLAGS += -D WIN32
		DEPFLAGS += -L dependencies/lib
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CCFLAGS += -D LINUX
				DEPFLAGS += -I /usr/include/postgresql
    endif
    ifeq ($(UNAME_S),Darwin)
        CCFLAGS += -D OSX
				DEPFLAGS += -L dependencies/lib
    endif
endif

compile: main.cpp pq.hpp
	$(CC) main.cpp $(CCFLAGS) $(CFLAGS) $(DEPFLAGS) $(LDFLAGS) -o main.o

clean:
	rm -r main.o
