# [[ application.productName ]]

[["["]][[ application.productName ]][["]"]]([[ application.home ]]) [[ application.description | replace("<<", "") | replace(">>", "") ]].

**DISCLAIMER**: This is an unofficial chart not supported by [[ application.productName ]] authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/[[ application.name ]]
```

## Introduction

This chart bootstraps a [[ application.productName ]] deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

[[ application.prerequisites | trim ]]
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/[[ application.name ]]
```

These commands deploy [[ application.productName ]] on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/[[ application.name ]]
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.
[%- if application.updates %]

[[ application.updates | trim ]]
[%- endif %]

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

###

## Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/[[ application.name ]]
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/[[ application.name ]]
```

**TIP**: You can use the default [values.yaml](values.yaml).
