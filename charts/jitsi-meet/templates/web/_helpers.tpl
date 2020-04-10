{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "jitsi-meet.web.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "web" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "jitsi-meet.web.componentLabels" -}}
app.kubernetes.io/component: web
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.web.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.web.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.web.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.web.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.web.serviceAccountName" -}}
{{- if .Values.web.serviceAccount.create -}}
    {{ default (include "jitsi-meet.web.fullname" .) .Values.web.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.web.serviceAccount.name }}
{{- end -}}
{{- end -}}
