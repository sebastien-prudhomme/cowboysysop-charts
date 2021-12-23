{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.visualizationServer.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "visualization-server" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.visualizationServer.componentLabels" -}}
app.kubernetes.io/component: visualization-server
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.visualizationServer.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.visualizationServer.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.visualizationServer.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.visualizationServer.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.visualizationServer.serviceAccountName" -}}
{{- if .Values.visualizationServer.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.visualizationServer.fullname" .) .Values.visualizationServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.visualizationServer.serviceAccount.name }}
{{- end -}}
{{- end -}}
