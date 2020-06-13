{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.manager.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "manager" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.manager.componentLabels" -}}
app.kubernetes.io/component: manager
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.manager.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.manager.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.manager.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.manager.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.manager.serviceAccountName" -}}
{{- if .Values.manager.serviceAccount.create -}}
    {{ default (include "patrowl.manager.fullname" .) .Values.manager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.manager.serviceAccount.name }}
{{- end -}}
{{- end -}}
