{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "patrowl.eyewitnessEngine.fullname" -}}
{{- printf "%s-%s" (include "patrowl.fullname" .) "eyewitness-engine" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "patrowl.eyewitnessEngine.componentLabels" -}}
app.kubernetes.io/component: eyewitness-engine
{{- end -}}

{{/*
Common labels
*/}}
{{- define "patrowl.eyewitnessEngine.labels" -}}
{{ include "patrowl.labels" . }}
{{ include "patrowl.eyewitnessEngine.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "patrowl.eyewitnessEngine.selectorLabels" -}}
{{ include "patrowl.selectorLabels" . }}
{{ include "patrowl.eyewitnessEngine.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "patrowl.eyewitnessEngine.serviceAccountName" -}}
{{- if .Values.eyewitnessEngine.serviceAccount.create -}}
    {{ default (include "patrowl.eyewitnessEngine.fullname" .) .Values.eyewitnessEngine.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.eyewitnessEngine.serviceAccount.name }}
{{- end -}}
{{- end -}}
