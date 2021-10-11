{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.admissionWebhook.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "admission-webhook" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.admissionWebhook.componentLabels" -}}
app.kubernetes.io/component: admission-webhook
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.admissionWebhook.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.admissionWebhook.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.admissionWebhook.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.admissionWebhook.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.admissionWebhook.serviceAccountName" -}}
{{- if .Values.admissionWebhook.serviceAccount.create -}}
    {{ default (include "kubeflow.admissionWebhook.fullname" .) .Values.admissionWebhook.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.admissionWebhook.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kubeflow.admissionWebhook.tls.secretName" -}}
  {{- printf "%s-%s" (include "kubeflow.admissionWebhook.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
