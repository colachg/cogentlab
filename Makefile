# default rule
default: build

# phony rules
.PHONY: thumbnail
thumbnail:
	@echo "...... build thumbnail ......\n"
	@bash scripts/build-thumbnail.sh

.PHONY: build
build: thumbnail
	@echo "...... start building ......\n"
	@bash scripts/build-k3s.sh


.PHONY: install
install:
	@echo "...... start installing ......\n"
	@mkdir -p /var/lib/rancher/k3s/agent/images/
	@if [ -f "thumbnail.tar.gz" ]; then gunzip thumbnail.tar.gz;fi
	@cp *.tar /var/lib/rancher/k3s/agent/images/

	@cp k3s /usr/local/bin/
	@chmod +x ./install.sh /usr/local/bin/k3s
	INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh
	@sleep 30
	@echo -e "...... start deploying ......\n"
	@helm install cogent-thumbnail thumbnail-generator-0.1.0.tgz --kubeconfig /etc/rancher/k3s/k3s.yaml


.PHONY: uninstall
uninstall:
	@echo "uninstall"
	@helm uninstall cogent-thumbnail --kubeconfig /etc/rancher/k3s/k3s.yaml
	@bash /usr/local/bin/k3s-uninstall.sh
	@rm -rf /usr/local/bin/k3s /var/lib/rancher/k3s/agent/images

.PHONY: diagnose
diagnose:
	@echo "......start diagnose......\n"
	@bash diagnose.sh