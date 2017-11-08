#!/bin/bash

sample=`cat sample_list | sed s/\.R//g`

for i in $sample
	do
	print i 
	grep -v "name" ${i}.R > ${i}_new.R
done
