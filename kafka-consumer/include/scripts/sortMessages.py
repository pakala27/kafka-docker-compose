#!/usr/bin/python
file = open("file-orig", "r+")
messages = sorted(list(map(int, file.readlines())))
print(messages)

with open('file-sorted', 'w') as file:
    for msg in messages:
        file.write("%i\n" % msg)