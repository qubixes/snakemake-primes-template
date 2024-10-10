configfile: "defaults.yaml"  # Configuration can be set from the command line with --config x=...

MAX_PRIME=config["max_prime"]
N_SEGMENTS=config["segments"]
SQRT_PRIME=...
DATA_DIR=...

def segment_start(i_segment):
    """Compute the start prime of the segment to be run in parallel."""
    ...

def segment_end(i_segment):
    """Compute the end prime of the segment to be run in parallel."""
    ...

# Rule to execute the whole workflow and create the density figure.
rule all:
    input:
        DATA_DIR + "/density.png"

# Rule to compute all primes up to sqrt(max_prime)
rule create_small:
    output:
        # Some .npy file here
    shell:
    # small_primes.py takes two arguments: max_prime and output file

# Rule to find the primes in a segment, for example [0 - max_prime/10], [max_prime/10 - 2*max_prime/10]
rule create_segment:
    input:
        ...
    output:
        # You can use wildcards here to create segment with number i_segment.
        # You can make these files temporary so they will get deleted when the run is over.
    params:
        start = ..., # It can be useful to create params that are then used in the shell
        end = ... # End of the segment
    shell:
        "./segmented_primes.py {input} {params.start} {params.end} {output}"

# Merge the results of the segments into a single file
rule merge_primes:
    input:
        # Here we need to get all segment files, use lambda functions for example
    output:
        # The aggregated file
    shell:
        # Script aggregated_primes.py takes the segments directory + output file.

# Convert the primes into a density plot.
rule plot_density:
    # Look at the plot_primes.py script.
