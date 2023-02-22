#!/bin/sh

if [[ -z "$src_type" ]]; then
  echo "src type is required."
  exit 1
fi
if [[ -z "$type" ]]; then
  echo "type is required."
  exit 1
fi

if [ ! "booma"  == "$src_type" ] && [ ! "plcampus"  == "$src_type" ] && [ ! "plcampusfrontend"  == "$src_type" ]; then
  echo "src type is invalid."
  exit 1
fi
if [ ! "dev" == "$type" ] && [ ! "live" == "$type" ]; then
  echo "type is invalid."
  exit 1
fi

#booma
if [ "booma" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/home/booma/BoomaDeploy/
    deploy_user=booma
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/booma/BoomaDeploy/
    deploy_user=booma
  fi
  src_root=$booma_src_root
  target_jar=$booma_target_jar
fi
#plcampus
if [ "plcampus" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusDeploy/
    deploy_user=plcampus
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusDeploy/
    deploy_user=plcampus
  fi
  src_root=$plcampus_src_root
  target_jar=$plcampus_target_jar
fi
#plcampusfrontend
if [ "plcampusfrontend" == "$src_type" ]; then
  if [ "dev" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusFrontEndDeploy/
    deploy_user=plcampus
  fi
  if [ "live" == "$type" ]; then
    deploy_dir=/home/plcampus/PlCampusFrontEndDeploy/
    deploy_user=plcampus
  fi
  src_root=$plcampusfrontend_src_root
  target_jar=$plcampusfrontend_target_jar
fi
#dev
if [ "dev" == "$type" ]; then
  ssh_key=$dev_ssh_key
  deploy_host=146.190.8.32
  ssh_port=22
fi
#live
if [ "live" == "$type" ]; then
  ssh_key=$live_ssh_key
  deploy_host=146.190.10.12
  ssh_port=59318
fi

# init
target_jar="${src_root}target/${target_jar}.jar"
temp_deploy_jar="${deploy_dir}temp_deploy.jar"
deploy_jar="${deploy_dir}deploy.jar"
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"
move_script="mv ${temp_deploy_jar} ${deploy_jar}"
deploy_script="bash ${deploy_dir}restart.sh"

# packaging
cd "$src_root"
mvn package

# uploading
scp -i $ssh_key -P $ssh_port "$target_jar" $scp_deploy_prefix$temp_deploy_jar

# moving
ssh -i $ssh_key -p $ssh_port  $deploy_domain $move_script

# restarting
ssh -i $ssh_key -p $ssh_port  $deploy_domain $deploy_script
