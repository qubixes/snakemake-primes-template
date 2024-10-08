#!/usr/bin/env python

import sys
import numpy as np

if __name__ == "__main__":
    max_prime = int(sys.argv[1])
    out_file = sys.argv[2]
    cur_primes = []
    for i in range(2, max_prime):
        prime = True
        for test_prime in cur_primes:
            if (test_prime)**0.5 > i:
                break
            if i%test_prime == 0:
                prime = False
                break
        if prime:
            cur_primes.append(i)

    np.save(out_file, cur_primes)
    # print(" ".join(str(x) for x in cur_primes))
