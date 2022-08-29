#!/bin/sh

# config
drive_init_dir=~/Documents/Dev/data/
backup_dir=backup/booma/prod/pgdb/booma/
conn='postgresql://postgres:kZryOr%28%27%2AvM%28siJ%5EJ%27W0@139.59.83.31:5432/postgres'
x=$(date +"%y-%m-%d")
backup_file_prefix='backup'
ext='sql'

# init
backup_file_name="${backup_file_prefix}-${x}.${ext}"
backup_dir="${backup_dir}${x}/"
backup_local_dir="${drive_init_dir}${backup_dir}"
backup_drive_dir="${backup_dir}"
local_file="${backup_local_dir}${backup_file_name}"
drive_file="${backup_drive_dir}${backup_file_name}"

# changing to drive init directory
cd $drive_init_dir

# creating local directory
mkdir -p $backup_local_dir
touch $local_file # for preventing pre usage clean up of the local directory

# creating drive folder
drive new -folder $backup_drive_dir

# creating backup
pg_dump --dbname=$conn > $local_file

# pushing backup to drive
drive push -no-prompt $drive_file

# clearing local file
rm -r $backup_local_dir
find $drive_init_dir -type d -empty -delete
