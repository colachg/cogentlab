# default rule
default: build

# path macros
DIST_PATH := cogent
K3S_VERSION := v1.27.4
ARCH := amd64

# phony rules
.PHONY: 3rd
3rd:
	@echo "...... download dependency ......"
	@docker images -qa | xargs docker rmi -f
	@bash scripts/allinone.sh 3rd-images.txt


.PHONY: thumbnail
thumbnail: 3rd
	@echo "...... build thumbnail ......"
	@docker build . -t thumbnail
	@mkdir -p $(DIST_PATH)
	@docker images --format "{{.Repository}}:{{.Tag}}" | xargs docker save -o $(DIST_PATH)/thumbnail.tar
	@gzip $(DIST_PATH)/thumbnail.tar
	@helm package cogentlabs-thumbnail-generator -d $(DIST_PATH)/

.PHONY: build
build: thumbnail
	@echo "...... start building ......"
	@wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$(K3S_VERSION)%2Bk3s1/k3s -P $(DIST_PATH)/
	@wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$(K3S_VERSION)%2Bk3s1/k3s-airgap-images-$(ARCH).tar -P $(DIST_PATH)/
	@curl -sSL https://get.k3s.io/ > $(DIST_PATH)/install.sh
	@cp Makefile $(DIST_PATH)/
	@cp INSTALL.md $(DIST_PATH)/README.md
	@tar -czvf allInOne.tar.gz $(DIST_PATH)
	@md5sum allInOne.tar.gz >> md5sum.txt

.PHONY: install
install:
	@echo "...... start installing ......"
	@mkdir -p /var/lib/rancher/k3s/agent/images/
	@gunzip thumbnail.tar.gz
	@cp *.tar /var/lib/rancher/k3s/agent/images/

	@cp k3s /usr/local/bin/
	@chmod +x ./install.sh /usr/local/bin/k3s
	INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh
	@sleep 45
	@helm install cogent-thumbnail thumbnail-generator-0.1.0.tgz --kubeconfig /etc/rancher/k3s/k3s.yaml


.PHONY: uninstall
uninstall:
	@echo "uninstall"
	@helm uninstall cogent-thumbnail --kubeconfig /etc/rancher/k3s/k3s.yaml
	@bash /usr/local/bin/k3s-uninstall.sh
	@rm -rf /usr/local/bin/k3s /var/lib/rancher/k3s/agent/images

.PHONY: diagnose
diagnose:
	@echo "......start diagnose......"