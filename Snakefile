"""

"""
configfile: "config.yaml"
scriptsfolder="scripts"

#runs the pipeline
rule all:
    """

    """
    input:
        #dynamic(out_folder + "/{art}/{{leaves}}_{haplotype}.fq",haplotype=["0", "1"],art=art_out)
        config['folder'] + "/" + config['name'] + ".bam",
        config['folder'] + "/" + config['name'] + ".bam.bai"

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
