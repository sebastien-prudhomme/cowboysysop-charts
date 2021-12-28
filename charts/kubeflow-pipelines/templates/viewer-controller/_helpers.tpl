{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.viewerController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "viewer-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.viewerController.componentLabels" -}}
app.kubernetes.io/component: viewer-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.viewerController.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.viewerController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.viewerController.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.viewerController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.viewerController.serviceAccountName" -}}
{{- if .Values.viewerController.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.viewerController.fullname" .) .Values.viewerController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.viewerController.serviceAccount.name }}
{{- end -}}
{{- end -}}
