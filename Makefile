# default rule
default: install

# path macros
DIST_PATH := cogent
K3S_VERSION := v1.27.4
ARCH := amd64

# phony rules
.PHONY: build
build:
	@echo "...... start building ......"
	@mkdir -p $(DIST_PATH)
	@wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$(K3S_VERSION)%2Bk3s1/k3s -P $(DIST_PATH)/
	@wget -qc --show-progress https://github.com/k3s-io/k3s/releases/download/$(K3S_VERSION)%2Bk3s1/k3s-airgap-images-$(ARCH).tar -P $(DIST_PATH)/
	@curl -sSL https://get.k3s.io/ > $(DIST_PATH)/install.sh
	@cp Makefile $(DIST_PATH)/
	@tar -czvf k3s.tar.gz $(DIST_PATH)
	@md5sum k3s.tar.gz > md5sum.txt

.PHONY: install
install:
	@echo "...... start install ......"
	@mkdir -p /var/lib/rancher/k3s/agent/images/
	@cp ./k3s-airgap-images-$(ARCH).tar /var/lib/rancher/k3s/agent/images/
	@cp k3s /usr/local/bin/
	@chmod +x ./install.sh /usr/local/bin/k3s
	@bash INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh

.PHONY: uninstall
uninstall:
	@echo "uninstall"
	@bash /usr/local/bin/k3s-uninstall.sh

.PHONY: diagnose
diagnose:
	@echo "......start diagnose......"