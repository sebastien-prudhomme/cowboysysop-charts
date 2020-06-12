{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.nmapEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "nmap-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.nmapEngine.componentLabels" -}}
app.kubernetes.io/component: nmap-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.nmapEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.nmapEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.nmapEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.nmapEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.nmapEngine.serviceAccountName" -}}
{{- if .Values.nmapEngine.serviceAccount.create -}}
    {{ default (include "patrowl.nmapEngine.fullname" .) .Values.nmapEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.nmapEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
