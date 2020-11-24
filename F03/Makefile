################################################################################
# Makefile for general code snippets
#
# by André Pereira (LIP-Minho)
################################################################################

SHELL = /bin/sh

BIN_NAME = cuda_bin

CXX = nvcc
LD  = nvcc
CXXFLAGS = -O3 -DD_GPU -arch=sm_30 -Xcompiler -fopenmp

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


$(BIN_DIR)/$(BIN_NAME): src/lab2-1.cu src/lab2-2o.cu src/lab2-2s.cu
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o bin/lab2-1 src/lab2-1.cu $(LIBS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o bin/lab2-2o src/lab2-2o.cu $(LIBS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o bin/lab2-2s src/lab2-2s.cu $(LIBS)

checkdirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)

all: checkdirs $(BIN_DIR)/$(BIN_NAME)

clean:
	rm -f $(BUILD_DIR)/* $(BIN_DIR)/* 
