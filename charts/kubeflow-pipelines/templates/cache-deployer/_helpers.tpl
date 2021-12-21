{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow-pipelines.cacheDeployer.fullname" -}}
{{- printf "%s-%s" (include "kubeflow-pipelines.fullname" .) "cache-deployer" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow-pipelines.cacheDeployer.componentLabels" -}}
app.kubernetes.io/component: cache-deployer
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow-pipelines.cacheDeployer.labels" -}}
{{ include "kubeflow-pipelines.labels" . }}
{{ include "kubeflow-pipelines.cacheDeployer.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow-pipelines.cacheDeployer.selectorLabels" -}}
{{ include "kubeflow-pipelines.selectorLabels" . }}
{{ include "kubeflow-pipelines.cacheDeployer.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow-pipelines.cacheDeployer.serviceAccountName" -}}
{{- if .Values.cacheDeployer.serviceAccount.create -}}
    {{ default (include "kubeflow-pipelines.cacheDeployer.fullname" .) .Values.cacheDeployer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.cacheDeployer.serviceAccount.name }}
{{- end -}}
{{- end -}}
