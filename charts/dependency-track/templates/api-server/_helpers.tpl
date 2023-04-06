{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "dependency-track.apiServer.fullname" -}}
{{- printf "%s-%s" (include "dependency-track.fullname" .) "api-server" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "dependency-track.apiServer.componentLabels" -}}
app.kubernetes.io/component: api-server
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dependency-track.apiServer.labels" -}}
{{ include "dependency-track.labels" . }}
{{ include "dependency-track.apiServer.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dependency-track.apiServer.selectorLabels" -}}
{{ include "dependency-track.selectorLabels" . }}
{{ include "dependency-track.apiServer.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dependency-track.apiServer.serviceAccountName" -}}
{{- if .Values.apiServer.serviceAccount.create -}}
    {{ default (include "dependency-track.apiServer.fullname" .) .Values.apiServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.apiServer.serviceAccount.name }}
{{- end -}}
{{- end -}}
