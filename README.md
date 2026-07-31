# RNA-seq Differential Gene Expression Analysis using DESeq2

## Project Overview

This project demonstrates a complete RNA-seq differential gene expression (DGE) analysis workflow using the DESeq2 package in R. The analysis was performed on the Bioconductor `airway` dataset to identify genes that are differentially expressed between treated and untreated samples.

## Objectives

- Perform differential gene expression analysis.
- Identify significantly differentially expressed genes.
- Visualize gene expression patterns.
- Generate publication-quality figures.

## Workflow

1. Quality Control (FastQC)
2. Read Trimming (Trimmomatic)
3. Read Alignment (HISAT2)
4. BAM Processing (SAMtools)
5. Gene Quantification (featureCounts)
6. Differential Expression Analysis (DESeq2)
7. Data Visualization
8. Export Results

## Software

- Ubuntu (WSL)
- R 4.5.2
- Bioconductor 3.22
- DESeq2
- EnhancedVolcano
- pheatmap

## Results

- Dataset: Airway
- Samples: 8
- Genes analyzed: 63,677
- Significant genes (padj < 0.05): 2,700

## Output

### Figures

- MA Plot
- PCA Plot
- Volcano Plot
- Heatmap

### Result Files

- deseq2_results.csv
- significant_genes.csv

