{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.owldnsEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "owldns-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.owldnsEngine.componentLabels" -}}
app.kubernetes.io/component: owldns-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.owldnsEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.owldnsEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.owldnsEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.owldnsEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.owldnsEngine.serviceAccountName" -}}
{{- if .Values.owldnsEngine.serviceAccount.create -}}
    {{ default (include "patrowl.owldnsEngine.fullname" .) .Values.owldnsEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.owldnsEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
