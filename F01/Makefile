SOURCEDIR=src/
OUTDIR=bin/
CXX=icpc
INCLUDES=-I/share/apps/papi/5.5.0/include/ -DUSE_PAPI
CXXFLAGS= -O3 -std=c++11 -mavx -g -qopenmp -qopt-report5 $(INCLUDES)
LIBS=-L/share/apps/papi/5.5.0/lib/ -lpapi

PROGS=$(OUTDIR)demo

.PHONY: default

default: $(OUTDIR) $(SOURCEDIR)roofline.cpp $(SOURCEDIR)main.cpp
	$(CXX) $(CXXFLAGS) -o $(PROGS) $(SOURCEDIR)roofline.cpp $(SOURCEDIR)main.cpp $(LIBS)

$(OUTDIR):
	mkdir $(OUTDIR)

.PHONY: clean
clean:
	rm -r $(OUTDIR)
