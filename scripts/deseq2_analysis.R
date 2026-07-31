############################################################
# RNA-seq Differential Gene Expression Analysis using DESeq2
# Author: Kirtikaa Chezhian
############################################################

#############################
# Load Required Libraries
#############################

library(DESeq2)
library(airway)
library(EnhancedVolcano)
library(pheatmap)
library(matrixStats)

#############################
# Load Dataset
#############################

data(airway)

#############################
# Create DESeq Dataset
#############################

dds <- DESeqDataSet(airway, design = ~ dex)

#############################
# Run Differential Expression Analysis
#############################

dds <- DESeq(dds)

#############################
# Extract Results
#############################

res <- results(dds)

summary(res)

#############################
# Save Complete Results
#############################

dir.create("results", showWarnings = FALSE)

write.csv(
    as.data.frame(res),
    file = "results/deseq2_results.csv",
    row.names = TRUE
)

#############################
# Extract Significant Genes
#############################

sig_res <- subset(
    as.data.frame(res),
    padj < 0.05
)

write.csv(
    sig_res,
    file = "results/significant_genes.csv",
    row.names = TRUE
)

#############################
# Variance Stabilizing Transformation
#############################

vsd <- vst(dds, blind = FALSE)

#############################
# Create Figures Folder
#############################

dir.create("figures", showWarnings = FALSE)

#############################
# MA Plot
#############################

png(
    "figures/MA_plot.png",
    width = 1200,
    height = 900,
    res = 150
)

plotMA(res, ylim = c(-5,5))

dev.off()

#############################
# PCA Plot
#############################

png(
    "figures/PCA_plot.png",
    width = 1200,
    height = 900,
    res = 150
)

plotPCA(vsd, intgroup = "dex")

dev.off()

#############################
# Volcano Plot
#############################

png(
    "figures/Volcano_plot.png",
    width = 1400,
    height = 1000,
    res = 150
)

EnhancedVolcano(
    res,
    lab = rownames(res),
    x = "log2FoldChange",
    y = "padj",
    title = "Differential Gene Expression",
    pCutoff = 0.05,
    FCcutoff = 1
)

dev.off()

#############################
# Heatmap
#############################

topVarGenes <- head(
    order(
        rowVars(assay(vsd)),
        decreasing = TRUE
    ),
    50
)

mat <- assay(vsd)[topVarGenes, ]

annotation_col <- as.data.frame(
    colData(vsd)[, "dex", drop = FALSE]
)

png(
    "figures/Heatmap.png",
    width = 1200,
    height = 1000,
    res = 150
)

pheatmap(
    mat,
    scale = "row",
    annotation_col = annotation_col,
    show_rownames = FALSE,
    fontsize_col = 12,
    main = "Top 50 Most Variable Genes"
)

dev.off()

#############################
# Display Information
#############################

cat("=====================================\n")
cat("RNA-seq Analysis Completed Successfully\n")
cat("=====================================\n\n")

cat("Results saved in:\n")
cat("results/deseq2_results.csv\n")
cat("results/significant_genes.csv\n\n")

cat("Figures saved in:\n")
cat("figures/MA_plot.png\n")
cat("figures/PCA_plot.png\n")
cat("figures/Volcano_plot.png\n")
cat("figures/Heatmap.png\n")
