{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.mlMetadata.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "ml-metadata" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.mlMetadata.componentLabels" -}}
app.kubernetes.io/component: ml-metadata
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.mlMetadata.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.mlMetadata.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.mlMetadata.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.mlMetadata.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.mlMetadata.serviceAccountName" -}}
{{- if .Values.mlMetadata.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.mlMetadata.fullname" .) .Values.mlMetadata.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.mlMetadata.serviceAccount.name }}
{{- end -}}
{{- end -}}
