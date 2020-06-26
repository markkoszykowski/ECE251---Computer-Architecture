all: project2

project2: p2.o
	gcc -o project2.exe p2.o

p2.o: p2.s
	as -o p2.o p2.s

clean:
	rm -rf project2.exe p2.o sorted.txt
