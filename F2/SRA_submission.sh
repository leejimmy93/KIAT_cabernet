#!/bin/bash
cd /share/malooflab/Fastqs/KIAT/Parent

HOST=ftp-private.ncbi.nlm.nih.gov
USER=subftp
PASSWORD=w4pYB9VQ

ftp -inv $HOST <<EOF
user $USER $PASSWORD

cd uploads/leejimmy93@yahoo.com_u3M3na2m/Li-eQTL-TAG-2018
put 05-11-Final-8ul_1.fq.gz 

bye 
EOF


