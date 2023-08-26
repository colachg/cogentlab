#!/bin/bash

K3S_VERSION="v1.27.4"

wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s -P congent/
wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s-airgap-images-amd64.tar -P congent/
curl -sSL https://get.k3s.io/ > congent/install.sh
cp Makefile congent/
cp INSTALL.md congent/README.md
tar -czvf allInOne.tar.gz congent
md5sum allInOne.tar.gz >> md5sum.txt