{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "patrowl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "patrowl.fullname" -}}
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
Create a default fully qualified app name (engine-sslscan component).
*/}}
{{- define "patrowl.sslscanEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "engine-sslscan" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "patrowl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels (engine-sslscan component)
*/}}
{{- define "patrowl.sslscanEngine.componentLabels" -}}
app.kubernetes.io/component: engine-sslscan
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.labels" -}}
helm.sh/chart: {{ include "patrowl.chart" . }}
{{ include "patrowl.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common labels (engine-sslscan component)
*/}}
{{- define "patrowl.sslscanEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.sslscanEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "patrowl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels (engine-sslscan component)
*/}}
{{- define "patrowl.sslscanEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.sslscanEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "patrowl.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (engine-sslscan component)
*/}}
{{- define "patrowl.sslscanEngine.serviceAccountName" -}}
{{- if .Values.sslscanEngine.serviceAccount.create -}}
    {{ default (include "patrowl.sslscanEngine.fullname" .) .Values.sslscanEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.sslscanEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
