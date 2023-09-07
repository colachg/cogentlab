#!/bin/bash

# download all the 3rd images
docker pull minio/minio:latest
docker pull mongo:latest


docker save minio/minio:latest mongo:latest -o $DIR/3rd.tar
gzip $DIR/3rd.tar