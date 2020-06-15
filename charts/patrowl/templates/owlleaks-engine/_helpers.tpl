{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.owlleaksEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "owlleaks-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.owlleaksEngine.componentLabels" -}}
app.kubernetes.io/component: owlleaks-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.owlleaksEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.owlleaksEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.owlleaksEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.owlleaksEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.owlleaksEngine.serviceAccountName" -}}
{{- if .Values.owlleaksEngine.serviceAccount.create -}}
    {{ default (include "patrowl.owlleaksEngine.fullname" .) .Values.owlleaksEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.owlleaksEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
