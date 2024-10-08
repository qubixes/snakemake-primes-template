#!/usr/bin/env python
import sys
from pathlib import Path
import numpy as np


if __name__ == "__main__":
    seg_dir = sys.argv[1]
    out_file = sys.argv[2]

    data = []
    for seg_file in Path(seg_dir).glob("*"):
        data.append(np.load(seg_file))
        # with open(seg_file, "r", encoding="utf-8") as handle:
            # data.append(handle.read())

    all_primes = np.concatenate(data)
    all_primes.sort()
    np.save(out_file, all_primes)
    # all_primes = sorted(int(x) for x in (" ".join(data)).split(" "))
    # with open(out_file, "w", encoding="utf-8") as handle:
        # handle.write(" ".join(str(x) for x in all_primes))
