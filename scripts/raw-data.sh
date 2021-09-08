# Getting accession numbers from NCBI

esearch -db sra -query PRJNA560504 | efetch --format runinfo | cut -d "," -f 1 > SraAccList.txt

# esearch command uses the ESearch utility to search on the NCBI database for query and finds the unique identifiers for all query that match the search query.
#-db database
#efetch downloads selected records in a style designated by -format

# Downloading the data
mkdir raw-data
cd raw-data
for i in $(cat …/SraAccList.txt);    #SraAcclis.txt contains a list of the accesion numbers
do
    echo $i
    fastq-dump --gzip --split-files $i  #fastq-dump gets data in fastq format
done


