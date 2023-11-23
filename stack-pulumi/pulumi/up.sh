                set -euo pipefail
                export DEBIAN_FRONTEND=noninteractive
                apt-get update -y
                apt-get install curl -y
                curl -fsSL https://get.pulumi.com | sh
                export PATH=$PATH:$HOME/.pulumi/bin
                apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
                mkdir -p /etc/apt/keyrings
                curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
                chmod go+r /etc/apt/keyrings/microsoft.gpg
                AZ_DIST=$(lsb_release -cs)
                echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | tee /etc/apt/sources.list.d/azure-cli.list
                apt-get install azure-cli -y
                az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
                pulumi login
                cd pulumi_files/stack-pulumi/pulumi
                npm ci
                pulumi org set-default cycloid
                pulumi stack select cycloid/storage-account/dev
                pulumi up --yes
