#!/bin/sh

# config
#src_type=booma
#src_type=plcampus
src_type=plcampusfrontend
#type=live
type=dev
#booma
if [ "booma" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/root/BoomaDeploy/
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/booma/BoomaDeploy/
  fi
  src_root=~/Documents/Dev/java/Booma/booma/
  target_jar="booma-0.0.1-SNAPSHOT"
fi
#plcampus
if [ "plcampus" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/root/PlCampusDeploy/
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusDeploy/
  fi
  src_root=~/Documents/Dev/java/plcampus/institute-college/
  target_jar="college-0.0.1-SNAPSHOT"
fi
#plcampusfrontend
if [ "plcampusfrontend" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/root/PlCampusFrontEndDeploy/
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusFrontEndDeploy/
  fi
  src_root=~/Documents/Dev/node/pl-campus-spring/
  target_jar="ReactApplication-0.0.1-SNAPSHOT"
fi
#dev
if [ "dev" == "$type" ]; then
  ssh_key=~/Documents/Dev/text/squares/ssh/booma-dev/booma-dev
  deploy_user=root
  deploy_host=134.209.155.33
  ssh_port=22
fi
#live
if [ "live" == "$type" ]; then
  ssh_key=~/Documents/Dev/text/squares/ssh/booma-prod/booma-prod
  deploy_user=booma
  deploy_host=146.190.10.12
  ssh_port=59318
fi

# init
target_jar="${src_root}target/${target_jar}.jar"
deploy_jar="${deploy_dir}deploy.jar"
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"
deploy_script="bash ${deploy_dir}restart.sh"

# packaging
cd $src_root
mvn package

# uploading
scp -i $ssh_key -P $ssh_port $target_jar $scp_deploy_prefix$deploy_jar

# restarting
ssh -i $ssh_key -p $ssh_port  $deploy_domain $deploy_script
