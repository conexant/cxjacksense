
# Which compiler
CC = $(CROSS_COMPILE)g++

#Options for development
CFLAGS= -Wall -ansi 
LDFLAGS= -static
SOURCES= jacksense.c
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=cxjacksense

all: $(SOURCES) $(EXECUTABLE)
	
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf *o cxjacksense

