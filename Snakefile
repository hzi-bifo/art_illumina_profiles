# The main entry point of your workflow.
# After configuring, running snakemake -n in a clone of this repository should successfully execute a dry-run of the workflow.

import os
from urllib.parse import urlparse

configfile: "config.yaml"

# extract sample name from bam download link, by stripping any query strings
# from the end of the link and then removing leading path and trailing extension
sample_name =   os.path.splitext(
                    os.path.basename(
                        urlparse(
                            config['input']['bam']
                        ).path
                    )
                )[0]


rule all:
    """
    Final output of the pipeline.
    """
    input:
        # The first rule should define the default target files
        # Subsequent target rules can be specified below. They should start with all_*.
        "profiles/" + sample_name + ".1.txt",
        "profiles/" + sample_name + ".2.txt"

rule art_profiler_illumina:
    """
    Runs the art illumina profiler on downloaded/converted data
    """
    input:
        "reads/{file}.fq",
    output:
        "profiles/{file}.txt"
    log:
        "logs/art_profiler_illumina/{file}.log"
    params: ""
    threads: 2
    wrapper:
        "0.31.0/bio/art/profiler_illumina"


rule samtools_bam2fq_separate:
    """
    Converts the downloaded bam-file to fastq using samtools.
    """
    input:
        "input/{sample}.bam"
    output:
        "reads/{sample}.1.fq",
        "reads/{sample}.2.fq"
    params:
        sort = "-m 4G",
        bam2fq = "-n"
    threads: 3
    wrapper:
        "0.31.0/bio/samtools/bam2fq/separate"


rule download_bam_bai:
    """
    Download bam file and its index (bai).
    """
    output:
        bam = "input/{sample}.bam",
        bai = "input/{sample}.bam.bai"
    log:
        "logs/download_bam_bai/{sample}.log"
    conda:
        "envs/wget.yaml"
    params:
        bam = config['input']['bam'],
        bai = config['input']['bai']
    shell:
        "( wget --verbose -O {output.bai} {params.bai}; "
        "  wget --verbose -O {output.bam} {params.bam}; "
        " ) 2> {log}"
