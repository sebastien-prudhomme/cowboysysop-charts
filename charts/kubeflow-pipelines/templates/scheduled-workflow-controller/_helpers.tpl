{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.scheduledWorkflowController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "scheduled-workflow-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.scheduledWorkflowController.componentLabels" -}}
app.kubernetes.io/component: scheduled-workflow-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.scheduledWorkflowController.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.scheduledWorkflowController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.scheduledWorkflowController.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.scheduledWorkflowController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.scheduledWorkflowController.serviceAccountName" -}}
{{- if .Values.scheduledWorkflowController.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.scheduledWorkflowController.fullname" .) .Values.scheduledWorkflowController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.scheduledWorkflowController.serviceAccount.name }}
{{- end -}}
{{- end -}}
