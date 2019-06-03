#coding: utf-8

import random

n = 10
m = 1000000001

L = []

for i in range(n * n):
    num = random.randint(0, m)
    L.append(num)

for i in range(n * n):
    x = i / n
    y = i % n
    L[y * n + x] = L[i]

for i in range(n):
    L[i * n + i] = 0

for i in range(n * n):
    x = i / n
    y = i % n

for i in range(n * n):
    L[i] = str(L[i])

for i in range(n):
    a = []
    for j in range(n):
        a.append(L[i * n + j])
    print ' '.join(a)

print('')

print ' '.join(L)
