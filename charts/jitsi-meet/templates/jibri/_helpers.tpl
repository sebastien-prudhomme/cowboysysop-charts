{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "jitsi-meet.jibri.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jibri" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "jitsi-meet.jibri.componentLabels" -}}
app.kubernetes.io/component: jibri
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.jibri.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jibri.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.jibri.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jibri.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.jibri.serviceAccountName" -}}
{{- if .Values.jibri.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jibri.fullname" .) .Values.jibri.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jibri.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "jitsi-meet.jibri.secretName" -}}
{{- if .Values.jibri.existingSecret -}}
    {{ .Values.jibri.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jibri.fullname" . }}
{{- end -}}
{{- end -}}
