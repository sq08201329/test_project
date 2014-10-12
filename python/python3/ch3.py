x = list(zip((1, 3, 1, 3), ("parm", "dorie", "kayak", "canoe")))
print(x)
print(sorted(x))


def swap(t):
    return t[1], t[0]

print(sorted(x, key=swap))

songs = ["because", "Boys", "Carol"]
beatles = songs[:]

beatles[2] = "sunqi"
print(songs, beatles)

import copy
s = {1, 2, 4}
d = {1: 2, 2: 4, 4: 8}
s1 = copy.copy(s)
d1 = copy.copy(d)
print(s1, d1)
s1.add('sunqi')
d1[1] = 'sunqi'
print(s1, d1)
