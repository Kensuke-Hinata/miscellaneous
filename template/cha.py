#coding: utf-8

import random


print(random.random())

print(ord('a'))
ct = ''
for i in range(26):
    ct = ct + chr(65 + i)
print(ct)

print(ord('A'))
ct = ''
for i in range(26):
    ct = ct + chr(97 + i)
print(ct)

L = []
n = 100
m = 26
for i in range(n):
    item = []
    for j in range(5):
        i = random.randint(0, 25)
        item.append(ct[i])
    L.append(''.join(item))
print(' '.join(L))

L = []
n = 100
m = 12345678910000000
for i in range(n):
    num = random.randint(0, m)
    L.append(num)

random.shuffle(L)

for i in range(n):
    L[i] = str(L[i])

print(' '.join(L))

c = random.sample(L, n - 10)
print(' '.join(c))

L = []
n = 100
for i in range(n):
    num = random.uniform(2, 10)
    L.append(num)

for i in range(n):
    L[i] = str(L[i])

print(' '.join(L))
