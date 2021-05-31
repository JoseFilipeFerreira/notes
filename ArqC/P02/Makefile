# source files.
SRC = gemm.c my_papi.c main.c

OBJ = $(SRC)

OUT = gemm

# include directories
INCLUDES = -I. -I/share/apps/papi/5.4.1/include
 
# library directories
LIBDIRS = -L/share/apps/papi/5.4.1/lib
 
# C compiler flags 
CCFLAGS = -O0 -Wall
#CCFLAGS = -O2 -Wall -march=ivybridge

# compiler
CCC = gcc 

# libraries
LIBS = -lm -lpapi

.SUFFIXES: .cpp .c 


default: $(OUT)

.cpp.o:
	module load gcc/5.3.0 papi/5.4.1 ; \
	$(CCC) $(CCFLAGS) $(INCLUDES)  -c $< -o $@

.c.o:
	module load gcc/5.3.0 papi/5.4.1 ; \
	$(CCC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

gemm9.o: gemm9.c
	module load gcc/5.3.0 papi/5.4.1 ; \
	$(CCC) $(CCFLAGS) -march=native $(INCLUDES) -c $< -o $@

$(OUT): $(OBJ)
	module load gcc/5.3.0 papi/5.4.1 ; \
	$(CCC) -o $(OUT) $(CCFLAGS) $(INCLUDES) $(OBJ) $(LIBS) $(LIBDIRS)

depend:  dep
#
#dep:
#	makedepend -- $(CFLAGS) -- $(INCLUDES) $(SRC)

clean:
	rm -f *.o .a *~ Makefile.bak $(OUT)
