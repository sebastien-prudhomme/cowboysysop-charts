{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kserve.modelsWebApp.fullname" -}}
{{- printf "%s-%s" (include "kserve.fullname" .) "models-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kserve.modelsWebApp.componentLabels" -}}
app.kubernetes.io/component: models-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kserve.modelsWebApp.labels" -}}
{{ include "kserve.labels" . }}
{{ include "kserve.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kserve.modelsWebApp.selectorLabels" -}}
{{ include "kserve.selectorLabels" . }}
{{ include "kserve.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kserve.modelsWebApp.serviceAccountName" -}}
{{- if .Values.modelsWebApp.serviceAccount.create -}}
    {{ default (include "kserve.modelsWebApp.fullname" .) .Values.modelsWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.modelsWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
