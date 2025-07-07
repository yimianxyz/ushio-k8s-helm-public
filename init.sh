#!/bin/bash
# priorityClass
sudo -u ushio kubectl apply -f priorityClass
# nginx ingress
sudo -u ushio kubectl create ns static-sites
sudo -u ushio kubectl create ns ingress
sudo -u ushio helm upgrade --install nginx ingress-nginx -n ingress
################################################################# wait
# cert manager
sudo -u ushio kubectl create ns cert-manager
sudo -u ushio helm upgrade --install cert-manager cert-manager/cert-manager -n cert-manager
sudo -u ushio helm upgrade --install cert-manager-webhook-dnspod cert-manager/cert-manager-webhook-dnspod -n cert-manager
##################################################################### wait
sudo -u ushio kubectl apply -f cert-manager/yimian-xyz-cert.yaml
sudo -u ushio kubectl apply -f cert-manager/iotcat-me-cert.yaml
sudo -u ushio kubectl apply -f cert-manager/eee-dog-cert.yaml
####################################################################### wait
# frp
sudo -u ushio kubectl create ns frp
sudo -u ushio kubectl apply -f frp/frps/all.yaml -n frp
sudo -u ushio kubectl apply -f frp/frpc/all.yaml -n frp
# v2ray
sudo -u ushio kubectl create ns v2ray
sudo -u ushio kubectl apply -f v2ray/v-usa/all.yaml -n v2ray
sudo -u ushio kubectl apply -f v2ray/v-china/all.yaml -n v2ray
sudo -u ushio kubectl apply -f v2ray/ingress.yaml -n v2ray
sudo -u ushio kubectl apply -f v2ray/all.yaml -n v2ray
# monitoring
sudo -u ushio kubectl create ns monitoring
sudo -u ushio helm upgrade --install prom-node-exporter monitoring/prometheus-node-exporter -n monitoring
sudo -u ushio helm upgrade --install prom-kube-state-metrics monitoring/kube-state-metrics -n monitoring
sudo -u ushio kubectl apply -f monitoring/pvc.yaml
sudo -u ushio helm upgrade --install prom monitoring/prometheus -n monitoring
sudo -u ushio helm upgrade --install grafana monitoring/grafana -n monitoring
# mq
sudo -u ushio kubectl create ns mq
sudo -u ushio helm upgrade --install kafka mq/kafka -n mq
# logging
sudo -u ushio kubectl create ns logging
sudo -u ushio kubectl apply -f logging/kafka.yaml -n logging
sudo -u ushio kubectl apply -f logging/pvc.yaml
sudo -u ushio kubectl apply -f logging/elasticsearch/all.yaml -n logging
sudo -u ushio kubectl apply -f logging/kibana-auth.yaml -n logging
sudo -u ushio helm upgrade --install kibana logging/kibana -n logging
sudo -u ushio helm upgrade --install logstash logging/logstash -n logging
sudo -u ushio helm upgrade --install filebeat logging/filebeat -n logging
# drone ci
sudo -u ushio kubectl create ns ci
sudo -u ushio kubectl apply -f ci/pvc.yaml
sudo -u ushio helm upgrade --install drone ci/drone -n ci
sudo -u ushio helm upgrade --install drone-runner ci/drone-runner-kube -n ci
# static sites
sudo -u ushio kubectl apply -f static-sites -n static-sites
sudo -u ushio kubectl apply -f frp/sites -n frp
