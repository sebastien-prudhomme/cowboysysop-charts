{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.katib.controller.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "volumes-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kubeflow.katib.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.katib.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.katib.controller.componentLabels" -}}
app.kubernetes.io/component: volumes-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.katib.controller.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.katib.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.katib.controller.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.katib.controller.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.katib.controller.serviceAccountName" -}}
{{- if .Values.katib.controller.serviceAccount.create -}}
    {{ default (include "kubeflow.katib.controller.fullname" .) .Values.katib.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.katib.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kubeflow.katib.controller.tls.secretName" -}}
  {{- printf "%s-%s" (include "kubeflow.katib.controller.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
