# Snakemake workflow: art_illumina_profiles

[![Snakemake](https://img.shields.io/badge/snakemake-≥5.3.0-brightgreen.svg)](https://snakemake.bitbucket.io)
[![Build Status](https://travis-ci.org/snakemake-workflows/art_illumina_profiles.svg?branch=master)](https://travis-ci.org/snakemake-workflows/art_illumina_profiles)

Snakemake workflow to generate `art_illumina` profiles from public, downloadable datasets.

## Authors

* David Laehnemann (@dlaehnemann), Victoria Sack (@VSack)

## Usage

### Step 1: Install conda and Snakemake

Install conda and set up the channels [as described for bioconda](https://bioconda.github.io/#using-bioconda), we recommend using miniconda3 or higher. If you have conda already installed on your system, make sure that it is updated to version 4.5.12 (or higher). You can update conda with `conda update -n base conda`(miniconda3) or `conda update -n root conda` (miniconda2).

Once set up, use it to create an environment for running snakemake pipelines

    conda create -n snakemake snakemake conda

This environment requires the availability of the conda command, as this workflow uses [Snakemake wrappers](https://snakemake-wrappers.readthedocs.io/en/stable/).

### Step 2: Install workflow

If you simply want to use this workflow, download and extract the [latest release](https://github.com/snakemake-workflows/art_illumina_profiles/releases).
If you intend to modify and further develop this workflow, fork this repository. Please consider providing any generally applicable modifications via a pull request.

In any case, if you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this repository and, if available, its DOI (see above).

### Step 3: Configure workflow

Configure the workflow according to your needs via editing the file `config.yaml`.

### Step 4: Execute workflow

First, activate your snakemake environment with (deactivate later with `conda deactivate`)

    conda activate snakemake

You can then test your configuration by performing a dry-run via

    snakemake -n

Execute the workflow locally via

    snakemake --cores $N --use-conda

using `$N` cores or run it in a cluster environment via

    snakemake --cluster qsub --jobs 100 --use-conda

or

    snakemake --drmaa --jobs 100 --use-conda

See the [Snakemake documentation](https://snakemake.readthedocs.io) for further details.
