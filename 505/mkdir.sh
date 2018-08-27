#!/bin/bash

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
file=`cat sample_list_mapping`

for i in $file
	do
	mkdir $i
done
