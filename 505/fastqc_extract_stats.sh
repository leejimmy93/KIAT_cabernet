#!/bin/bash

echo Collecing names of all samples

cd /share/malooflab/Ruijuan/505/WGS/QC_47_Samples/raw
files=`ls | grep -v "zip" | grep -v "html"`
#echo $files
echo `wc -w <<< $files` Directories found

awk 'BEGIN { print "Sample\tNumber_Reads" }' > FastQC_Stats.tab

for i in $files
    do
    echo Extracting stats from stats file in ${i}
    if [ -f ${i}/fastqc_data.txt ]
        then
            echo ${i} > FastQC.temp.0
            cat ${i}/fastqc_data.txt | grep "Total Sequences" | awk '{print $3}' > FastQC.temp.1
            paste FastQC.temp.0 FastQC.temp.1 > FastQC.temp
            cat FastQC.temp >> FastQC_Stats.tab
    else
        echo Error, stats file not found in ${i}
    fi
done

rm FastQC.temp*
echo FastQC_Stats.tab has been created
