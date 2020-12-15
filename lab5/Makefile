################################################################################
# Makefile for general code snippets
#
# by André Pereira (LIP-Minho)
################################################################################

SHELL = /bin/sh

BIN_NAME = matrix_mult

CXX = nvcc
LD  = nvcc
CXXFLAGS = -O3 -DD_GPU -arch=sm_30

ifeq ($(DEBUG),yes)
	CXXFLAGS += -ggdb3
endif

################################################################################
# Control awesome stuff
################################################################################

SRC_DIR = src
BIN_DIR = bin
BUILD_DIR = build
SRC = $(wildcard $(SRC_DIR)/*.cu)
OBJ = $(patsubst src/%.cu,build/%.o,$(SRC))
DEPS = $(patsubst build/%.o,build/%.d,$(OBJ))
BIN = $(BIN_NAME)

vpath %.cu $(SRC_DIR)

################################################################################
# Rules
################################################################################

.DEFAULT_GOAL = all


$(BIN_DIR)/$(BIN_NAME): src/lab5.cu
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ src/lab5.cu $(LIBS)

checkdirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)

all: checkdirs $(BIN_DIR)/$(BIN_NAME)

clean:
	rm -f $(BUILD_DIR)/* $(BIN_DIR)/* 
