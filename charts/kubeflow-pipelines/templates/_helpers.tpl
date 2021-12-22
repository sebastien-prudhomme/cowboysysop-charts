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
MariaDB fully qualified app name
*/}}
{{- define "kubeflow-pipelines.mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MariaDB host
*/}}
{{- define "kubeflow-pipelines.mariadb.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- if eq .Values.mariadb.architecture "replication" -}}
    {{- if .Values.mariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.mariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "kubeflow-pipelines.mariadb.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalMariadb.host }}
{{- end -}}
{{- end -}}

{{/*
MariaDB port
*/}}
{{- define "kubeflow-pipelines.mariadb.port" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.primary.service.port }}
{{- else -}}
    {{ .Values.externalMariadb.port }}
{{- end -}}
{{- end -}}

{{/*
MariaDB user
*/}}
{{- define "kubeflow-pipelines.mariadb.username" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.username }}
{{- else -}}
    {{ .Values.externalMariadb.username }}
{{- end -}}
{{- end -}}

{{/*
MariaDB secret name
*/}}
{{- define "kubeflow-pipelines.mariadb.secretName" -}}
{{- if .Values.mariadb.auth.existingSecret -}}
    {{ .Values.mariadb.auth.existingSecret }}
{{- else if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecret }}
{{- else -}}
    {{ include "kubeflow-pipelines.mariadb.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
MariaDB password secret key name
*/}}
{{- define "kubeflow-pipelines.mariadb.secretKeyNamePassword" -}}
{{- if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecretKeyPassword }}
{{- else -}}
    mariadb-password
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "kubeflow-pipelines.mariadb.database" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.database }}
{{- else -}}
    {{ .Values.externalMariadb.database }}
{{- end -}}
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
