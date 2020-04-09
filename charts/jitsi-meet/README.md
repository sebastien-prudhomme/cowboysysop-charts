# Jitsi Meet

[Jitsi Meet](https://github.com/kubernetes/autoscaler) is a set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/jitsi-meet
```

## Introduction

This chart bootstraps a Jitsi Meet deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Metrics Server 0.2+ (you can use the [stable/metrics-server](https://hub.helm.sh/charts/stable/metrics-server) chart)
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/jitsi-meet
```

These commands deploy Jitsi Meet on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/jitsi-meet
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Delete the `vpa-webhook-config` mutating webhook configuration automatically created by Jitsi Meet admission controller component using:

```bash
$ kubectl delete mutatingwebhookconfiguration vpa-webhook-config
```

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following table lists all the configurable parameters expose by the Jitsi Meet chart and their default values.

| Name                                             | Description                                                                                                  | Default                                                                             |
|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| `imagePullSecrets`                               | Docker registry secret names as an array                                                                     | `[]`                                                                                |
| `nameOverride`                                   | Partially override `jitsi-meet.fullname` template with a string (will prepend the release name) | `nil`                                                                               |
| `fullnameOverride`                               | Fully override `jitsi-meet.fullname` template with a string                                     | `nil`                                                                               |
| `admissionController.replicaCount`               | Number of replicas (admission controller component)                                                          | `1`                                                                                 |
| `admissionController.image.repository`           | Jitsi Meet image name (admission controller component)                                          | `k8s.gcr.io/vpa-admission-controller`                                               |
| `admissionController.image.tag`                  | Jitsi Meet image tag (admission controller component)                                           | `0.7.0`                                                                             |
| `admissionController.image.pullPolicy`           | Image pull policy (admission controller component)                                                           | `IfNotPresent`                                                                      |
| `admissionController.serviceAccount.create`      | Specify whether to create a ServiceAccount (admission controller component)                                  | `true`                                                                              |
| `admissionController.serviceAccount.annotations` | ServiceAccount annotations (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.serviceAccount.name`        | The name of the ServiceAccount to create (admission controller component)                                    | Generated using the `jitsi-meet.admissionController.fullname` template |
| `admissionController.podAnnotations`             | Additional pod annotations (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.podLabels`                  | Additional pod labels (admission controller component)                                                       | `{}`                                                                                |
| `admissionController.podSecurityContext`         | Pod security context (admission controller component)                                                        | `{}`                                                                                |
| `admissionController.securityContext`            | Container security context (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.service.type`               | Kubernetes Service type (admission controller component)                                                     | `ClusterIP`                                                                         |
| `admissionController.resources`                  | CPU/Memory resource requests/limits (admission controller component)                                         | `{}`                                                                                |
| `admissionController.nodeSelector`               | Node labels for pod assignment (admission controller component)                                              | `{}`                                                                                |
| `admissionController.tolerations`                | Tolerations for pod assignment (admission controller component)                                              | `[]`                                                                                |
| `admissionController.affinity`                   | Map of node/pod affinities (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.extraArgs`                  | Additional container arguments (admission controller component)                                              | `{ v: 2 }`                                                                          |
| `admissionController.metrics.service.type`       | Metrics Kubernetes Service type (admission controller component)                                             | `ClusterIP`                                                                         |
| `admissionController.metrics.service.port`       | Metrics service port (admission controller component)                                                        | `8944`                                                                              |
| `admissionController.tls.caCert`                 | TLS CA certificate (admission controller component)                                                          | Generated using the `genCA` function                                                |
| `admissionController.tls.cert`                   | TLS certificate (admission controller component)                                                             | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.key`                    | TLS private key (admission controller component)                                                             | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.existingSecret`         | Name of existing TLS Secret to use (admission controller component)                                          | `nil`                                                                               |
| `jvb.replicaCount`                       | Number of replicas (jvb component)                                                                   | `1`                                                                                 |
| `jvb.image.repository`                   | Jitsi Meet image name (jvb component)                                                   | `jitsi/jvb`                                                        |
| `jvb.image.tag`                          | Jitsi Meet image tag (jvb component)                                                    | `4384-1`                                                                             |
| `jvb.image.pullPolicy`                   | Image pull policy (jvb component)                                                                    | `IfNotPresent`                                                                      |
| `jvb.serviceAccount.create`              | Specify whether to create a ServiceAccount (jvb component)                                           | `true`                                                                              |
| `jvb.serviceAccount.annotations`         | ServiceAccount annotations (jvb component)                                                           | `{}`                                                                                |
| `jvb.serviceAccount.name`                | The name of the ServiceAccount to create (jvb component)                                             | Generated using the `jitsi-meet.jvb.fullname` template         |
| `jvb.podAnnotations`                     | Additional pod annotations (jvb component)                                                           | `{}`                                                                                |
| `jvb.podLabels`                          | Additional pod labels (jvb component)                                                                | `{}`                                                                                |
| `jvb.podSecurityContext`                 | Pod security context (jvb component)                                                                 | `{}`                                                                                |
| `jvb.securityContext`                    | Container security context (jvb component)                                                           | `{}`                                                                                |
| `jvb.resources`                          | CPU/Memory resource requests/limits (jvb component)                                                  | `{}`                                                                                |
| `jvb.nodeSelector`                       | Node labels for pod assignment (jvb component)                                                       | `{}`                                                                                |
| `jvb.tolerations`                        | Tolerations for pod assignment (jvb component)                                                       | `[]`                                                                                |
| `jvb.affinity`                           | Map of node/pod affinities (jvb component)                                                           | `{}`                                                                                |
| `jvb.extraArgs`                          | Additional container arguments (jvb component)                                                       | `{ v: 2 }`                                                                          |
| `jvb.metrics.service.type`               | Metrics Kubernetes Service type (jvb component)                                                      | `ClusterIP`                                                                         |
| `jvb.metrics.service.port`               | Metrics service port (jvb component)                                                                 | `8942`                                                                              |
| `web.replicaCount`                           | Number of replicas (web component)                                                                       | `1`                                                                                 |
| `web.image.repository`                       | Jitsi Meet image name (web component)                                                       | `jitsi/web`                                                            |
| `web.image.tag`                              | Jitsi Meet image tag (web component)                                                        | `4384-1`                                                                             |
| `web.image.pullPolicy`                       | Image pull policy (web component)                                                                        | `IfNotPresent`                                                                      |
| `web.serviceAccount.create`                  | Specify whether to create a ServiceAccount (web component)                                               | `true`                                                                              |
| `web.serviceAccount.annotations`             | ServiceAccount annotations (web component)                                                               | `{}`                                                                                |
| `web.serviceAccount.name`                    | The name of the ServiceAccount to create (web component)                                                 | Generated using the `jitsi-meet.web.fullname` template             |
| `web.podAnnotations`                         | Additional pod annotations (web component)                                                               | `{}`                                                                                |
| `web.podLabels`                              | Additional pod labels (web component)                                                                    | `{}`                                                                                |
| `web.podSecurityContext`                     | Pod security context (web component)                                                                     | `{}`                                                                                |
| `web.securityContext`                        | Container security context (web component)                                                               | `{}`                                                                                |
| `web.resources`                              | CPU/Memory resource requests/limits (web component)                                                      | `{}`                                                                                |
| `web.nodeSelector`                           | Node labels for pod assignment (web component)                                                           | `{}`                                                                                |
| `web.tolerations`                            | Tolerations for pod assignment (web component)                                                           | `[]`                                                                                |
| `web.affinity`                               | Map of node/pod affinities (web component)                                                               | `{}`                                                                                |
| `web.extraArgs`                              | Additional container arguments (web component)                                                           | `{ v: 2 }`                                                                          |
| `web.metrics.service.type`                   | Metrics Kubernetes Service type (web component)                                                          | `ClusterIP`                                                                         |
| `web.metrics.service.port`                   | Metrics service port (web component)                                                                     | `8943`                                                                              |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set nameOverride=my-name cowboysysop/jitsi-meet
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/jitsi-meet
```

**Tip**: You can use the default [values.yaml](values.yaml).

## Limitations

Due to hard-coded values in Jitsi Meet, the chart configuration has some limitations:

- Admission controller component service name is `vpa-webhook`
- Admission controller component service port is `443`
- Mutating webhook configuration name automatically created by admission controller component is `vpa-webhook-config`
