#!/bin/bash
# download all the 3rd images
docker pull minio/minio:latest
docker pull mongo:latest

# build the thumbnail
docker build . -t thumbnail

# save all the images
mkdir -p cogent
docker save minio/minio:latest mongo:latest thumbnail -o cogent/thumbnail.tar
gzip cogent/thumbnail.tar

# package the chart
helm package cogentlabs-thumbnail-generator -d cogent/
