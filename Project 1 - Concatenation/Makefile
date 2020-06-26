all: project1

project1: p1.o
	gcc -o project1.exe p1.o

p1.0: p1.s
	as -o p1.o p1.s

clean:
	rm -rf project1.exe p1.o
