{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.kfservingController.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "kfserving-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kubeflow.kfservingController.metrics.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.kfservingController.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.kfservingController.componentLabels" -}}
app.kubernetes.io/component: kfserving-controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.kfservingController.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.kfservingController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.kfservingController.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.kfservingController.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.kfservingController.serviceAccountName" -}}
{{- if .Values.kfservingController.serviceAccount.create -}}
    {{ default (include "kubeflow.kfservingController.fullname" .) .Values.kfservingController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.kfservingController.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kubeflow.kfservingController.tls.secretName" -}}
  {{- printf "%s-%s" (include "kubeflow.kfservingController.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
