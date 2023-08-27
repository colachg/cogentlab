#!/bin/bash

K3S_VERSION="v1.27.4"
DIR="cogent"

wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s -P $DIR/
wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s-airgap-images-amd64.tar -P $DIR/
curl -sSL https://get.k3s.io/ > $DIR/install.sh
cp Makefile $DIR/
cp INSTALL.md $DIR/README.md
tar -czvf allInOne.tar.gz $DIR
md5sum allInOne.tar.gz >> md5sum.txt