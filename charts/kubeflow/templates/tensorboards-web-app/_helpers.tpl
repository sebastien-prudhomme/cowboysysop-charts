{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.tensorboardsWebApp.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "tensorboards-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.tensorboardsWebApp.componentLabels" -}}
app.kubernetes.io/component: tensorboards-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.tensorboardsWebApp.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.tensorboardsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.tensorboardsWebApp.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.tensorboardsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.tensorboardsWebApp.serviceAccountName" -}}
{{- if .Values.tensorboardsWebApp.serviceAccount.create -}}
    {{ default (include "kubeflow.tensorboardsWebApp.fullname" .) .Values.tensorboardsWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.tensorboardsWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
