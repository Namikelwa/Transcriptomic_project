#Getting reads mapped to each feature
htseq-count -t exon -i gene_id -f bam *._hisat_sorted.bam  VectorBase-53_AgambiaePEST.gff > htseq/counts.txt
