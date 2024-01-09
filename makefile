CC = g++
CFLAGS = -Wall -Wextra -std=c++11

BUILDDIR = build

EXECUTABLE = $(BUILDDIR)/main

all: $(EXECUTABLE)

$(EXECUTABLE): main.cpp
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILDDIR)/*

.PHONY: all clean