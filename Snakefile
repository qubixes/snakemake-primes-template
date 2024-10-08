configfile: "defaults.yaml"  # Configuration can be set from the command line with --config x=...

MAX_PRIME=config["max_prime"]
N_SEGMENTS=config["segments"]
SQRT_PRIME=int(MAX_PRIME**0.5)
DATA_DIR=f"data/run_{MAX_PRIME}"

def segment_start(i_segment):
    """Compute the start prime of the segment to be run in parallel."""
    return int(i_segment)*(MAX_PRIME//N_SEGMENTS)

def segment_end(i_segment):
    """Compute the end prime of the segment to be run in parallel."""
    i = int(i_segment)
    if i_segment < N_SEGMENTS - 1:
        end = (i_segment+1)*(MAX_PRIME//N_SEGMENTS)
    else:
        end = MAX_PRIME+1
    return end

# Rule to execute the whole workflow and create the density figure.
rule all:
    input:
        f"{DATA_DIR}/density.png"

# Rule to compute all primes up to sqrt(max_prime)
rule create_small:
    output:
        f"{DATA_DIR}/small_primes.npy"
    shell:
        "python small_primes.py " + str(SQRT_PRIME) + " {output}"

# Rule to find the primes in a segment, for example [0 - max_prime/10], [max_prime/10 - 2*max_prime/10]
rule create_segment:
    input:
        f"{DATA_DIR}/small_primes.npy"
    output:
        temp(DATA_DIR + "/segments/{i_segment}.npy")
    params:
        start = lambda wildcards: segment_start(wildcards.i_segment),
        end = lambda wildcards: segment_end(wildcards.i_segment)
    shell:
        "python segmented_primes.py {input} {params.start} {params.end} {output}"

# Merge the results of the segments into a single file
rule merge_primes:
    input:
        lambda wildcards: [DATA_DIR + f"/segments/{i_segment}.npy" for i_segment in range(N_SEGMENTS)]
    output:
        DATA_DIR + "/all_primes.npy"
    shell:
        f"python aggregate_primes.py {DATA_DIR}/segments " + "{output}"

# Convert the primes into a density plot.
rule plot_density:
    input:
        DATA_DIR + "/all_primes.npy"
    output:
        f"{DATA_DIR}/density.png"
    shell:
        "python plot_primes.py {input} {output}"
