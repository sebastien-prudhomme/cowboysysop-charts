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

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following table lists all the configurable parameters expose by the Jitsi Meet chart and their default values.

| Name                                  | Description                                                                                     | Default                                                     |
|---------------------------------------|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| `imagePullSecrets`                    | Docker registry secret names as an array                                                        | `[]`                                                        |
| `nameOverride`                        | Partially override `jitsi-meet.fullname` template with a string (will prepend the release name) | `nil`                                                       |
| `fullnameOverride`                    | Fully override `jitsi-meet.fullname` template with a string                                     | `nil`                                                       |
| `etherpad.enabled`                    | Enable shared document editing with Etherpad                                                    | `false`                                                     |
| `etherpad.replicaCount`               | Number of replicas (etherpad component)                                                         | `1`                                                         |
| `etherpad.image.repository`           | Jitsi Meet image name (etherpad component)                                                      | `jitsi/etherpad`                                            |
| `etherpad.image.tag`                  | Jitsi Meet image tag (etherpad component)                                                       | `4384-1`                                                    |
| `etherpad.image.pullPolicy`           | Image pull policy (etherpad component)                                                          | `IfNotPresent`                                              |
| `etherpad.serviceAccount.create`      | Specify whether to create a ServiceAccount (etherpad component)                                 | `true`                                                      |
| `etherpad.serviceAccount.annotations` | ServiceAccount annotations (etherpad component)                                                 | `{}`                                                        |
| `etherpad.serviceAccount.name`        | The name of the ServiceAccount to create (etherpad component)                                   | Generated using the `jitsi-meet.etherpad.fullname` template |
| `etherpad.podAnnotations`             | Additional pod annotations (etherpad component)                                                 | `{}`                                                        |
| `etherpad.podLabels`                  | Additional pod labels (etherpad component)                                                      | `{}`                                                        |
| `etherpad.podSecurityContext`         | Pod security context (etherpad component)                                                       | `{}`                                                        |
| `etherpad.securityContext`            | Container security context (etherpad component)                                                 | `{}`                                                        |
| `etherpad.service.type`               | Kubernetes Service type (etherpad component)                                                    | `ClusterIP`                                                 |
| `etherpad.service.port`               | Jitsi Meet service port (etherpad component)                                                    | `9001`                                                      |
| `etherpad.resources`                  | CPU/Memory resource requests/limits (etherpad component)                                        | `{}`                                                        |
| `etherpad.nodeSelector`               | Node labels for pod assignment (etherpad component)                                             | `{}`                                                        |
| `etherpad.tolerations`                | Tolerations for pod assignment (etherpad component)                                             | `[]`                                                        |
| `etherpad.affinity`                   | Map of node/pod affinities (etherpad component)                                                 | `{}`                                                        |
| `jibri.enabled`                       | Enable recording or streaming with Jibri                                                        | `false`                                                     |
| `jibri.replicaCount`                  | Number of replicas (jibri component)                                                            | `1`                                                         |
| `jibri.image.repository`              | Jitsi Meet image name (jibri component)                                                         | `jitsi/jibri`                                               |
| `jibri.image.tag`                     | Jitsi Meet image tag (jibri component)                                                          | `4384-1`                                                    |
| `jibri.image.pullPolicy`              | Image pull policy (jibri component)                                                             | `IfNotPresent`                                              |
| `jibri.serviceAccount.create`         | Specify whether to create a ServiceAccount (jibri component)                                    | `true`                                                      |
| `jibri.serviceAccount.annotations`    | ServiceAccount annotations (jibri component)                                                    | `{}`                                                        |
| `jibri.serviceAccount.name`           | The name of the ServiceAccount to create (jibri component)                                      | Generated using the `jitsi-meet.jibri.fullname` template    |
| `jibri.podAnnotations`                | Additional pod annotations (jibri component)                                                    | `{}`                                                        |
| `jibri.podLabels`                     | Additional pod labels (jibri component)                                                         | `{}`                                                        |
| `jibri.podSecurityContext`            | Pod security context (jibri component)                                                          | `{}`                                                        |
| `jibri.securityContext`               | Container security context (jibri component)                                                    | `{}`                                                        |
| `jibri.resources`                     | CPU/Memory resource requests/limits (jibri component)                                           | `{}`                                                        |
| `jibri.nodeSelector`                  | Node labels for pod assignment (jibri component)                                                | `{}`                                                        |
| `jibri.tolerations`                   | Tolerations for pod assignment (jibri component)                                                | `[]`                                                        |
| `jibri.affinity`                      | Map of node/pod affinities (jibri component)                                                    | `{}`                                                        |
| `jibri.recorderUser`                  | XMPP recorder user for Jibri client connections                                                 | `recorder`                                                  |
| `jibri.recorderPassword`              | XMPP recorder password for Jibri client connections                                             | Random 32 character long alphanumeric string                |
| `jibri.xmppUser`                      | XMPP user for Jibri client connections                                                          | `jibri`                                                     |
| `jibri.xmppPassword`                  | XMPP password for Jibri client connections                                                      | Random 32 character long alphanumeric string                |
| `jibri.existingSecret`                | Name of existing Secret to use (jibri component)                                                | `nil`                                                       |
| `jicofo.replicaCount`                 | Number of replicas (jicofo component)                                                           | `1`                                                         |
| `jicofo.image.repository`             | Jitsi Meet image name (jicofo component)                                                        | `jitsi/jicofo`                                              |
| `jicofo.image.tag`                    | Jitsi Meet image tag (jicofo component)                                                         | `4384-1`                                                    |
| `jicofo.image.pullPolicy`             | Image pull policy (jicofo component)                                                            | `IfNotPresent`                                              |
| `jicofo.serviceAccount.create`        | Specify whether to create a ServiceAccount (jicofo component)                                   | `true`                                                      |
| `jicofo.serviceAccount.annotations`   | ServiceAccount annotations (jicofo component)                                                   | `{}`                                                        |
| `jicofo.serviceAccount.name`          | The name of the ServiceAccount to create (jicofo component)                                     | Generated using the `jitsi-meet.jicofo.fullname` template   |
| `jicofo.podAnnotations`               | Additional pod annotations (jicofo component)                                                   | `{}`                                                        |
| `jicofo.podLabels`                    | Additional pod labels (jicofo component)                                                        | `{}`                                                        |
| `jicofo.podSecurityContext`           | Pod security context (jicofo component)                                                         | `{}`                                                        |
| `jicofo.securityContext`              | Container security context (jicofo component)                                                   | `{}`                                                        |
| `jicofo.service.type`                 | Kubernetes Service type (jicofo component)                                                      | `ClusterIP`                                                 |
| `jicofo.service.port`                 | Jitsi Meet service port (jicofo component)                                                      | `8000`                                                      |
| `jicofo.resources`                    | CPU/Memory resource requests/limits (jicofo component)                                          | `{}`                                                        |
| `jicofo.nodeSelector`                 | Node labels for pod assignment (jicofo component)                                               | `{}`                                                        |
| `jicofo.tolerations`                  | Tolerations for pod assignment (jicofo component)                                               | `[]`                                                        |
| `jicofo.affinity`                     | Map of node/pod affinities (jicofo component)                                                   | `{}`                                                        |
| `jicofo.componentSecret`              | XMPP component password for Jicofo                                                              | Random 32 character long alphanumeric string                |
| `jicofo.authUser`                     | XMPP user for Jicofo client connections                                                         | `focus`                                                     |
| `jicofo.authPassword`                 | XMPP password for Jicofo client connections                                                     | Random 32 character long alphanumeric string                |
| `jicofo.existingSecret`               | Name of existing Secret to use (jicofo component)                                               | `nil`                                                       |
| `jicofo.metrics.service.type`         | Metrics Kubernetes Service type (jicofo component)                                              | `ClusterIP`                                                 |
| `jicofo.metrics.service.port`         | Metrics service port (jicofo component)                                                         | `8944`                                                      |
| `jigasi.xmppUser`                     | XMPP user for Jigasi MUC client connections                                                     | `jigasi`                                                    |
| `jigasi.xmppPassword`                 | XMPP password for Jigasi MUC client connections                                                 | Random 32 character long alphanumeric string                |
| `jigasi.existingSecret`               | Name of existing Secret to use (jigasi component)                                               | `nil`                                                       |
| `jvb.replicaCount`                    | Number of replicas (jvb component)                                                              | `1`                                                         |
| `jvb.image.repository`                | Jitsi Meet image name (jvb component)                                                           | `jitsi/jvb`                                                 |
| `jvb.image.tag`                       | Jitsi Meet image tag (jvb component)                                                            | `4384-1`                                                    |
| `jvb.image.pullPolicy`                | Image pull policy (jvb component)                                                               | `IfNotPresent`                                              |
| `jvb.serviceAccount.create`           | Specify whether to create a ServiceAccount (jvb component)                                      | `true`                                                      |
| `jvb.serviceAccount.annotations`      | ServiceAccount annotations (jvb component)                                                      | `{}`                                                        |
| `jvb.serviceAccount.name`             | The name of the ServiceAccount to create (jvb component)                                        | Generated using the `jitsi-meet.jvb.fullname` template      |
| `jvb.podAnnotations`                  | Additional pod annotations (jvb component)                                                      | `{}`                                                        |
| `jvb.podLabels`                       | Additional pod labels (jvb component)                                                           | `{}`                                                        |
| `jvb.podSecurityContext`              | Pod security context (jvb component)                                                            | `{}`                                                        |
| `jvb.securityContext`                 | Container security context (jvb component)                                                      | `{}`                                                        |
| `jvb.resources`                       | CPU/Memory resource requests/limits (jvb component)                                             | `{}`                                                        |
| `jvb.nodeSelector`                    | Node labels for pod assignment (jvb component)                                                  | `{}`                                                        |
| `jvb.tolerations`                     | Tolerations for pod assignment (jvb component)                                                  | `[]`                                                        |
| `jvb.affinity`                        | Map of node/pod affinities (jvb component)                                                      | `{}`                                                        |
| `jvb.authUser`                        | XMPP user for JVB MUC client connections                                                        | `jvb`                                                       |
| `jvb.authPassword`                    | XMPP password for JVB MUC client connections                                                    | Random 32 character long alphanumeric string                |
| `jvb.existingSecret`                  | Name of existing Secret to use (jvb component)                                                  | `nil`                                                       |
| `jvb.breweryMuc`                      | MUC name for the JVB pool                                                                       | `jvbbrewery`                                                |
| `jvb.metrics.service.type`            | Metrics Kubernetes Service type (jvb component)                                                 | `ClusterIP`                                                 |
| `jvb.metrics.service.port`            | Metrics service port (jvb component)                                                            | `8942`                                                      |
| `prosody.replicaCount`                | Number of replicas (prosody component)                                                          | `1`                                                         |
| `prosody.image.repository`            | Jitsi Meet image name (prosody component)                                                       | `jitsi/prosody`                                             |
| `prosody.image.tag`                   | Jitsi Meet image tag (prosody component)                                                        | `4384-1`                                                    |
| `prosody.image.pullPolicy`            | Image pull policy (prosody component)                                                           | `IfNotPresent`                                              |
| `prosody.serviceAccount.create`       | Specify whether to create a ServiceAccount (prosody component)                                  | `true`                                                      |
| `prosody.serviceAccount.annotations`  | ServiceAccount annotations (prosody component)                                                  | `{}`                                                        |
| `prosody.serviceAccount.name`         | The name of the ServiceAccount to create (prosody component)                                    | Generated using the `jitsi-meet.prosody.fullname` template  |
| `prosody.podAnnotations`              | Additional pod annotations (prosody component)                                                  | `{}`                                                        |
| `prosody.podLabels`                   | Additional pod labels (prosody component)                                                       | `{}`                                                        |
| `prosody.podSecurityContext`          | Pod security context (prosody component)                                                        | `{}`                                                        |
| `prosody.securityContext`             | Container security context (prosody component)                                                  | `{}`                                                        |
| `prosody.resources`                   | CPU/Memory resource requests/limits (prosody component)                                         | `{}`                                                        |
| `prosody.nodeSelector`                | Node labels for pod assignment (prosody component)                                              | `{}`                                                        |
| `prosody.tolerations`                 | Tolerations for pod assignment (prosody component)                                              | `[]`                                                        |
| `prosody.affinity`                    | Map of node/pod affinities (prosody component)                                                  | `{}`                                                        |
| `prosody.metrics.service.type`        | Metrics Kubernetes Service type (prosody component)                                             | `ClusterIP`                                                 |
| `prosody.metrics.service.port`        | Metrics service port (prosody component)                                                        | `8943`                                                      |
| `xmpp.domain`                         | Internal XMPP domain                                                                            | `meet.jitsi`                                                |
| `xmpp.authDomain`                     | Internal XMPP domain for authenticated services                                                 | `auth.meet.jitsi`                                           |
| `xmpp.internalMucDomain`              | XMPP domain for the internal MUC                                                                | `internal-muc.meet.jitsi`                                   |
| `xmpp.internalMucModules`             | Custom Prosody modules for internal MUC component (comma separated)                             | `nil`                                                       |
| `xmpp.mucDomain`                      | XMPP domain for the MUC                                                                         | `muc.meet.jitsi`                                            |
| `xmpp.mucModules`                     | Custom Prosody modules for MUC component (comma separated)                                      | `nil`                                                       |
| `xmpp.recorderDomain`                 | Domain for the jibri recorder                                                                   | `recorder.meet.jitsi`                                       |
| `web.replicaCount`                    | Number of replicas (web component)                                                              | `1`                                                         |
| `web.image.repository`                | Jitsi Meet image name (web component)                                                           | `jitsi/web`                                                 |
| `web.image.tag`                       | Jitsi Meet image tag (web component)                                                            | `4384-1`                                                    |
| `web.image.pullPolicy`                | Image pull policy (web component)                                                               | `IfNotPresent`                                              |
| `web.serviceAccount.create`           | Specify whether to create a ServiceAccount (web component)                                      | `true`                                                      |
| `web.serviceAccount.annotations`      | ServiceAccount annotations (web component)                                                      | `{}`                                                        |
| `web.serviceAccount.name`             | The name of the ServiceAccount to create (web component)                                        | Generated using the `jitsi-meet.web.fullname` template      |
| `web.podAnnotations`                  | Additional pod annotations (web component)                                                      | `{}`                                                        |
| `web.podLabels`                       | Additional pod labels (web component)                                                           | `{}`                                                        |
| `web.podSecurityContext`              | Pod security context (web component)                                                            | `{}`                                                        |
| `web.securityContext`                 | Container security context (web component)                                                      | `{}`                                                        |
| `web.resources`                       | CPU/Memory resource requests/limits (web component)                                             | `{}`                                                        |
| `web.nodeSelector`                    | Node labels for pod assignment (web component)                                                  | `{}`                                                        |
| `web.tolerations`                     | Tolerations for pod assignment (web component)                                                  | `[]`                                                        |
| `web.affinity`                        | Map of node/pod affinities (web component)                                                      | `{}`                                                        |
| `web.publicUrl`                       | Public URL for the web service                                                                  | `https://jitsi-meet.local`                                  |
| `web.metrics.service.type`            | Metrics Kubernetes Service type (web component)                                                 | `ClusterIP`                                                 |
| `web.metrics.service.port`            | Metrics service port (web component)                                                            | `8943`                                                      |

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
