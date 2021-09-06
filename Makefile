# Makefile for icc ifort 

.PHONY: all modules clean

#FLAGS = -g -O3
FLAGS = -openmp -heap-arrays 64 -O3
CC = icc
FC = ifort

objects = sockets.o fsockets.o interface.o main.o
all: client.x

sockets.o: sockets.c 
	$(CC) -c sockets.c 

client.x: $(objects)
	$(FC) $(FLAGS) -o client.x $(objects)

%.o: %.f90
	$(FC) $(FLAGS) -c $< 

clean:
	rm -f *.o *.mod *.x
