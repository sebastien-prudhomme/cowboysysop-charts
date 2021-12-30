{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.cacheServer.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "cache-server" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.cacheServer.componentLabels" -}}
app.kubernetes.io/component: cache-server
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.cacheServer.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.cacheServer.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.cacheServer.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.cacheServer.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.cacheServer.serviceAccountName" -}}
{{- if .Values.cacheServer.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.cacheServer.fullname" .) .Values.cacheServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.cacheServer.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kubeflow-pipelines.cacheServer.tls.secretName" -}}
  {{- printf "%s-%s" (include "kubeflow-pipelines.cacheServer.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
