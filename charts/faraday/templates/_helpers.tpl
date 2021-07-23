{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "faraday.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "faraday.fullname" -}}
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
{{- define "faraday.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "faraday.labels" -}}
helm.sh/chart: {{ include "faraday.chart" . }}
{{ include "faraday.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "faraday.selectorLabels" -}}
app.kubernetes.io/name: {{ include "faraday.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "faraday.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "faraday.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "faraday.secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "faraday.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL fully qualified app name
*/}}
{{- define "faraday.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL host
*/}}
{{- define "faraday.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
    {{ include "faraday.postgresql.fullname" . }}
{{- else -}}
    {{ .Values.externalPostgresql.host }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL port
*/}}
{{- define "faraday.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.service.port }}
{{- else -}}
    {{ .Values.externalPostgresql.port }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL user
*/}}
{{- define "faraday.postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.postgresqlUsername }}
{{- else -}}
    {{ .Values.externalPostgresql.username }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL secret name
*/}}
{{- define "faraday.postgresql.secretName" -}}
{{- if .Values.postgresql.existingSecret -}}
    {{ .Values.postgresql.existingSecret }}
{{- else if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecret }}
{{- else -}}
    {{ include "faraday.postgresql.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL database
*/}}
{{- define "faraday.postgresql.database" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.postgresqlDatabase }}
{{- else -}}
    {{ .Values.externalPostgresql.database }}
{{- end -}}
{{- end -}}
