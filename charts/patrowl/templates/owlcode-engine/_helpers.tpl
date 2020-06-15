{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.owlcodeEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "owlcode-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.owlcodeEngine.componentLabels" -}}
app.kubernetes.io/component: owlcode-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.owlcodeEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.owlcodeEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.owlcodeEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.owlcodeEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.owlcodeEngine.serviceAccountName" -}}
{{- if .Values.owlcodeEngine.serviceAccount.create -}}
    {{ default (include "patrowl.owlcodeEngine.fullname" .) .Values.owlcodeEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.owlcodeEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
