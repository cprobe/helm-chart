# helm-chart

## How to install

Access a Kubernetes cluster.

Add a chart helm repository with follow commands:

```console
helm repo add vm https://victoriametrics.github.io/helm-charts/

helm repo update
```

List versions of ``cprobe`` chart available to installation:

```console
helm search repo cprobe -l
```

Export default values of ``cprobe`` chart to file ``values.yaml``:

```console
helm show values cprobe > values.yaml
```

Change the values according to the need of the environment in ``values.yaml`` file.

Test the installation with command:

```console
helm install cprobe cprobe -f values.yaml -n NAMESPACE --debug --dry-run
```

Install chart with command:

```console
helm install vmsingle cprobe -f values.yaml -n NAMESPACE
```

Get the pods lists by running this commands:

```console
kubectl get pods -A | grep 'single'
```

Get the application by running this command:

```console
helm list -f vmsingle -n NAMESPACE
```

See the history of versions of ``vmsingle`` application with command.

```console
helm history vmsingle -n NAMESPACE
```

## How to uninstall

Remove application with command.

```console
helm uninstall vmsingle -n NAMESPACE
```