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
Create a default fully qualified app name (jigasi component).
*/}}
{{- define "jitsi-meet.jigasi.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jigasi" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (jigasi component).
*/}}
{{- define "jitsi-meet.jigasi.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.jigasi.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
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
Create a default fully qualified app name (prosody component).
*/}}
{{- define "jitsi-meet.prosody.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "prosody" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (prosody component).
*/}}
{{- define "jitsi-meet.prosody.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.prosody.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
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
Component labels (jigasi component)
*/}}
{{- define "jitsi-meet.jigasi.componentLabels" -}}
app.kubernetes.io/component: jigasi
{{- end -}}

{{/*
Component labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.componentLabels" -}}
app.kubernetes.io/component: jvb
{{- end -}}

{{/*
Component labels (prosody component)
*/}}
{{- define "jitsi-meet.prosody.componentLabels" -}}
app.kubernetes.io/component: prosody
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
Common labels (jigasi component)
*/}}
{{- define "jitsi-meet.jigasi.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jigasi.componentLabels" . }}
{{- end -}}

{{/*
Common labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Common labels (prosody component)
*/}}
{{- define "jitsi-meet.prosody.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.prosody.componentLabels" . }}
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
Selector labels (jigasi component)
*/}}
{{- define "jitsi-meet.jigasi.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jigasi.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (jvb component)
*/}}
{{- define "jitsi-meet.jvb.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (prosody component)
*/}}
{{- define "jitsi-meet.prosody.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.prosody.componentLabels" . }}
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
Create the name of the service account to use (jigasi component)
*/}}
{{- define "jitsi-meet.jigasi.serviceAccountName" -}}
{{- if .Values.jigasi.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jigasi.fullname" .) .Values.jigasi.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jigasi.serviceAccount.name }}
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
Create the name of the service account to use (prosody component)
*/}}
{{- define "jitsi-meet.prosody.serviceAccountName" -}}
{{- if .Values.prosody.serviceAccount.create -}}
    {{ default (include "jitsi-meet.prosody.fullname" .) .Values.prosody.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.prosody.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use (jicofo component)
*/}}
{{- define "jitsi-meet.jicofo.secretName" -}}
{{- if .Values.jicofo.existingSecret -}}
    {{ .Values.jicofo.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jicofo.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use (jigasi component)
*/}}
{{- define "jitsi-meet.jigasi.secretName" -}}
{{- if .Values.jigasi.existingSecret -}}
    {{ .Values.jigasi.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jigasi.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use (jvb component)
*/}}
{{- define "jitsi-meet.jvb.secretName" -}}
{{- if .Values.jvb.existingSecret -}}
    {{ .Values.jvb.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jvb.fullname" . }}
{{- end -}}
{{- end -}}
