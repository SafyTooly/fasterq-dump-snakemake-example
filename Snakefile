ACCS = ["SRR2467340", "SRR2467341", "SRR2467342", "SRR2467343", "SRR2467344"]


rule all:
    input:
        expand("results/fastq/{a}_{R}.fastq", a = ACCS, R = [1, 2])


rule get_fastq_pe:
    output:
        # the wildcard name must be accession, pointing to an SRA number
        "results/fastq/{accession}_1.fastq",
        "results/fastq/{accession}_2.fastq",
    log:
        "results/logs/get_fastq_pe/{accession}.log"
    params:
        extra="--skip-technical"
    threads: 1  # defaults to 6
    resources:
        time="01:00:00"
    conda:
        "sra-tools.yaml"
    shell:
        "fasterq-dump --threads 1 --skip-technical -O $(dirname {output[0]})  {wildcards.accession}"
