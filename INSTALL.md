# Quick Start

## How to build ?
Please run `make build` to build the package. It will generate a zip file under the root directory.
You can also download from the GitHub project in the latest action tab.

### What happened during the build process?
According to its official [guide](https://docs.k3s.io/installation/airgap), I encapsulated the procedures into a Makefile.
1. Download the necessary files
    - The images tar file to pull up the cluster.
    - The executable binary to set up the cluster.
    - The installation script to do the setup automatically.
2. Create the helm chart for the services and also package these images
   - Use "skopeo" to download these images to tar file
   - According to the "docker-compose.yaml", translate it to Helm charts.
3. Download dependency 3rd images

## How to install ?
1. Download the zip files and copy it to your air-gaped environment. Decompress it, if you are using Ubuntu as the host, you
can install the unzip tool by `sudo apt install -y unzip` and run `unzip name.zip`.
2. Checking the md5sum `md5sum allInOne.tar.gz` with the md5sum.txt, then `tar -zxvf allInOne.tar.gz` to untar the file.
3. `cd cogent` the extracted dir, run `make install` to install the k3s and deploy the "thumbnail-generator" service.


## How to uninstall ?
1. run `make uninstall`, if you want to reinstall. It could be better to reboot your machine before your reinstallation.

## Q&A
1. kubectl cannot get access to the api server ?
   - please add the `--kubeconfig /etc/rancher/k3s/k3s.yaml` behind kubectl.
2. Why my thumbnail task status is always waiting ?
   - please run this command `kubectl get po |grep thumbnail-generator-task | awk '{print "kubectl delete po " $1}' |bash` in your node.
   - this is because the thumbnail-task has no readiness and liveness probe.


## TODO
- [] use init container to fix task error.
- [] support high available installation.
- [] create a nfs storage class for the cluster to provide PVs.
- [] provide local private registry with TLS support and S3(MinIO) backend.
- [] add some diagnose script to grasp logs from the installation process and the host.
- [] use "ArgoCD" to manage all services in the cluster.
- [] use "skopeo" to operate images.
- [] need healthy and ready probe for thumbnail-task service.
- [] create ingress for this service and set tls for it.