# source files.
SRC = Random.c Particle.c MD.c main.c

OBJ = $(SRC:.cpp=.o)

OUT = md

# include directories
INCLUDES = -I.
# C compiler flags 

CCFLAGS = -O3 -g -march=native -Wall

# compiler
CCC = gcc

# libraries
LIBS = -lm 
#-fopenmp

.SUFFIXES: .cpp .c 


default: $(OUT)

.cpp.o:
	$(CCC) $(CCFLAGS) $(INCLUDES)  -c $< -o $@

.c.o:
	$(CCC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

$(OUT): $(OBJ)
	$(CCC) -o $(OUT) $(CCFLAGS) $(OBJ) $(LIBS) 

depend:  dep
#
#dep:
#	makedepend -- $(CFLAGS) -- $(INCLUDES) $(SRC)

clean:
	rm -f *.o .a *~ Makefile.bak $(OUT)
