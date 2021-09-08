# Creating genome index

STAR --runThreadN 6  # number of threads\
    --runMode genomeGenerate \
    --genomeDir ./starr #path to store genome indices\
    --genomeFastaFiles VectorBase-53_AgambiaePEST_Genome.fasta \
    --sjdbGTFfile VectorBase-53_AgambiaePEST.gff \
    --sjdbOverhang 99 #readlength-1 --sjdbGTFtagExonParentTranscript gene
# Mapping reads to genome

mkdir alignments
for i in $(cat SraAcclist.txt);
do
    STAR --genomeDir starr \
    --readFilesIn  ${i}_1.fastq.gz ${i}_2.fastq.gz\
    --readFilesCommand zcat  \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode GeneCounts \
    --outFileNamePrefix alignments/${i}
done
#zcat decompress the files


