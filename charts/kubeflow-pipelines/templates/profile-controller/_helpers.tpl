{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.profileController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "profile-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.profileController.componentLabels" -}}
app.kubernetes.io/component: profile-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.profileController.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.profileController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.profileController.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.profileController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.profileController.serviceAccountName" -}}
{{- if .Values.profileController.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.profileController.fullname" .) .Values.profileController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.profileController.serviceAccount.name }}
{{- end -}}
{{- end -}}
