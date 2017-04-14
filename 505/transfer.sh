#!/bin/bash 

cd /share/malooflab/Ruijuan/505/late_silique/raw_data/bioftp.org/TBD170136_20170317/bioftp.org/TBD170136_20170317

sample=`ls | grep "Sample" | sed 's/\///g'`
echo $sample

for i in $sample 
	do
	echo ${i}

#	scp ${i}/Log.final.out ruijuanli@whitney.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/505/data/late_silique/${i}

	scp ${i}/Aligned.sortedByCoord.out.bam ruijuanli@whitney.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/505/data/late_silique/${i}

done
