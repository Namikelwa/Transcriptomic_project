#RNA-seq analysis with DESeq2

#Loading required packages

library(DESeq2)
library(limma)
library(edgeR)
library(Biobase)


# Import & pre-process

# Import data from HTseq-counts
countdata <- read.table("counts.txt", header=TRUE, row.names=1)

# Remove the last five rows
countdata <- countdata[ ,6:ncol(countdata)]


# Convert to matrix
countdata <- as.matrix(countdata)
head(countdata)

# Assign condition (first two are controls, last two are exposed)
condition <- factor(c(rep("ctl", 2), rep("exp", 2)))

# Analysis with DESeq2

library(DESeq2)

# Create a coldata frame 
coldata <- data.frame(row.names=colnames(countdata), condition)
# Generating deseq object

dds <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~condition)
dds

# Run the DESeq pipeline
dds <- DESeq(dds)

# Plot dispersions
png("qc-dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

# Regularized log transformation for clustering/heatmaps, etc
rld <- rlogTransformation(dds)
head(assay(rld))
hist(assay(rld))


# Sample distance heatmap
sampleDists <- as.matrix(dist(t(assay(rld))))
library(gplots)
png("qc-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[condition], RowSideColors=mycols[condition],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()

# Principal components analysis
plotPCA(rld, intgroup=c("condition"))



