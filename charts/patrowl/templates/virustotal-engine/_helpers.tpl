{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.virustotalEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "virustotal-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.virustotalEngine.componentLabels" -}}
app.kubernetes.io/component: virustotal-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.virustotalEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.virustotalEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.virustotalEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.virustotalEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.virustotalEngine.serviceAccountName" -}}
{{- if .Values.virustotalEngine.serviceAccount.create -}}
    {{ default (include "patrowl.virustotalEngine.fullname" .) .Values.virustotalEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.virustotalEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
