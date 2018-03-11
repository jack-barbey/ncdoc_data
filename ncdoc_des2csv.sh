#!/bin/bash
set -e

# download the raw file, unzip and process
#
# raw files are fixed width and come with definition files.
# convert those definition files into in2csv format then
# run in2csv to save in csv format.
# 
# Inputs:
#  1) directory to store raw and processed files
#  2) the NCDOC file name


ETL_DIRECTORY=$1

ZIPFILE=$2
FILE_NO_EXTENSION="${ZIPFILE%.zip}"

URL="http://www.doc.state.nc.us/offenders"

# download the file
wget -N \
     -P "$ETL_DIRECTORY" \
     "$URL"/"$ZIPFILE"

# unzip
unzip -o \
      -d "$ETL_DIRECTORY" \
      "$ETL_DIRECTORY"/"$ZIPFILE"

# create schema file
echo 'column,start,length' > "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION"_schema.csv
sed -E 's/[ ]{2,}/,/g' "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION".des | \
grep -vE "^Name," | \
cut -d',' -f1,4-5 >> "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION"_schema.csv

# do the conversion 
in2csv -s "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION"_schema.csv \
       "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION".dat | \
tr -d '?' > "$ETL_DIRECTORY"/"$FILE_NO_EXTENSION".csv

