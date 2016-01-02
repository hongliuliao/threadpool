.PHONY: all test clean

CXX := g++
CXXFLAG := -g -Wall 
LDFLAGS := -lpthread
DEPS_INCLUDE_PATH=-I deps/simple_log/output/include/
DEPS_LIB_PATH=deps/simple_log/output/lib/libsimplelog.a

all:
	echo "make all"
	mkdir -p output/include
	mkdir -p output/lib
	mkdir -p output/bin
	$(CXX) $(CXXFLAG) $(DEPS_INCLUDE_PATH) -c src/threadpool.cpp -o src/threadpool.o
	ar -rcs libthreadpool.a src/*.o
	rm -rf src/*.o
	
	cp src/*.h output/include/
	mv libthreadpool.a output/lib/
	
test: test/threadpool_test.cpp
	$(CXX) $(CXXFLAG) $(LDFLAGS) -I output/include $(DEPS_INCLUDE_PATH) test/threadpool_test.cpp output/lib/libthreadpool.a $(DEPS_LIB_PATH) -o output/bin/threadpool_test
