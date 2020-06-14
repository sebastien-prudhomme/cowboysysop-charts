{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.ssllabsEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "ssllabs-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.ssllabsEngine.componentLabels" -}}
app.kubernetes.io/component: ssllabs-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.ssllabsEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.ssllabsEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.ssllabsEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.ssllabsEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.ssllabsEngine.serviceAccountName" -}}
{{- if .Values.ssllabsEngine.serviceAccount.create -}}
    {{ default (include "patrowl.ssllabsEngine.fullname" .) .Values.ssllabsEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.ssllabsEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
