#! /usr/bin/python

from math import sqrt
import matplotlib.pyplot as plot

Es = 1
fd = 2
N = 20
fo = 1

def fi(j):
    return (j - (N+1)/2.) * 2 * fo / N

def var(j):
    return Es/sqrt(fd**2 - fi(j)**2)

i = range(1, N+1)
v = [var(j) for j in i]
print [fi(j) for j in i]

plot.plot(i, v)
plot.show()
