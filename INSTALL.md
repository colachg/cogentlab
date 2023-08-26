# Quick Start


## How to build ?
Please run `make build` to build the package. It will generate a zip file under the root directory.

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


## How to uninstall ?


## Q&A
https://github.com/DefinitelyTyped/DefinitelyTyped/issues/65766


## TODO
- [] support high available installation.
- [] create a nfs storage class for the cluster to provide PVs.
- [] provide local private registry with TLS support and S3(MinIO) backend.
- [] add some diagnose script to grasp logs from the installation process and the host.
- [] use "ArgoCD" to manage all services in the cluster.
- [] use "skopeo" to operate images.