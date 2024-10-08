#!/usr/bin/env python

import sys
import numpy as np

if __name__ == "__main__":
    max_prime = int(sys.argv[1])
    out_file = sys.argv[2]
    all_primes = []
    for i_prime in range(2, max_prime+1):
        is_prime = True
        for j_prime in all_primes:
            if (i_prime % j_prime) == 0:
                is_prime = False
                break
        if is_prime:
            all_primes.append(i_prime)
    np.save(out_file, all_primes)
