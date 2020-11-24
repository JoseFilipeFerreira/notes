################################################################################
# Makefile for general code snippets
#
# by André Pereira (LIP-Minho)
################################################################################
SHELL = /bin/sh

BIN_NAME = lab1

#CXX = g++
#LD  = g++

CXX = icpc
LD  = icpc

#-fopenmp/-openmp for GNU/Intel


#CXXFLAGS   = -O3 -g -Wall -Wextra -std=c++11 -Wno-unused-parameter -qopt-report=3
CXXFLAGS   = -O2 -g -Wall -Wextra -std=c++11 -Wno-unused-parameter -qopt-report=2 -qopt-report-phase=vec
# include directories
INCLUDES = -I. -I/share/apps/papi/5.4.1/include
 
# library directories
LIBDIRS = -L/share/apps/papi/5.4.1/lib

ifeq ($(DYNAMIC),yes)
	CXXFLAGS += -DD_DYNAMIC
endif

ifeq ($(IRREGULAR),yes)
	CXXFLAGS += -DD_IRREGULAR
endif

################################################################################
# Control awesome stuff
################################################################################

SRC_DIR = src
BIN_DIR = bin
BUILD_DIR = build
SRC = $(wildcard $(SRC_DIR)/*.cpp)
OBJ = $(patsubst src/%.cpp,build/%.o,$(SRC))
BIN = $(BIN_NAME)

vpath %.cpp $(SRC_DIR)

################################################################################
# Rules
################################################################################

.DEFAULT_GOAL = all

$(BUILD_DIR)/%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $(INCLUDES) $(LIBDIRS) $< -o $@ -lpthread -lpapi

$(BIN_DIR)/$(BIN_NAME): $(OBJ)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(LIBDIRS) -o $@ $(OBJ) -lpthread -lpapi

checkdirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)

all: checkdirs $(BIN_DIR)/$(BIN_NAME)

clean:
	rm -f $(BUILD_DIR)/* $(BIN_DIR)/*
