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
Create chart name and version as used by the chart label.
*/}}
{{- define "scaleway-csi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.componentLabels" -}}
app.kubernetes.io/component: recommender
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
Common labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.recommender.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "scaleway-csi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "scaleway-csi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels (recommender component)
*/}}
{{- define "scaleway-csi.recommender.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.recommender.componentLabels" . }}
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
Create the name of the service account to use (recommender component)
*/}}
{{- define "scaleway-csi.recommender.serviceAccountName" -}}
{{- if .Values.recommender.serviceAccount.create -}}
    {{ default (include "scaleway-csi.recommender.fullname" .) .Values.recommender.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.recommender.serviceAccount.name }}
{{- end -}}
{{- end -}}
