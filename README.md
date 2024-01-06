# Cprobe Helm Chart

## Features

This Helm Chart includes all the components of Cprobe for a complete experience.

- [x] Cprobe core plugins:
    - [x] MySQL
    - [x] Redis
    - [x] Kafka
    - [x] MongoDB
- [x] Management & monitoring components:
    - [ ] Prometheus
    - [ ] Grafana
    - [ ] Helm Chart Repository

## Prerequisites

* Install the follow packages: ``git``, ``kubectl``, ``helm``, ``helm-docs``.

## How to install

Access a Kubernetes cluster.

Add a chart helm repository with follow commands:

```console
git clone https://github.com/cprobe/helm-chart.git

cd helm-chart

helm install cprobe ./charts/cprobe -n NAMESPACE
```


Test the installation with command:

```console
helm install cprobe cprobe -f values.yaml -n NAMESPACE --debug --dry-run
```
Get the pods lists by running this commands:

```console
kubectl get pods -A | grep 'cprobe' -n NAMESPACE
```

Get the application by running this command:

```console
helm list -n NAMESPACE
```

## How to uninstall

Remove application with command.

```console
helm uninstall cprobe -n NAMESPACE
```