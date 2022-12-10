#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 \"local file\" \"remote file\"" >&2
  exit 1
fi
if ! [ -e "$1" ]; then
  echo "$1 not found" >&2
  exit 1
fi

# config
#type=live
type=dev
#dev
if [ "dev" == "$type" ]; then
  ssh_key=~/Documents/Dev/text/squares/ssh/booma-dev/booma-dev
  deploy_user=root
  deploy_host=146.190.8.32
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
deploy_domain="${deploy_user}@${deploy_host}"
scp_deploy_prefix="${deploy_domain}:"

scp -i $ssh_key -P $ssh_port $1 $scp_deploy_prefix$2
