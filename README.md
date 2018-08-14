# devopsag_infra
devopsag Infra repository

## Homework 3


### Connection to someinternalhost in one string.
To connect, type in command line: "ssh -i ~/.ssh/gcpssh -J gcpssh@35.210.236.136 gcpssh@10.132.0.3"
### Connection to server comeinternalhost with same alias
To connect with simple string "ssh someinternalhost" you must to insert configuration data in ~/.ssh/conf:
ForwardAgent yes
Host bastion
    HostName 35.210.236.136
    User gcpssh

Host someinternalhost
    HostName 10.132.0.3
    User gcpssh
    ProxyJump bastion
### Description of configuration:
bastion_IP = 35.210.236.136
someinternalhost_IP = 10.132.0.3

## Homework 4

testapp_IP=35.233.47.183
testapp_port=9292

### Gcloud command for creation instance with scripts from local file
gcloud compute instances create reddit-app  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure   --metadata-from-file startup-script=startup_script.sh

### Gcloud commande for creation instance with scripts from remote file located on http server
gcloud compute instances create reddit-app  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure  --scopes storage-ro --metadata startup-script-url=https://storage.googleapis.com/devopsagb/startup_script.sh

### Create Rule default-puma-server
gcloud compute firewall-rules create default-puma-server --action=allow --allow=tcp:9292 --target-tags=puma-server
## Homework 5
Creation of base and full images with Packer. Completed all tasks (include Task with star)