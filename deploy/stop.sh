#!/bin/sh

# config
deploy_port=8081
 
# stopping the application
kill -9 $(lsof -t -i:$deploy_port)
