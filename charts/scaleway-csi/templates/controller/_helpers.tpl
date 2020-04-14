{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "scaleway-csi.controller.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.fullname" .) "controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "scaleway-csi.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "scaleway-csi.controller.componentLabels" -}}
app.kubernetes.io/component: controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "scaleway-csi.controller.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "scaleway-csi.controller.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.controller.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "scaleway-csi.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "scaleway-csi.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "scaleway-csi.controller.secretName" -}}
{{- if .Values.controller.existingSecret -}}
    {{ .Values.controller.existingSecret }}
{{- else -}}
    {{ include "scaleway-csi.controller.fullname" . }}
{{- end -}}
{{- end -}}
