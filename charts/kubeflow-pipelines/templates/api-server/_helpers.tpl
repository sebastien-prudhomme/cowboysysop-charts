{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.apiServer.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "api-server" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.apiServer.componentLabels" -}}
app.kubernetes.io/component: api-server
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.apiServer.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.apiServer.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.apiServer.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.apiServer.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.apiServer.serviceAccountName" -}}
{{- if .Values.apiServer.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.apiServer.fullname" .) .Values.apiServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.apiServer.serviceAccount.name }}
{{- end -}}
{{- end -}}
