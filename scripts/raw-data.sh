esearch -db sra -query PRJNA560504 | efetch --format runinfo | cut -d "," -f 1 > SraAccList.txt

# esearch command uses the ESearch utility to search on the NCBI database for query and finds the unique identifiers for all query that match the search query.
#-db database
#efetch downloads selected records in a style designated by -format

