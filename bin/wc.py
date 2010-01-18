#!/usr/bin/python
import sys
def count(fn):
    f = open(fn)
    lines = 0
    chars = 0
    try:
        for line in f:
            lines += 1
            chars += len(line)
    finally:
        f.close()
    print "Total line: %d" % lines
    print "Total chars: %d" % chars

if __name__=="__main__":
    count(sys.argv[1])

