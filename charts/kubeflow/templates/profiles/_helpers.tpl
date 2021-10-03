{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.profiles.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "profiles" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.profiles.componentLabels" -}}
app.kubernetes.io/component: profiles
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.profiles.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.profiles.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.profiles.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.profiles.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.profiles.serviceAccountName" -}}
{{- if .Values.profiles.serviceAccount.create -}}
    {{ default (include "kubeflow.profiles.fullname" .) .Values.profiles.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.profiles.serviceAccount.name }}
{{- end -}}
{{- end -}}
