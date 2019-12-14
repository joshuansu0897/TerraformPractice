#!/bin/bash
sudo systemctl start docker
docker run -d -p 80:80 app