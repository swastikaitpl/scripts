#!/bin/sh

backup_dir=~/Documents/Dev/data/Backup/
x=$(date +"%y-%m-%d")

# creating directory
backup_dir="${backup_dir}${x}/"
mkdir $backup_dir

# creating backup
x="${backup_dir}backup-${x}.sql"
pg_dump --dbname='postgresql://postgres:root%40123@139.59.83.31:5432/postgres' > $x
