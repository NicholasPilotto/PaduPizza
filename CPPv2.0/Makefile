CC = g++
CFLAGS = -std=c++17
LDFLAGS = -lpq

ifeq ($(OS),Windows_NT)
    CCFLAGS += -D WIN32
		DEPFLAGS += -L dependencies/lib
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        CCFLAGS += -D AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            CCFLAGS += -D AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            CCFLAGS += -D IA32
        endif
    endif
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
