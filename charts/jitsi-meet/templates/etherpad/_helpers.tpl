{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "jitsi-meet.etherpad.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "etherpad" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "jitsi-meet.etherpad.componentLabels" -}}
app.kubernetes.io/component: etherpad
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.etherpad.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.etherpad.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.etherpad.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.etherpad.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.etherpad.serviceAccountName" -}}
{{- if .Values.etherpad.serviceAccount.create -}}
    {{ default (include "jitsi-meet.etherpad.fullname" .) .Values.etherpad.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.etherpad.serviceAccount.name }}
{{- end -}}
{{- end -}}
