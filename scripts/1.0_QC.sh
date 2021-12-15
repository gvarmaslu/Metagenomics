#!/bin/bash -l

#SBATCH -A snic2021-22-148
#SBATCH -p node
#SBATCH -n 20
#SBATCH -t 10:00:00
#SBATCH -C mem256GB


module load bioinfo-tools MultiQC/1.11 FastQC/0.11.9

echo "Run script for QC"

#./1.0_QC.sh > 1.0_QC.sh.log 2>&1

#1. Raw Data QC Assessment
work_dir=/home/varma/proj/proj_oliyad/data/

mkdir -p ${work_dir}1.0_FastQC/
out_dir1=${work_dir}1.0_FastQC/

mkdir -p ${work_dir}1.1_MultiQC/
out_dir2=${work_dir}1.1_MultiQC/

cd ${work_dir}

for f in $(find ./ -type f -name "*1.fq*"); do

sample=$(basename ${f/_1.fq.gz/})
DIR=$(dirname $f)

echo "Sample_filepath:" ${DIR}
echo "Sample_ID:" ${sample}

####
#Command to run fastqc
nice -n 5 find ${DIR} -name '*.gz' | xargs fastqc -o ${out_dir1} -t 20

done

####
# Command to run multiqc on FastQC files

multiqc ${out_dir1} -o ${out_dir2}

####

echo "Done QC script..."
