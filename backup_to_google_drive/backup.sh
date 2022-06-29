#!/bin/sh

# has to placed in the same directory as the init directory of the drive tool

backup_dir=~/Documents/Dev/data/Backup/
backup_drive_dir=Backup/
x=$(date +"%y-%m-%d")

# creating directory
backup_dir="${backup_dir}${x}/"
mkdir $backup_dir

# creating drive folder
backup_drive_dir="${backup_drive_dir}${x}/"
drive new -folder $backup_drive_dir

# creating backup
file="${backup_dir}backup-${x}.sql"
pg_dump --dbname='postgresql://postgres:root%40123@139.59.83.31:5432/postgres' > $file

# pushing backup to drive
drive_file="${backup_drive_dir}backup-${x}.sql"
drive push -no-prompt $drive_file
