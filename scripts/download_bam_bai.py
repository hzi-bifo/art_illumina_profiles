"""
This script downloads bam and bai files according to the links

    $ download_bam_bai.py
    --obam {output.bam}
    --obai {output.index}
    --bamlink {params.bam}
    --bailink {params.bai}
"""

import wget
import argparse
import os

server = "http://rest.ensembl.org"

parser = argparse.ArgumentParser()
parser.add_argument('--obam', action='store', help='Name of stored bam file');
parser.add_argument('--obai', action='store', help='Name of stored bai file');
parser.add_argument('--bamlink', action='store', help='FTP-link to bam file');
parser.add_argument('--bailink', action='store', help='FTP-link to bai file');
params = parser.parse_args();

bai_directory = os.path.dirname(params.obai)
if not os.path.exists(bai_directory):
    os.makedirs(bai_directory)

wget.download(params.bailink, params.obai)

bam_directory = os.path.dirname(params.obam)
if not os.path.exists(bam_directory):
    os.makedirs(bam_directory)
wget.download(params.bamlink, params.obam)
