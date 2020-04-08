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
Create a default fully qualified app name (admission controller component).
*/}}
{{- define "jitsi-meet.admissionController.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "admission-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (admission controller component).
*/}}
{{- define "jitsi-meet.admissionController.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.admissionController.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (recommender component).
*/}}
{{- define "jitsi-meet.recommender.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "recommender" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (recommender component).
*/}}
{{- define "jitsi-meet.recommender.metrics.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.recommender.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
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
Component labels (admission controller component)
*/}}
{{- define "jitsi-meet.admissionController.componentLabels" -}}
app.kubernetes.io/component: admission-controller
{{- end -}}

{{/*
Component labels (recommender component)
*/}}
{{- define "jitsi-meet.recommender.componentLabels" -}}
app.kubernetes.io/component: recommender
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
Common labels (admission controller component)
*/}}
{{- define "jitsi-meet.admissionController.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.admissionController.componentLabels" . }}
{{- end -}}

{{/*
Common labels (recommender component)
*/}}
{{- define "jitsi-meet.recommender.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.recommender.componentLabels" . }}
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
Selector labels (admission controller component)
*/}}
{{- define "jitsi-meet.admissionController.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.admissionController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (recommender component)
*/}}
{{- define "jitsi-meet.recommender.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.recommender.componentLabels" . }}
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
Create the name of the service account to use (admission controller component)
*/}}
{{- define "jitsi-meet.admissionController.serviceAccountName" -}}
{{- if .Values.admissionController.serviceAccount.create -}}
    {{ default (include "jitsi-meet.admissionController.fullname" .) .Values.admissionController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.admissionController.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (recommender component)
*/}}
{{- define "jitsi-meet.recommender.serviceAccountName" -}}
{{- if .Values.recommender.serviceAccount.create -}}
    {{ default (include "jitsi-meet.recommender.fullname" .) .Values.recommender.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.recommender.serviceAccount.name }}
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
Create the name of the tls secret to use (admission controller component)
*/}}
{{- define "jitsi-meet.admissionController.tls.secretName" -}}
{{- if .Values.admissionController.tls.existingSecret -}}
    {{ .Values.admissionController.tls.existingSecret }}
{{- else -}}
    {{- printf "%s-%s" (include "jitsi-meet.admissionController.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
