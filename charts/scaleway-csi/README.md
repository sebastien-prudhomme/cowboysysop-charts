# Scaleway CSI

[Scaleway CSI](https://github.com/scaleway/scaleway-csi) is an implementation of the Container Storage Interface to manage Scaleway Block Storage volumes.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/scaleway-csi
```

## Introduction

This chart bootstraps a Scaleway CSI deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.17+
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

| Name                                            | Description                                                                                       | Default                                                                   |
|-------------------------------------------------|---------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| `imagePullSecrets`                              | Docker registry secret names as an array                                                          | `[]`                                                                      |
| `nameOverride`                                  | Partially override `scaleway-csi.fullname` template with a string (will prepend the release name) | `nil`                                                                     |
| `fullnameOverride`                              | Fully override `scaleway-csi.fullname` template with a string                                     | `nil`                                                                     |
| `controller.replicaCount`                       | Number of replicas (controller component)                                                         | `1`                                                                       |
| `controller.image.repository`                   | Scaleway CSI image name (controller component)                                                    | `scaleway/scaleway-csi`                                                   |
| `controller.image.tag`                          | Scaleway CSI image tag (controller component)                                                     | `v0.1.3`                                                                  |
| `controller.image.pullPolicy`                   | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.csiProvisionerImage.repository`     | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/csi-provisioner`                                          |
| `controller.csiProvisionerImage.tag`            | Scaleway CSI image tag (controller component)                                                     | `v1.6.0`                                                                  |
| `controller.csiProvisionerImage.pullPolicy`     | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.csiAttacherImage.repository`        | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/csi-attacher`                                             |
| `controller.csiAttacherImage.tag`               | Scaleway CSI image tag (controller component)                                                     | `v2.2.0`                                                                  |
| `controller.csiAttacherImage.pullPolicy`        | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.csiSnapshotterImage.repository`     | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/csi-snapshotter`                                          |
| `controller.csiSnapshotterImage.tag`            | Scaleway CSI image tag (controller component)                                                     | `v2.1.0`                                                                  |
| `controller.csiSnapshotterImage.pullPolicy`     | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.snapshotControllerImage.repository` | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/snapshot-controller`                                      |
| `controller.snapshotControllerImage.tag`        | Scaleway CSI image tag (controller component)                                                     | `v2.1.0`                                                                  |
| `controller.snapshotControllerImage.pullPolicy` | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.csiResizerImage.repository`         | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/csi-resizer`                                              |
| `controller.csiResizerImage.digest`             | Scaleway CSI image digest (controller component)                                                  | `sha256:abb73c5a56b660a7e06ae9f26e447b3c4ad0cbbcd5ebe614e8cbc1424373b177` |
| `controller.csiResizerImage.pullPolicy`         | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.livenessProbeImage.repository`      | Scaleway CSI image name (controller component)                                                    | `quay.io/k8scsi/livenessprobe`                                            |
| `controller.livenessProbeImage.tag`             | Scaleway CSI image tag (controller component)                                                     | `v2.0.0`                                                                  |
| `controller.livenessProbeImage.pullPolicy`      | Image pull policy (controller component)                                                          | `IfNotPresent`                                                            |
| `controller.serviceAccount.create`              | Specify whether to create a ServiceAccount (controller component)                                 | `true`                                                                    |
| `controller.serviceAccount.annotations`         | ServiceAccount annotations (controller component)                                                 | `{}`                                                                      |
| `controller.serviceAccount.name`                | The name of the ServiceAccount to create (controller component)                                   | Generated using the `scaleway-csi.controller.fullname` template           |
| `controller.podAnnotations`                     | Additional pod annotations (controller component)                                                 | `{}`                                                                      |
| `controller.podLabels`                          | Additional pod labels (controller component)                                                      | `{}`                                                                      |
| `controller.podSecurityContext`                 | Pod security context (controller component)                                                       | `{}`                                                                      |
| `controller.priorityClassName`                  | Pod priority class name (controller component)                                                    | `system-cluster-critical`                                                 |
| `controller.securityContext`                    | Container security context (controller component)                                                 | `{}`                                                                      |
| `controller.resources`                          | CPU/Memory resource requests/limits (controller component)                                        | `{}`                                                                      |
| `controller.nodeSelector`                       | Node labels for pod assignment (controller component)                                             | `{}`                                                                      |
| `controller.tolerations`                        | Tolerations for pod assignment (controller component)                                             | `[]`                                                                      |
| `controller.affinity`                           | Map of node/pod affinities (controller component)                                                 | `{}`                                                                      |
| `controller.accessKey`                          | Scaleway access key                                                                               | `nil`                                                                     |
| `controller.secretKey`                          | Scaleway secret key                                                                               | `nil`                                                                     |
| `controller.defaultOrganizationId`              | Scaleway default organization id                                                                  | `nil`                                                                     |
| `controller.defaultZone`                        | Scaleway default zone                                                                             | `fr-par-1`                                                                |
| `controller.metrics.service.type`               | Metrics Kubernetes Service type (controller component)                                            | `ClusterIP`                                                               |
| `controller.metrics.service.csiProvisionerPort` | Metrics service port (controller component)                                                       | `8080`                                                                    |
| `controller.metrics.service.csiAttacherPort`    | Metrics service port (controller component)                                                       | `8081`                                                                    |
| `controller.metrics.service.csiSnapshotterPort` | Metrics service port (controller component)                                                       | `8082`                                                                    |
| `controller.existingSecret`                     | Name of existing Secret to use (controller component)                                             | `nil`                                                                     |
| `node.image.repository`                         | Scaleway CSI image name (node component)                                                          | `scaleway/scaleway-csi`                                                   |
| `node.image.tag`                                | Scaleway CSI image tag (node component)                                                           | `v0.1.3`                                                                  |
| `node.image.pullPolicy`                         | Image pull policy (node component)                                                                | `IfNotPresent`                                                            |
| `node.csiNodeDriverRegistrarImage.repository`   | Scaleway CSI image name (node component)                                                          | `quay.io/k8scsi/csi-node-driver-registrar`                                |
| `node.csiNodeDriverRegistrarImage.tag`          | Scaleway CSI image tag (node component)                                                           | `v1.3.0`                                                                  |
| `node.csiNodeDriverRegistrarImage.pullPolicy`   | Image pull policy (node component)                                                                | `IfNotPresent`                                                            |
| `node.livenessProbeImage.repository`            | Scaleway CSI image name (node component)                                                          | `quay.io/k8scsi/livenessprobe`                                            |
| `node.livenessProbeImage.tag`                   | Scaleway CSI image tag (node component)                                                           | `v2.0.0`                                                                  |
| `node.livenessProbeImage.pullPolicy`            | Image pull policy (node component)                                                                | `IfNotPresent`                                                            |
| `node.serviceAccount.create`                    | Specify whether to create a ServiceAccount (node component)                                       | `true`                                                                    |
| `node.serviceAccount.annotations`               | ServiceAccount annotations (node component)                                                       | `{}`                                                                      |
| `node.serviceAccount.name`                      | The name of the ServiceAccount to create (node component)                                         | Generated using the `scaleway-csi.node.fullname` template                 |
| `node.podAnnotations`                           | Additional pod annotations (node component)                                                       | `{}`                                                                      |
| `node.podLabels`                                | Additional pod labels (node component)                                                            | `{}`                                                                      |
| `node.podSecurityContext`                       | Pod security context (node component)                                                             | `{}`                                                                      |
| `node.priorityClassName`                        | Pod priority class name (node component)                                                          | `system-node-critical`                                                    |
| `node.securityContext`                          | Container security context (node component)                                                       | `{ privileged: true }`                                                    |
| `node.resources`                                | CPU/Memory resource requests/limits (node component)                                              | `{}`                                                                      |
| `node.nodeSelector`                             | Node labels for pod assignment (node component)                                                   | `{}`                                                                      |
| `node.tolerations`                              | Tolerations for pod assignment (node component)                                                   | `[]`                                                                      |
| `node.affinity`                                 | Map of node/pod affinities (node component)                                                       | `{}`                                                                      |

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
