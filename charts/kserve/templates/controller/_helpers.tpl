{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kserve.controller.fullname" -}}
{{- printf "%s-%s" (include "kserve.fullname" .) "controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kserve.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "kserve.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kserve.controller.componentLabels" -}}
app.kubernetes.io/component: controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kserve.controller.labels" -}}
{{ include "kserve.labels" . }}
{{ include "kserve.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kserve.controller.selectorLabels" -}}
{{ include "kserve.selectorLabels" . }}
{{ include "kserve.controller.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kserve.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "kserve.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kserve.controller.tls.secretName" -}}
  {{- printf "%s-%s" (include "kserve.controller.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
