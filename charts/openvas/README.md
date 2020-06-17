# OpenVAS

[OpenVAS](https://openvas.org/) is a full-featured vulnerability scanner.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/openvas
```

## Introduction

This chart bootstraps a OpenVAS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/openvas
```

These commands deploy OpenVAS on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/openvas
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

The following table lists all the configurable parameters expose by the OpenVAS chart and their default values.

| Name                                 | Description                                                                                           | Default                                         |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                             |
| `image.repository`                   | OpenVAS image name                                                                                    | `admirito/gvmd`                                 |
| `image.tag`                          | OpenVAS image tag                                                                                     | `11`                                            |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                  |
| `imagePullSecrets`                   | Docker registry secret names as an array                                                              | `[]`                                            |
| `nameOverride`                       | Partially override `openvas.fullname` template with a string (will prepend the release name)          | `nil`                                           |
| `fullnameOverride`                   | Fully override `openvas.fullname` template with a string                                              | `nil`                                           |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                          |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                            |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `openvas.fullname` template |
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
| `service.port`                       | OpenVAS service port                                                                                  | `9390`                                          |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                         |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                            |
| `ingress.hosts[0].name`              | Hostname to your OpenVAS installation                                                                 | `openvas.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[]`                                            |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                           |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                           |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                            |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                            |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                            |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                            |

### PostgreSQL parameters

| Name                            | Description                         | Default   |
|---------------------------------|-------------------------------------|-----------|
| `postgresql.enabled`            | Whether to use the PostgreSQL chart | `true`    |
| `postgresql.postgresqlUsername` | Image name                          | `openvas` |
| `postgresql.postgresqlPassword` | Image name                          | `openvas` |
| `postgresql.postgresqlDatabase` | Image name                          | `openvas` |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set nameOverride=my-name cowboysysop/openvas
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/openvas
```

**Tip**: You can use the default [values.yaml](values.yaml).
