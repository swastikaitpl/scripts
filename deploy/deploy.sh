#!/bin/sh

# config
src_root=~/Documents/Dev/java/Booma/booma/
ssh_key=~/Documents/Dev/text/squares/ssh/booma-dev/booma-dev
deploy_dir=/root/BoomaDeploy/
deploy_user=root
deploy_host=mid.buybooma.com
deploy_port=8081
deploy_data_dir=/root/data/

# init
target_jar="${src_root}target/booma-0.0.1-SNAPSHOT.jar"
deploy_jar="${deploy_dir}deploy.jar"
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"
deploy_log="${deploy_data_dir}logs/nohup.out"
deploy_script="bash ${deploy_dir}restart.sh"

# packaging
cd $src_root
mvn package

# uploading
scp -i $ssh_key $target_jar $scp_deploy_prefix$deploy_jar

# restarting
ssh -i $ssh_key $deploy_domain $deploy_script
