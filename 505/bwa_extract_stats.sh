#!/bin/bash

echo Collecing names of all samples

cd /share/malooflab/Ruijuan/505/WGS/mapping_cabernet
files=`cat sample_list_mapping`
#echo $files
echo `wc -w <<< $files` Directories found

awk 'BEGIN { print "Sample\tNumber_Mapped\tNumber_Unique_Mapped" }' > BWA_Stats.tab

for i in $files
    do
    echo Extracting mapping stats from stats file in ${i}
    if [ -f ${i}/${i}.stats ]
        then
            echo ${i} > BWA.temp.0
            cat ${i}/${i}.stats | head -5 | tail -1| awk '{print $5}' | sed 's/(//g' | sed 's/%//g' > BWA.temp.1
            cat ${i}/final.stats | head -1 | awk '{print $1}' > BWA.temp.2
            paste BWA.temp.0 BWA.temp.1 BWA.temp.2 > BWA.temp
            cat BWA.temp >> BWA_Stats.tab
    else
        echo Error, stats file not found in ${i}
    fi
done

rm BWA.temp*
echo BWA_Stats.tab has been created
