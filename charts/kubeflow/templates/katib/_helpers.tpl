{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.katib.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "katib" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.katib.componentLabels" -}}
app.kubernetes.io/component: katib
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.katib.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.katib.componentLabels" . }}
{{- end -}}
