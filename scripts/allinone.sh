#!/bin/bash

# download all the 3rd images
while read line
do
  docker pull $line
done < $1


# save to one tarball

#docker images --format "{{.Repository}}:{{.Tag}}" | xargs docker save -o thumbnail.tar