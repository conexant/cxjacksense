##############################################################################
#
# Copyright (C) 2017, Conexant Systems, LLC.
#
# This program is free software (firmware): you can redistribute it and/or
# modify it under the terms of  the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  (It's in the $(ROOT)/doc directory, run make with no
# target there if the PDF file isn't present.)  If not, see
# <http://www.gnu.org/licenses/> for a copy.
#
##############################################################################

#Define cross-compiler
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

