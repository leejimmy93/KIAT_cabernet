#!/bin/bash 

cd /share/malooflab/Ruijuan/505/WGS/depth
sample=`echo chrA01`

for i in $sample
	do
	echo $i
	awk '{for(i=3;i<=NF;i++)x+=$i;print x; x=0}' ${i}.depth > sum 
	awk '{print $1, $2}' ${i}.depth > loc
	paste loc sum > ${i}.sum
done 
