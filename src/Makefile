all: solver

solver: solver.🔥 libdemo.a
	../scripts/mojoc solver.🔥 -Slibdemo.a -o solver -L/usr/local/lib -lglfw -ldl -lpthread -lm -lGL

libdemo.a: demo.c
	gcc -c demo.c -o demo.o
	ar rcs libdemo.a demo.o

clean:
	rm -f libdemo.a demo.o solver
	rm -f *.o

.PHONY: all clean