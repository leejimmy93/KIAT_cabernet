#!/bin/bash

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
file=`cat sample_list_mapping_47_Samples`

for i in $file
	do
	mkdir $i
done
