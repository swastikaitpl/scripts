#!/bin/sh

# config
deploy_dir=/root/BoomaDeploy/
deploy_port=8081
deploy_data_dir=/root/data/

# init
deploy_jar="${deploy_dir}deploy.jar"
deploy_log="${deploy_data_dir}logs/nohup.out"
 
# stopping the application
kill -9 $(lsof -t -i:$deploy_port)

# starting the application
cd $deploy_dir
nohup java -jar $deploy_jar >> $deploy_log &
