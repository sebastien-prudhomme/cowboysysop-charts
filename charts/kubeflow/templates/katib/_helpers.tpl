{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.katib.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "katib" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.katib.componentLabels" -}}
app.kubernetes.io/component: katib
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.katib.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.katib.componentLabels" . }}
{{- end -}}

{{/*
MariaDB fully qualified app name
*/}}
{{- define "kubeflow.katib.mariadb.fullname" -}}
{{- if .Values.katib.mariadb.fullnameOverride -}}
{{- .Values.katib.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.katib.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MariaDB host
*/}}
{{- define "kubeflow.katib.mariadb.host" -}}
{{- if .Values.katib.mariadb.enabled -}}
{{- if eq .Values.katib.mariadb.architecture "replication" -}}
    {{- if .Values.katib.mariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.katib.mariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.katib.mariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "kubeflow.katib.mariadb.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.katib.externalMariadb.host }}
{{- end -}}
{{- end -}}

{{/*
MariaDB port
*/}}
{{- define "kubeflow.katib.mariadb.port" -}}
{{- if .Values.katib.mariadb.enabled -}}
    {{ .Values.katib.mariadb.primary.service.port }}
{{- else -}}
    {{ .Values.katib.externalMariadb.port }}
{{- end -}}
{{- end -}}

{{/*
MariaDB user
*/}}
{{- define "kubeflow.katib.mariadb.username" -}}
{{- if .Values.katib.mariadb.enabled -}}
    {{ .Values.katib.mariadb.auth.username }}
{{- else -}}
    {{ .Values.katib.externalMariadb.username }}
{{- end -}}
{{- end -}}

{{/*
MariaDB secret name
*/}}
{{- define "kubeflow.katib.mariadb.secretName" -}}
{{- if .Values.katib.mariadb.auth.existingSecret -}}
    {{ .Values.katib.mariadb.auth.existingSecret }}
{{- else if .Values.katib.externalMariadb.existingSecret -}}
    {{ .Values.katib.externalMariadb.existingSecret }}
{{- else -}}
    {{ include "kubeflow.katib.mariadb.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "kubeflow.katib.mariadb.database" -}}
{{- if .Values.katib.mariadb.enabled -}}
    {{ .Values.katib.mariadb.auth.database }}
{{- else -}}
    {{ .Values.katib.externalMariadb.database }}
{{- end -}}
{{- end -}}
