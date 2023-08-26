#!/bin/bash

# download all the 3rd images
while read line
do
  docker pull $line
done < $1