{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dependency-track.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dependency-track.fullname" -}}
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
{{- define "dependency-track.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dependency-track.labels" -}}
helm.sh/chart: {{ include "dependency-track.chart" . }}
{{ include "dependency-track.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dependency-track.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dependency-track.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
PostgreSQL fully qualified app name
*/}}
{{- define "dependency-track.postgresql.fullname" -}}
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
{{- define "dependency-track.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- if eq .Values.postgresql.architecture "replication" -}}
    {{- if .Values.postgresql.fullnameOverride -}}
    {{- printf "%s-%s" .Values.postgresql.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "dependency-track.postgresql.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalPostgresql.host }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL port
*/}}
{{- define "dependency-track.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.primary.service.ports.postgresql }}
{{- else -}}
    {{ .Values.externalPostgresql.port }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL user
*/}}
{{- define "dependency-track.postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.username }}
{{- else -}}
    {{ .Values.externalPostgresql.username }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL secret name
*/}}
{{- define "dependency-track.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret -}}
    {{ .Values.postgresql.auth.existingSecret }}
{{- else if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecret }}
{{- else -}}
    {{ include "dependency-track.postgresql.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL password secret key name
*/}}
{{- define "dependency-track.postgresql.secretKeyNamePassword" -}}
{{- if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecretKeyPassword }}
{{- else -}}
    password
{{- end -}}
{{- end -}}

{{/*
PostgreSQL database
*/}}
{{- define "dependency-track.postgresql.database" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.database }}
{{- else -}}
    {{ .Values.externalPostgresql.database }}
{{- end -}}
{{- end -}}
