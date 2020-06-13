# PatrOwl

[PatrOwl](https://www.patrowl.io/) is an Open Source, Smart and Scalable Security Operations Orchestration Platform.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/patrowl
```

## Introduction

This chart bootstraps a PatrOwl deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/patrowl
```

These commands deploy PatrOwl on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/patrowl
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following tables list all the configurable parameters expose by the PatrOwl chart and their default values.

### Common parameters

| Name                                 | Description                                                                                           | Default                                         |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                             |
| `image.repository`                   | PatrOwl image name                                                                                    | `patrowl/patrowl-manager-community-edition`     |
| `image.digest`                       | PatrOwl image digest                                                                                  | `1.3.6`                                         |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                  |
| `imagePullSecrets`                   | Docker registry secret names as an array                                                              | `[]`                                            |
| `nameOverride`                       | Partially override `patrowl.fullname` template with a string (will prepend the release name)          | `nil`                                           |
| `fullnameOverride`                   | Fully override `patrowl.fullname` template with a string                                              | `nil`                                           |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                          |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                            |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `patrowl.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                            |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                            |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                            |
| `securityContext`                    | Container security context                                                                            | `{}`                                            |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                          |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                             |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                            |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                             |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                             |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                             |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                          |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                             |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                            |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                             |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                             |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                             |
| `service.type`                       | Kubernetes Service type                                                                               | `ClusterIP`                                     |
| `service.port`                       | PatrOwl service port                                                                                  | `8083`                                          |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                         |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                            |
| `ingress.hosts[0].name`              | Hostname to your PatrOwl installation                                                                 | `patrowl.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[]`                                            |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                           |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                           |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                            |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                            |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                            |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                            |

### Nmap engine parameters

| Name                                            | Description                                                                                           | Default                                                                   |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| `nmapEngine.replicaCount`                       | Number of replicas                                                                                    | `1`                                                                       |
| `nmapEngine.image.repository`                   | PatrOwl image name                                                                                    | `patrowl/engine-nmap`                                                     |
| `nmapEngine.image.digest`                       | PatrOwl image digest                                                                                  | `sha256:01dec9405f11d2a332b46db457c73953ee3ba6e32aaba1b9e54642c5322ed121` |
| `nmapEngine.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                                            |
| `nmapEngine.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                                    |
| `nmapEngine.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                                      |
| `nmapEngine.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `patrowl.fullname` template                           |
| `nmapEngine.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                                      |
| `nmapEngine.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                                      |
| `nmapEngine.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                                      |
| `nmapEngine.securityContext`                    | Container security context                                                                            | `{}`                                                                      |
| `nmapEngine.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                                    |
| `nmapEngine.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                                       |
| `nmapEngine.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                                      |
| `nmapEngine.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                                       |
| `nmapEngine.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                                       |
| `nmapEngine.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                                       |
| `nmapEngine.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                                    |
| `nmapEngine.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                                       |
| `nmapEngine.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                                      |
| `nmapEngine.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                                       |
| `nmapEngine.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                                       |
| `nmapEngine.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                                       |
| `nmapEngine.service.type`                       | Kubernetes Service type                                                                               | `ClusterIP`                                                               |
| `nmapEngine.service.port`                       | PatrOwl service port                                                                                  | `5001`                                                                    |
| `nmapEngine.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                                      |
| `nmapEngine.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                                      |
| `nmapEngine.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                                      |
| `nmapEngine.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                                      |

### SSLScan engine parameters

| Name                                               | Description                                                                                           | Default                                                                   |
|----------------------------------------------------|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| `sslscanEngine.replicaCount`                       | Number of replicas                                                                                    | `1`                                                                       |
| `sslscanEngine.image.repository`                   | PatrOwl image name                                                                                    | `patrowl/engine-sslscan`                                                  |
| `sslscanEngine.image.digest`                       | PatrOwl image digest                                                                                  | `sha256:01dec9405f11d2a332b46db457c73953ee3ba6e32aaba1b9e54642c5322ed121` |
| `sslscanEngine.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                                            |
| `sslscanEngine.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                                    |
| `sslscanEngine.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                                      |
| `sslscanEngine.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `patrowl.fullname` template                           |
| `sslscanEngine.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                                      |
| `sslscanEngine.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                                      |
| `sslscanEngine.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                                      |
| `sslscanEngine.securityContext`                    | Container security context                                                                            | `{}`                                                                      |
| `sslscanEngine.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                                    |
| `sslscanEngine.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                                       |
| `sslscanEngine.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                                      |
| `sslscanEngine.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                                       |
| `sslscanEngine.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                                       |
| `sslscanEngine.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                                       |
| `sslscanEngine.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                                    |
| `sslscanEngine.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                                       |
| `sslscanEngine.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                                      |
| `sslscanEngine.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                                       |
| `sslscanEngine.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                                       |
| `sslscanEngine.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                                       |
| `sslscanEngine.service.type`                       | Kubernetes Service type                                                                               | `ClusterIP`                                                               |
| `sslscanEngine.service.port`                       | PatrOwl service port                                                                                  | `5014`                                                                    |
| `sslscanEngine.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                                      |
| `sslscanEngine.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                                      |
| `sslscanEngine.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                                      |
| `sslscanEngine.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                                      |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set nameOverride=my-name cowboysysop/patrowl
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/patrowl
```

**Tip**: You can use the default [values.yaml](values.yaml).
