#!/usr/bin/env python

import sys

import numpy as np

if __name__ == "__main__":
    small_prime_fp = sys.argv[1]
    start_segment = int(sys.argv[2])
    end_segment = int(sys.argv[3])
    out_file = sys.argv[4]

    small_primes = np.load(small_prime_fp)
    # with open(small_prime_fp, "r", encoding="utf-8") as handle:
        # small_primes = [int(x) for x in handle.read().split(" ")]

    if start_segment == 0:
        primes_extra = small_primes
        start_segment = small_primes[-1] + 1
    else:
        primes_extra = []

    is_prime = np.ones(end_segment-start_segment, dtype=np.int32)
    for cur_prime in small_primes:
        if cur_prime**2 > end_segment:
            break
        start = (cur_prime - start_segment%cur_prime)%cur_prime
        end = end_segment-start_segment
        is_prime[start:end:cur_prime] = 0

    prime_array = np.where(is_prime == 1)[0] + start_segment
    primes_found = np.concatenate((primes_extra, prime_array))
    np.save(out_file, primes_found)
    # print(" ".join(str(int(x)) for x in primes_found))
