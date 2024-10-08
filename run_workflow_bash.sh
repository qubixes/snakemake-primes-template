#!/usr/bin/bash

if [[ $# -ge 1 ]]; then
    MAX_PRIME=$1
else
    MAX_PRIME=10000000
fi

SQRT_PRIME=$(bc <<< "scale=0; sqrt(${MAX_PRIME})")

RUN_FOLDER="data/run_${MAX_PRIME}"
mkdir -p $RUN_FOLDER
./small_primes.py $SQRT_PRIME "$RUN_FOLDER/small_primes.npy"
N_SEG=10
SEG_DIR="$RUN_FOLDER/segments"
mkdir -p $SEG_DIR
for I_SEGMENT in $(seq $N_SEG); do
    let "START=(I_SEGMENT-1)*MAX_PRIME/N_SEG"
    let "END=I_SEGMENT*MAX_PRIME/N_SEG"
    if [[ $I_SEGMENT -eq $N_SEG ]]; then
        let END=MAX_PRIME+1
    fi
    OUT_FILE="$SEG_DIR/${START}_${END}.npy"
    ./segmented_primes.py "$RUN_FOLDER/small_primes.npy" $START $END $OUT_FILE
done

./aggregate_primes.py $SEG_DIR $RUN_FOLDER/all_primes.npy
./plot_primes.py $RUN_FOLDER/all_primes.npy $RUN_FOLDER/density.png
