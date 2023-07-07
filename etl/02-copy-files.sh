#!/bin/bash

# edit credentials in config.sh as necessary

source ./config.sh


# this is a fix: laakeaine.txt sometimes contains empty lines which must be removed
sed -i '/^$/d' $INPUTDIR/laakeaine.txt

# insert schema and inputdir from config

cp copy-files-template.sql copy-files.sql

sed -i 's/{SCHEMA}/'"$SCHEMA"'/g' copy-files.sql

sed -i 's/{INPUTDIR}/'"$INPUTDIR"'/g' copy-files.sql



# merge pakkaus and pakkaus_m

PGPASSWORD=$PGPASSWORD psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -a -f copy-files.sql



rm copy-files.sql
