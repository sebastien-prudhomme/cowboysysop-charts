{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.modelsWebApp.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "models-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.modelsWebApp.componentLabels" -}}
app.kubernetes.io/component: models-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.modelsWebApp.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.modelsWebApp.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.modelsWebApp.serviceAccountName" -}}
{{- if .Values.modelsWebApp.serviceAccount.create -}}
    {{ default (include "kubeflow.modelsWebApp.fullname" .) .Values.modelsWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.modelsWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
