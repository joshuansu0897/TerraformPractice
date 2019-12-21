#!/bin/bash

cd code
terraform destroy -auto-approve

cd ..
rm -rf private

