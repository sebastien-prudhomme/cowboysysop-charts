{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.notebookController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebook-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.notebookController.componentLabels" -}}
app.kubernetes.io/component: notebook-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.notebookController.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.notebookController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.notebookController.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.notebookController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.notebookController.serviceAccountName" -}}
{{- if .Values.notebookController.serviceAccount.create -}}
    {{ default (include "kubeflow.notebookController.fullname" .) .Values.notebookController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.notebookController.serviceAccount.name }}
{{- end -}}
{{- end -}}
