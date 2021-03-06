#!/bin/bash 

cd /share/malooflab/Ruijuan/505/WGS/depth
sample=`echo chrA08`

for i in $sample
	do
	echo $i
	awk '{for(i=3;i<=NF;i++)x+=$i;print x; x=0}' ${i}.depth > sum.${i} 
	awk '{print $1, $2}' ${i}.depth > loc.${i}
	paste loc.${i} sum.${i} > ${i}.sum

rm loc.${i} 
rm sum.${i}
done 
