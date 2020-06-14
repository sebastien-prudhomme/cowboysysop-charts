{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.arachniEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "arachni-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.arachniEngine.componentLabels" -}}
app.kubernetes.io/component: arachni-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.arachniEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.arachniEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.arachniEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.arachniEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.arachniEngine.serviceAccountName" -}}
{{- if .Values.arachniEngine.serviceAccount.create -}}
    {{ default (include "patrowl.arachniEngine.fullname" .) .Values.arachniEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.arachniEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
