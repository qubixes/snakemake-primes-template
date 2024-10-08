#!/usr/bin/env python

import sys
import numpy as np
from matplotlib import pyplot as plt

if __name__ == "__main__":
    prime_file = sys.argv[1]
    fig_file = sys.argv[2]

    primes = np.load(prime_file)
    # with open(prime_file, "r", encoding="utf-8") as handle:
        # primes = [int(x) for x in handle.read().split(" ")]

    n_plot = 100
    split_arrays = np.array_split(primes, min(len(primes), n_plot))
    delta = [split_arrays[0][-1]] + [split_arrays[i][-1] - split_arrays[i-1][-1]
             for i in range(1, len(split_arrays))]
    num_primes = [len(x) for x in split_arrays]
    mean_primes = [np.mean(x) for x in split_arrays]

    plt.plot(mean_primes, np.array(num_primes)/np.array(delta))
    plt.savefig(fig_file)
