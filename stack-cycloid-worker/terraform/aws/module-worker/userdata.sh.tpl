#!/bin/bash
export TEAM_ID="${TEAM_ID}"
export WORKER_KEY="${WORKER_KEY}"
export VAR_LIB_DEVICE="nodevice"
export CLOUD_PROVIDER="baremetal"

export LOG_FILE="/var/log/user-data.log"
exec &> >(tee -a ${LOG_FILE})

curl -sSL "https://raw.githubusercontent.com/cycloid-community-catalog/stack-external-worker/master/extra/startup.sh?${RANDOM}" | bash