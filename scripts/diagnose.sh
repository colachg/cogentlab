#!/usr/bin/env bash
# check cluster status
echo -e "=========check nodes=========\n"
kubectl get no

echo -e "=======check namespaces======\n"
kubectl get ns

echo -e "==========check pods=========\n"
kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml get po,svc,ep

echo -e "=======check services========\n"
NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services thumbnail-generator-api)
NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

ID=$(curl --silent --location --request POST "http://$NODE_IP:$NODE_PORT/thumbnail" \
--form 'file=@"team.jpeg"'| jq -r .data.job_id)
sleep 5
echo -e "=======check services========\n"
curl --location --request GET "http://$NODE_IP:$NODE_PORT/thumbnail/$ID"
curl --location --request GET -O "http://$NODE_IP:$NODE_PORT/thumbnail/$ID/image"