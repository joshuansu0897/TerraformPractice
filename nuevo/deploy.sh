#!/bin/bash
mkdir -p private/ssh
ssh-keygen -f $PWD/private/ssh/key_access -N ""

mv $PWD/private/ssh/key_access $PWD/private/ssh/key_access.pem
chmod 400 $PWD/private/ssh/key_access.pem

cd code
terraform init
terraform apply
