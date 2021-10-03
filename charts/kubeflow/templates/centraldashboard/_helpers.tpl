{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.centraldashboard.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "centraldashboard" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.centraldashboard.componentLabels" -}}
app.kubernetes.io/component: centraldashboard
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.centraldashboard.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.centraldashboard.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.centraldashboard.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.centraldashboard.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.centraldashboard.serviceAccountName" -}}
{{- if .Values.centraldashboard.serviceAccount.create -}}
    {{ default (include "kubeflow.centraldashboard.fullname" .) .Values.centraldashboard.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.centraldashboard.serviceAccount.name }}
{{- end -}}
{{- end -}}
