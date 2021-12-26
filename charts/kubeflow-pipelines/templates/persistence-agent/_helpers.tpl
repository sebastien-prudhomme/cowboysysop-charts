{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.persistenceAgent.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "persistence-agent" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.persistenceAgent.componentLabels" -}}
app.kubernetes.io/component: persistence-agent
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.persistenceAgent.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.persistenceAgent.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.persistenceAgent.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.persistenceAgent.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.persistenceAgent.serviceAccountName" -}}
{{- if .Values.persistenceAgent.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.persistenceAgent.fullname" .) .Values.persistenceAgent.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.persistenceAgent.serviceAccount.name }}
{{- end -}}
{{- end -}}
