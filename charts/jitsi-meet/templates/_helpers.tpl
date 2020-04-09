{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jitsi-meet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jitsi-meet.fullname" -}}
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
Create a default fully qualified app name (jicofo component).
*/}}
{{- define "jitsi-meet.jicofo.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jicofo" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (jicofo component).
*/}}
{{- define "jitsi-meet.jicofo.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.jicofo.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (jvb component).
*/}}
{{- define "jitsi-meet.jvb.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jvb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (jvb component).
*/}}
{{- define "jitsi-meet.jvb.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.jvb.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (web component).
*/}}
{{- define "jitsi-meet.web.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "web" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (web component).
*/}}
{{- define "jitsi-meet.web.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.web.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jitsi-meet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.componentLabels" -}}
app.kubernetes.io/component: jicofo
{{- end -}}

{{/*
Component labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.componentLabels" -}}
app.kubernetes.io/component: jvb
{{- end -}}

{{/*
Component labels (web component)
*/}}
{{- define "jitsi-meet.web.componentLabels" -}}
app.kubernetes.io/component: web
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.labels" -}}
helm.sh/chart: {{ include "jitsi-meet.chart" . }}
{{ include "jitsi-meet.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common labels (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jicofo.componentLabels" . }}
{{- end -}}

{{/*
Common labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Common labels (web component)
*/}}
{{- define "jitsi-meet.web.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.web.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jitsi-meet.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jicofo.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (web component)
*/}}
{{- define "jitsi-meet.web.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.web.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "jitsi-meet.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.serviceAccountName" -}}
{{- if .Values.jicofo.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jicofo.fullname" .) .Values.jicofo.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jicofo.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (jvb component)
*/}}
{{- define "jitsi-meet.jvb.serviceAccountName" -}}
{{- if .Values.jvb.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jvb.fullname" .) .Values.jvb.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jvb.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (web component)
*/}}
{{- define "jitsi-meet.web.serviceAccountName" -}}
{{- if .Values.web.serviceAccount.create -}}
    {{ default (include "jitsi-meet.web.fullname" .) .Values.web.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.web.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.tls.secretName" -}}
{{- if .Values.jicofo.tls.existingSecret -}}
    {{ .Values.jicofo.tls.existingSecret }}
{{- else -}}
    {{- printf "%s-%s" (include "jitsi-meet.jicofo.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
