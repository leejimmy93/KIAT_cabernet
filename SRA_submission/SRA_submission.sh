#!/bin/bash 

cd 
source .bash_profile
# ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_A/Sample_1/1_1.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu

# parent 
# ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/Parent/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu

# F2 
# batch A
ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_A/Sample_*/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

