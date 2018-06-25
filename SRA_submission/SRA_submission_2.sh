#!/bin/bash 

cd 
source .bash_profile

# parent 
ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/Parent/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

# F2 
# batch B
ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_B/Sample_*/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

# batch C 
ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_*/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

