# Scaleway CSI

[Scaleway CSI](https://github.com/kubernetes/autoscaler) is a set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/scaleway-csi
```

## Introduction

This chart bootstraps a Scaleway CSI deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Metrics Server 0.2+ (you can use the [stable/metrics-server](https://hub.helm.sh/charts/stable/metrics-server) chart)
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/scaleway-csi
```

These commands deploy Scaleway CSI on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Replace the custom resource definitions created by the chart using:

```bash
kubectl replace -f crds/verticalpodautoscaler.yaml
kubectl replace -f crds/verticalpodautoscalercheckpoint.yaml
```

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/scaleway-csi
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Delete the `vpa-webhook-config` mutating webhook configuration automatically created by Scaleway CSI controller component using:

```bash
$ kubectl delete mutatingwebhookconfiguration vpa-webhook-config
```

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

Optionally, delete the custom resource definitions created by the chart using:

```bash
$ kubectl delete crd verticalpodautoscalers.autoscaling.k8s.io
$ kubectl delete crd verticalpodautoscalercheckpoints.autoscaling.k8s.io
```

## Configuration

The following table lists all the configurable parameters expose by the Scaleway CSI chart and their default values.

| Name                                       | Description                                                                                       | Default                                                          |
|--------------------------------------------|---------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| `imagePullSecrets`                         | Docker registry secret names as an array                                                          | `[]`                                                             |
| `nameOverride`                             | Partially override `scaleway-csi.fullname` template with a string (will prepend the release name) | `nil`                                                            |
| `fullnameOverride`                         | Fully override `scaleway-csi.fullname` template with a string                                     | `nil`                                                            |
| `controller.replicaCount`                  | Number of replicas (controller component)                                                         | `1`                                                              |
| `controller.livenessProbeImage.repository` | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/livenessprobe`                                   |
| `controller.livenessProbeImage.tag`        | Scaleway CSI image tag (controller component)                                                     | `v2.0.0`                                                         |
| `controller.livenessProbeImage.pullPolicy` | Image pull policy (controller component)                                                          | `IfNotPresent`                                                   |
| `controller.serviceAccount.create`         | Specify whether to create a ServiceAccount (controller component)                                 | `true`                                                           |
| `controller.serviceAccount.annotations`    | ServiceAccount annotations (controller component)                                                 | `{}`                                                             |
| `controller.serviceAccount.name`           | The name of the ServiceAccount to create (controller component)                                   | Generated using the `scaleway-csi.controller.fullname` template  |
| `controller.podAnnotations`                | Additional pod annotations (controller component)                                                 | `{}`                                                             |
| `controller.podLabels`                     | Additional pod labels (controller component)                                                      | `{}`                                                             |
| `controller.podSecurityContext`            | Pod security context (controller component)                                                       | `{}`                                                             |
| `controller.priorityClassName`             | Pod priority class name (controller component)                                                    | `system-cluster-critical`                                        |
| `controller.securityContext`               | Container security context (controller component)                                                 | `{}`                                                             |
| `controller.resources`                     | CPU/Memory resource requests/limits (controller component)                                        | `{}`                                                             |
| `controller.nodeSelector`                  | Node labels for pod assignment (controller component)                                             | `{}`                                                             |
| `controller.tolerations`                   | Tolerations for pod assignment (controller component)                                             | `[]`                                                             |
| `controller.affinity`                      | Map of node/pod affinities (controller component)                                                 | `{}`                                                             |
| `controller.extraArgs`                     | Additional container arguments (controller component)                                             | `{ v: 2 }`                                                       |
| `controller.metrics.service.type`          | Metrics Kubernetes Service type (controller component)                                            | `ClusterIP`                                                      |
| `controller.metrics.service.port`          | Metrics service port (controller component)                                                       | `8944`                                                           |
| `controller.existingSecret`                | Name of existing Secret to use (controller component)                                             | `nil`                                                            |
| `recommender.replicaCount`                 | Number of replicas (recommender component)                                                        | `1`                                                              |
| `recommender.image.repository`             | Scaleway CSI image name (recommender component)                                                   | `k8s.gcr.io/vpa-recommender`                                     |
| `recommender.image.tag`                    | Scaleway CSI image tag (recommender component)                                                    | `0.7.0`                                                          |
| `recommender.image.pullPolicy`             | Image pull policy (recommender component)                                                         | `IfNotPresent`                                                   |
| `recommender.serviceAccount.create`        | Specify whether to create a ServiceAccount (recommender component)                                | `true`                                                           |
| `recommender.serviceAccount.annotations`   | ServiceAccount annotations (recommender component)                                                | `{}`                                                             |
| `recommender.serviceAccount.name`          | The name of the ServiceAccount to create (recommender component)                                  | Generated using the `scaleway-csi.recommender.fullname` template |
| `recommender.podAnnotations`               | Additional pod annotations (recommender component)                                                | `{}`                                                             |
| `recommender.podLabels`                    | Additional pod labels (recommender component)                                                     | `{}`                                                             |
| `recommender.podSecurityContext`           | Pod security context (recommender component)                                                      | `{}`                                                             |
| `recommender.securityContext`              | Container security context (recommender component)                                                | `{}`                                                             |
| `recommender.resources`                    | CPU/Memory resource requests/limits (recommender component)                                       | `{}`                                                             |
| `recommender.nodeSelector`                 | Node labels for pod assignment (recommender component)                                            | `{}`                                                             |
| `recommender.tolerations`                  | Tolerations for pod assignment (recommender component)                                            | `[]`                                                             |
| `recommender.affinity`                     | Map of node/pod affinities (recommender component)                                                | `{}`                                                             |
| `recommender.extraArgs`                    | Additional container arguments (recommender component)                                            | `{ v: 2 }`                                                       |
| `recommender.metrics.service.type`         | Metrics Kubernetes Service type (recommender component)                                           | `ClusterIP`                                                      |
| `recommender.metrics.service.port`         | Metrics service port (recommender component)                                                      | `8942`                                                           |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set nameOverride=my-name cowboysysop/scaleway-csi
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/scaleway-csi
```

**Tip**: You can use the default [values.yaml](values.yaml).
