{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.tensorboardController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "tensorboard-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kubeflow.tensorboardController.metrics.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.tensorboardController.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.tensorboardController.componentLabels" -}}
app.kubernetes.io/component: tensorboard-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.tensorboardController.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.tensorboardController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.tensorboardController.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.tensorboardController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.tensorboardController.serviceAccountName" -}}
{{- if .Values.tensorboardController.serviceAccount.create -}}
    {{ default (include "kubeflow.tensorboardController.fullname" .) .Values.tensorboardController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.tensorboardController.serviceAccount.name }}
{{- end -}}
{{- end -}}
