#!/bin/bash

#SBATCH -o test/test.out
#SBATCH -e test/test.err
#SBATCH -J test
#SBATCH -p master-worker
#SBATCH -t 120:00:00

# Setup test directory
mkdir -p tests/ tests/input

# Download input data
mkdir -p tests tests/input

URL="https://raw.githubusercontent.com/genomictools/test-datasets/refs/heads/test-gene-burden"
wget -c $URL/cohorts_info.csv -O tests/input/cohorts_info.csv
wget -c $URL/general.categoryA.aggregate.tsv -O tests/input/general.categoryA.aggregate.tsv
wget -c $URL/general.categoryB.aggregate.tsv -O tests/input/general.categoryB.aggregate.tsv
wget -c $URL/pheno.categoryA.aggregate.tsv -O tests/input/pheno.categoryA.aggregate.tsv
wget -c $URL/pheno.categoryB.aggregate.tsv -O tests/input/pheno.categoryB.aggregate.tsv

cd tests/

# Run nextflow
module load Nextflow

# nextflow run houlstonlab/test-gene-burden -r test-gh \
nextflow run ../main.nf \
    --output_dir ./results/ \
    -profile local,gha \
    -resume

# usage: nextflow run [ local_dir/main.nf | git_url ]  
# These are the required arguments:
#     -r            {main,dev,gha} to run specific branch
#     -profile      {local,cluster} to run using differens resources
#     -params-file  params.json to pass parameters to the pipeline
#     -resume       To resume the pipeline from the last checkpoint
