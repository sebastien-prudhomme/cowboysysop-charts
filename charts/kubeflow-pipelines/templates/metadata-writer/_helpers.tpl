{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.metadataWriter.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "metadata-writer" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.metadataWriter.componentLabels" -}}
app.kubernetes.io/component: metadata-writer
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.metadataWriter.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.metadataWriter.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.metadataWriter.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.metadataWriter.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.metadataWriter.serviceAccountName" -}}
{{- if .Values.metadataWriter.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.metadataWriter.fullname" .) .Values.metadataWriter.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.metadataWriter.serviceAccount.name }}
{{- end -}}
{{- end -}}
