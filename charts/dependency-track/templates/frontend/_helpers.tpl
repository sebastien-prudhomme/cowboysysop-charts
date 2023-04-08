{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "dependency-track.frontend.fullname" -}}
{{- printf "%s-%s" (include "dependency-track.fullname" .) "frontend" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "dependency-track.frontend.componentLabels" -}}
app.kubernetes.io/component: frontend
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dependency-track.frontend.labels" -}}
{{ include "dependency-track.labels" . }}
{{ include "dependency-track.frontend.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dependency-track.frontend.selectorLabels" -}}
{{ include "dependency-track.selectorLabels" . }}
{{ include "dependency-track.frontend.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dependency-track.frontend.serviceAccountName" -}}
{{- if .Values.frontend.serviceAccount.create -}}
    {{ default (include "dependency-track.frontend.fullname" .) .Values.frontend.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.frontend.serviceAccount.name }}
{{- end -}}
{{- end -}}
