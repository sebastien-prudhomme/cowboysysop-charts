{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kubeflow-pipelines.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubeflow-pipelines.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "kubeflow-pipelines.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.labels" -}}
helm.sh/chart: {{ include "kubeflow-pipelines.chart" . }}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubeflow-pipelines.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
MinIO fully qualified app name
*/}}
{{- define "kubeflow-pipelines.minio.fullname" -}}
{{- if .Values.minio.fullnameOverride -}}
{{- .Values.minio.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "minio" .Values.minio.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MinIO host
*/}}
{{- define "kubeflow-pipelines.minio.host" -}}
{{- if .Values.minio.enabled -}}
    {{ include "kubeflow-pipelines.minio.fullname" . }}
{{- else -}}
    {{ .Values.externalMinio.host }}
{{- end -}}
{{- end -}}

{{/*
MinIO port
*/}}
{{- define "kubeflow-pipelines.minio.port" -}}
{{- if .Values.minio.enabled -}}
    {{ .Values.minio.service.ports.api }}
{{- else -}}
    {{ .Values.externalMinio.port }}
{{- end -}}
{{- end -}}

{{/*
MinIO secret name
*/}}
{{- define "kubeflow-pipelines.minio.secretName" -}}
{{- if .Values.minio.auth.existingSecret -}}
    {{ .Values.minio.auth.existingSecret }}
{{- else if .Values.externalMinio.existingSecret -}}
    {{ .Values.externalMinio.existingSecret }}
{{- else -}}
    {{ include "kubeflow-pipelines.minio.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
MinIO root user secret key name
*/}}
{{- define "kubeflow-pipelines.minio.secretKeyNameRootUser" -}}
{{- if .Values.externalMinio.existingSecret -}}
    {{ .Values.externalMinio.existingSecretKeyRootUser }}
{{- else -}}
    root-user
{{- end -}}
{{- end -}}

{{/*
MinIO root password secret key name
*/}}
{{- define "kubeflow-pipelines.minio.secretKeyNameRootPassword" -}}
{{- if .Values.externalMinio.existingSecret -}}
    {{ .Values.externalMinio.existingSecretKeyRootPassword }}
{{- else -}}
    root-password
{{- end -}}
{{- end -}}
