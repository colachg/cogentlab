#!/bin/bash

DIR="cogent"
# download all the 3rd images
#docker pull minio/minio:latest
#docker pull mongo:latest

# build the thumbnail
docker build . -t thumbnail

# save all the images
mkdir -p $DIR
cp scripts/diagnose.sh team.jpeg $DIR/
#docker save minio/minio:latest mongo:latest thumbnail:latest -o $DIR/thumbnail.tar
docker save thumbnail:latest -o $DIR/thumbnail.tar
gzip $DIR/thumbnail.tar

# package the chart
helm package cogentlabs-thumbnail-generator -d $DIR/
