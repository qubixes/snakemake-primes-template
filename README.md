# Sieve of Eratosthenes prime computation with SnakeMake

This repository is a template for computing the primes up to any number (given enough time and memory). This is done using the Sieve of Eratosthenes algorithm see [Wikipedia](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes). The aim of this repository is to introduce some of the more basic features of SnakeMake. The `Snakefile` file is incomplete and the exercise is to complete it to find the primes. Documentation for snakemake on writing rules is available [here](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html).

## Overview of the repository

- `bruteforce.py $max_prime $out_file`: Compute the primes in the most bruteforce way.
- `small_primes.py $max_prime $out_file`: Compute primes in a slightly less bruteforce way.
- `segmented_primes.py $small_primes_file $start_segment $end_segment $out_file`: Compute primes with Erathosthenes seive, but over a segment.
- `aggregate_primes.py $segment_dir $out_file`: Aggregate the segments into a single file.
- `plot_primes.py $primes_file`: Plot the prime density.
- `Snakefile`: The workflow file that you need to edit.
- `defaults.yaml`: A file with default max_prime and segments.
- `run_workflow_bash.sh`: This file is how the workflow looks like in bash without parallelization.

## Steps into getting a working workflow

### Step 1: Install Snakemake

It is recommended to install snakemake into a conda environment, although snakemake will also work with a native Python installation. Installation instruction are on the Snakemake [website](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html). In addition install matplot:

```sh
conda install matplotlib numpy
```

### Step 2: Copy/clone this repository

You can of course create your own workflow from scratch, but since we will probably not have enough time, the scripts to run the individual tasks are already present, see the overview above on what they do.

### Step 3: Edit the `Snakefile`

The `Snakefile` is similar to a `Makefile` for those familiar with it. There is already a skeleton so that you don't have to look through the whole documentation. Fill in the blanks of this skeleton to make the workflow run.

### Step 4: Run the workflow

To run the workflow for a maximum prime of 1 million with 4 cores, type the following on the command line:

```sh
snakemake --cores 4 --config max_prime=1000000
```

The results should be in the directory that you have chosen (`density.png`)
