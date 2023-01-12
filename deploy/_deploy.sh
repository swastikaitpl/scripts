#!/bin/sh

# config
src_type=booma
#src_type=plcampus
#src_type=plcampusfrontend
type=live
#type=dev

booma_src_root=~/Documents/Dev/java/Booma/booma/
booma_target_jar="booma-0.0.1-SNAPSHOT"
plcampus_src_root=~/Documents/Dev/java/plcampus/institute-college/
plcampus_target_jar="college-0.0.1-SNAPSHOT"
plcampusfrontend_src_root=~/Documents/Dev/node/pl-campus-spring/
plcampusfrontend_target_jar="ReactApplication-0.0.1-SNAPSHOT"

dev_ssh_key=~/Documents/Dev/text/squares/ssh/booma-dev/booma-dev
live_ssh_key=~/Documents/Dev/text/squares/ssh/booma-prod/booma-prod

. $(dirname $0)/deploy.sh
