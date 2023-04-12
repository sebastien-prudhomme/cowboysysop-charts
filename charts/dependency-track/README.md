# Dependency-Track

[Dependency-Track](https://dependencytrack.org/) is a an intelligent Component Analysis platform that allows organizations to identify and reduce risk in the software supply chain.

**DISCLAIMER**: This is an unofficial chart not supported by Dependency-Track authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/dependency-track
```

## Introduction

This chart bootstraps a Dependency-Track deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.19
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/dependency-track
```

These commands deploy Dependency-Track on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/dependency-track
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Global parameters

| Name                      | Description                                     | Default |
|---------------------------|-------------------------------------------------|---------|
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Name                | Description                                                                                           | Default |
|---------------------|-------------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                           | `""`    |
| `nameOverride`      | Partially override `dependency-track.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `dependency-track.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                            | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                                 | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                     | `[]`    |

### API server parameters

s

### Frontend parameters

| Name                                          | Description                                                                                           | Default                                                           |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| `frontend.replicaCount`                       | Number of replicas                                                                                    | `1`                                                               |
| `frontend.image.registry`                     | Image registry                                                                                        | `docker.io`                                                       |
| `frontend.image.repository`                   | Image repository                                                                                      | `dependencytrack/frontend`                                        |
| `frontend.image.tag`                          | Image tag                                                                                             | `4.7.1`                                                           |
| `frontend.image.digest`                       | Image digest                                                                                          | `""`                                                              |
| `frontend.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                                    |
| `frontend.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                           |
| `frontend.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                               |
| `frontend.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                             |
| `frontend.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                            |
| `frontend.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                              |
| `frontend.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `dependency-track.frontend.fullname` template |
| `frontend.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                              |
| `frontend.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                              |
| `frontend.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                              |
| `frontend.priorityClassName`                  | Priority class name                                                                                   | `nil`                                                             |
| `frontend.securityContext`                    | Container security context                                                                            | `{}`                                                              |
| `frontend.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                            |
| `frontend.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                               |
| `frontend.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                              |
| `frontend.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                               |
| `frontend.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                               |
| `frontend.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                               |
| `frontend.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                            |
| `frontend.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                               |
| `frontend.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                              |
| `frontend.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                               |
| `frontend.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                               |
| `frontend.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                               |
| `frontend.service.annotations`                | Service annotations                                                                                   | `{}`                                                              |
| `frontend.service.type`                       | Service type                                                                                          | `ClusterIP`                                                       |
| `frontend.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                             |
| `frontend.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                             |
| `frontend.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                             |
| `frontend.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                                         |
| `frontend.service.port`                       | Service port                                                                                          | `8080`                                                            |
| `frontend.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                             |
| `frontend.ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                                           |
| `frontend.ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                                              |
| `frontend.ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                                          |
| `frontend.ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                                              |
| `frontend.ingress.hosts[0].host`              | Hostname to your Dependency-Track installation                                                        | `dependency-track.local`                                          |
| `frontend.ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[/]`                                                             |
| `frontend.ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                                             |
| `frontend.ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                                             |
| `frontend.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                              |
| `frontend.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                              |
| `frontend.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                              |
| `frontend.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                              |
| `frontend.extraArgs`                          | Additional container arguments                                                                        | `{}`                                                              |
| `frontend.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                              |
| `frontend.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                             |
| `frontend.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                             |
| `frontend.apiBaseUrl`                         | API base URL                                                                                          | `http://dependency-track.local`                                   |

### PostgreSQL parameters

| Name                                           | Description                                                          | Default            |
|------------------------------------------------|----------------------------------------------------------------------|--------------------|
| `postgresql.enabled`                           | Whether to use the PostgreSQL chart                                  | `true`             |
| `postgresql.auth.username`                     | PostgreSQL user                                                      | `dependency-track` |
| `postgresql.auth.password`                     | PostgreSQL password                                                  | `dependency-track` |
| `postgresql.auth.database`                     | PostgreSQL database                                                  | `dependency-track` |
| `postgresql.auth.existingSecret`               | Name of existing Secret to use                                       | `nil`              |
| `postgresql.architecture`                      | PostgreSQL architecture                                              | `standalone`       |
| `postgresql.primary.service.ports.postgresql`  | PostgreSQL port                                                      | `5432`             |
| `externalPostgresql.enabled`                   | Whether to use an external PostgreSQL                                | `false`            |
| `externalPostgresql.host`                      | External PostgreSQL host                                             | `postgresql`       |
| `externalPostgresql.port`                      | External PostgreSQL port                                             | `5432`             |
| `externalPostgresql.username`                  | External PostgreSQL user                                             | `dependency-track` |
| `externalPostgresql.password`                  | External PostgreSQL password                                         | `dependency-track` |
| `externalPostgresql.existingSecret`            | Name of existing Secret to use                                       | `nil`              |
| `externalPostgresql.existingSecretKeyPassword` | Name of the key in existing Secret that contains PostgreSQL password | `password`         |
| `externalPostgresql.database`                  | External PostgreSQL database                                         | `dependency-track` |

### Tests parameters

| Name                     | Description       | Default              |
|--------------------------|-------------------|----------------------|
| `tests.image.registry`   | Image registry    | `ghcr.io`            |
| `tests.image.repository` | Image repository  | `cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.35`             |
| `tests.image.digest`     | Image digest      | `""`                 |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`       |

### Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/dependency-track
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/dependency-track
```

**TIP**: You can use the default [values.yaml](values.yaml).
