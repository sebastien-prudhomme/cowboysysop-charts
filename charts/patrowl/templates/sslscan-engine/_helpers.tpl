{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.sslscanEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "sslscan-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.sslscanEngine.componentLabels" -}}
app.kubernetes.io/component: sslscan-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.sslscanEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.sslscanEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.sslscanEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.sslscanEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.sslscanEngine.serviceAccountName" -}}
{{- if .Values.sslscanEngine.serviceAccount.create -}}
    {{ default (include "patrowl.sslscanEngine.fullname" .) .Values.sslscanEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.sslscanEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
