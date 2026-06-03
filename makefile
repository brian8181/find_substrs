# @name     find_substrs
# @file:    makefile
# @date:    Wed Jun  3 08:24:27 CDT 2026
# @version: version 0.0.1

# g++ warnings
#-Wall -Wextra -Wpedantic -Wshadow -Wconversion -Werror -Wundef
#-fsanitize=undefined,address -Wfloat-equal -Wformat-nonliteral
#-Wformat-security -Wformat-y2k -Wformat=2 -Wimport -Winvalid-pch
#-Wlogical-op -Wmissing-declarations -Wmissing-field-initializers
#-Wmissing-format-attribute -Wmissing-include-dirs -Wmissing-noreturn
#-Wnested-externs -Wpacked -Wpointer-arith -Wredundant-decls
#-Wstack-protector -Wstrict-null-sentinel -Wswitch-enum -Wwrite-strings

SHELL:=bash
APP=find_substrs
CXX=g++
CXXFLAGS=-Wall -std=c++20 -fPIC
CXXEXTRA=-Wno-template-body
CXXCPP=
LDFLAGS=
LIBS=
SRC = src
BLD = build
OBJ = build
TST = build

# lib settings
LIBS=-L/usr/lib -L/usr/lib64 -L/usr/local/lib -L/usr/local/lib64
INCLUDES=-I/usr/local/include/cppunit/
LDFLAGS=$(INCLUDES) $(LIBS)

ifndef RELEASE
	CXXFLAGS +=-g -DDEBUG
endif

ifdef CYGWIN
	CXXFLAGS +=-DCYGWIN
	LDFLAGS += -lfmt -lcppunit.dll
else
	LDFLAGS += -lfmt -lcppunit
endif

OBJS=$(OBJ)/main.o $(OBJ)/find_substrs.o $(OBJ)/find.o

all: $(BLD)/find_substrs #$(BLD)/libfind_substrs.so $(BLD)/libfind_substrs.a $(BLD)/TEST_find_substrs

$(BLD)/find_substrs: $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(BLD)/libfind_substrs.so: $(OBJS)
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) --shared $^ -o $@
	-chmod 755 $@

$(BLD)/libfind_substrs.a: $(OBJS)
	-ar rvs $^
	-chmod 755 $@

$(BLD)/TEST_find_substrs: $(OBJ)/find_substrs.o $(OBJ)/TEST_find_substrs.o
	$(CXX) $(CXXFLAGS) $^ $(LDFLAGS) -o $@

# copy header to build dir
$(BLD)/%.hpp: $(SRC)/%.hpp
	-cp $^ $@

$(OBJ)/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

.PHONY: all clean install unintsall rebuild help
rebuild: clean all

install:
	cp ./$(BLD)/find_substrs ./$(prefix)/bin/find_substrs

uninstall:
	-rm ./$(prefix)/bin/find_substrs

clean:
	@echo "removing files ..."
	-rm -f $(OBJ)/*
	-rm -f $(BLD)/*

help:
	@echo
	@echo  'Project: find_substrs : version 0.0.1 : Wed Jun  3 08:24:27 CDT 2026 simple "find_substrs" framework.'
	@echo
	@echo  '    make [-f] [target]'
	@echo
	@echo  '   -Make Targets ...'
	@echo
	@echo  '        * all                              - build all'
	@echo  '        * $(BLD)/find_substrs:          - re/build find_substrs'
	@echo  '        * $(BLD)/find_substrs_utest:    - re/build find_substrs_utest, unit testing'
	@echo  '        * clean                            - remove most generated files but keep the config'
	@echo
