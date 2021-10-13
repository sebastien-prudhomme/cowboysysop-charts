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
{{- if .Values.katibMariadb.fullnameOverride -}}
{{- .Values.katibMariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.katibMariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MariaDB host
*/}}
{{- define "kubeflow.katib.mariadb.host" -}}
{{- if .Values.katibMariadb.enabled -}}
{{- if eq .Values.katibMariadb.architecture "replication" -}}
    {{- if .Values.katibMariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.katibMariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.katibMariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "kubeflow.katib.mariadb.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.katibExternalMariadb.host }}
{{- end -}}
{{- end -}}

{{/*
MariaDB port
*/}}
{{- define "kubeflow.katib.mariadb.port" -}}
{{- if .Values.katibMariadb.enabled -}}
    {{ .Values.katibMariadb.primary.service.port }}
{{- else -}}
    {{ .Values.katibExternalMariadb.port }}
{{- end -}}
{{- end -}}

{{/*
MariaDB user
*/}}
{{- define "kubeflow.katib.mariadb.username" -}}
{{- if .Values.katibMariadb.enabled -}}
    {{ .Values.katibMariadb.auth.username }}
{{- else -}}
    {{ .Values.katibExternalMariadb.username }}
{{- end -}}
{{- end -}}

{{/*
MariaDB secret name
*/}}
{{- define "kubeflow.katib.mariadb.secretName" -}}
{{- if .Values.katibMariadb.auth.existingSecret -}}
    {{ .Values.katibMariadb.auth.existingSecret }}
{{- else if .Values.katibExternalMariadb.existingSecret -}}
    {{ .Values.katibExternalMariadb.existingSecret }}
{{- else -}}
    {{ include "kubeflow.katib.mariadb.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "kubeflow.katib.mariadb.database" -}}
{{- if .Values.katibMariadb.enabled -}}
    {{ .Values.katibMariadb.auth.database }}
{{- else -}}
    {{ .Values.katibExternalMariadb.database }}
{{- end -}}
{{- end -}}
