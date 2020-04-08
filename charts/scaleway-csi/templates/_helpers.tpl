{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "scaleway-csi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "scaleway-csi.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name (controller component).
*/}}
{{- define "scaleway-csi.controller.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.fullname" .) "controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (controller component).
*/}}
{{- define "scaleway-csi.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (recommender component).
*/}}
{{- define "scaleway-csi.recommender.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.fullname" .) "recommender" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (recommender component).
*/}}
{{- define "scaleway-csi.recommender.metrics.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.recommender.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (updater component).
*/}}
{{- define "scaleway-csi.updater.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.fullname" .) "updater" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (updater component).
*/}}
{{- define "scaleway-csi.updater.metrics.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.updater.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "scaleway-csi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels (controller component)
*/}}
{{- define "scaleway-csi.controller.componentLabels" -}}
app.kubernetes.io/component: controller
{{- end -}}

{{/*
Component labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.componentLabels" -}}
app.kubernetes.io/component: recommender
{{- end -}}

{{/*
Component labels (updater component)
*/}}
{{- define "scaleway-csi.updater.componentLabels" -}}
app.kubernetes.io/component: updater
{{- end -}}

{{/*
Common labels
*/}}
{{- define "scaleway-csi.labels" -}}
helm.sh/chart: {{ include "scaleway-csi.chart" . }}
{{ include "scaleway-csi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common labels (controller component)
*/}}
{{- define "scaleway-csi.controller.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.controller.componentLabels" . }}
{{- end -}}

{{/*
Common labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.recommender.componentLabels" . }}
{{- end -}}

{{/*
Common labels (updater component)
*/}}
{{- define "scaleway-csi.updater.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.updater.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "scaleway-csi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "scaleway-csi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels (controller component)
*/}}
{{- define "scaleway-csi.controller.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.recommender.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (updater component)
*/}}
{{- define "scaleway-csi.updater.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.updater.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "scaleway-csi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "scaleway-csi.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (controller component)
*/}}
{{- define "scaleway-csi.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "scaleway-csi.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (recommender component)
*/}}
{{- define "scaleway-csi.recommender.serviceAccountName" -}}
{{- if .Values.recommender.serviceAccount.create -}}
    {{ default (include "scaleway-csi.recommender.fullname" .) .Values.recommender.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.recommender.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (updater component)
*/}}
{{- define "scaleway-csi.updater.serviceAccountName" -}}
{{- if .Values.updater.serviceAccount.create -}}
    {{ default (include "scaleway-csi.updater.fullname" .) .Values.updater.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.updater.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use (controller component)
*/}}
{{- define "scaleway-csi.controller.tls.secretName" -}}
{{- if .Values.controller.tls.existingSecret -}}
    {{ .Values.controller.tls.existingSecret }}
{{- else -}}
    {{- printf "%s-%s" (include "scaleway-csi.controller.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
