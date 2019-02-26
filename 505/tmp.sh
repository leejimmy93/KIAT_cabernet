#!/bin/bash 

file=`cat sample_list`
cd /share/malooflab/Ruijuan/505/WGS/mapping_STAR/finished_176
for i in $file
	do
	echo $i
	mkdir $i
	mv ../$i/* $i/
	mv ../STAR95/$i/* $i/
done
