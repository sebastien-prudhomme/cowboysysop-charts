{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.urlvoidEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "urlvoid-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.urlvoidEngine.componentLabels" -}}
app.kubernetes.io/component: urlvoid-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.urlvoidEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.urlvoidEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.urlvoidEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.urlvoidEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.urlvoidEngine.serviceAccountName" -}}
{{- if .Values.urlvoidEngine.serviceAccount.create -}}
    {{ default (include "patrowl.urlvoidEngine.fullname" .) .Values.urlvoidEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.urlvoidEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
