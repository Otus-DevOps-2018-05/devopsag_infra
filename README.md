# devopsag_infra
devopsag Infra repository
##Homework 3
#Connection to someinternalhost in one string.
To connect, type in command line: "ssh -i ~/.ssh/gcpssh -J gcpssh@35.210.236.136 gcpssh@10.132.0.3"
#Connection to server comeinternalhost with same alias
To connect with simple string "ssh someinternalhost" you must to insert configuration data in ~/.ssh/conf:
ForwardAgent yes
Host bastion
    HostName 35.210.236.136
    User gcpssh

Host someinternalhost
    HostName 10.132.0.3
    User gcpssh
    ProxyJump bastion
#Description of configuration:
bastion_IP = 35.210.236.136
someinternalhost_IP = 10.132.0.3
