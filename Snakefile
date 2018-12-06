"""

"""
configfile: "config.yaml"
scriptsfolder="scripts"

rule all:
    """
    Runs the pipeline
    """
    input:
        config['profile'] + ".txt"

rule download_HiSeq:
    """
    download bam file and its index
    """
    output:
        bam = config['folder'] + "/" + config['name'] + ".bam",
        index = config['folder'] + "/" + config['name'] + ".bam.bai"
    params:
        bam = config['input']['bam'],
        bai = config['input']['bai']
    shell:
        "python3 download_bam_bai.py --obam {output.bam} --obai {output.index} --bamlink {params.bam} --bailink {params.bai}"

rule convert_to_fastq:
    """
    Converts the downloaded bam-file to fastq using samtools
    """
    input:
        "{filename}.bam"
    output:
        "{filename}.fq"
    shell:
        "samtools bam2fq {input} > {output}"

rule art_profiler:
    """
    Runs the art illumina profiler on downloaded/converted data

    art_profiler_illumina
        output_profile_name
        input_fastq_dir
        fastq_filename_extension
        [max_number_threads]
    """
    input:
        config['folder'] + "/" + config['name'] + ".fq"
    output:
        config['profile'] + ".txt"
    shell:
        "art_profiler_illumina " + config['profile'] + " " + config['folder'] + " fq"
