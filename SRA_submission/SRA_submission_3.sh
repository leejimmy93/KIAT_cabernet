#!/bin/bash 

# ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_186/186_1.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

# ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/186_1.fq subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

# ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_186/186_2.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018

ascp -i /home/ruijuanli/.aspera/connect/etc/aspera.openssh -QT -l100m -k1 -d /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_*/*.fq.gz subasp@upload.ncbi.nlm.nih.gov:uploads/leejimmy93@yahoo.com_upMAz9xu/Li-eQTL-TAG-2018
